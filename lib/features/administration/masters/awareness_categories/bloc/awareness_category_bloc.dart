import 'dart:async';



import '../../../../../common_libraries.dart';
import '../data/model/awareness_category_response.dart';
import '../data/repository/awareness_category_repository.dart';
import 'awareness_category_event.dart';
import 'awareness_category_state.dart';

class AwarenessCategoryBloc extends Bloc<AwarenessCategoryEvents, AwarenessCategoryState> {
  final AwarenessCategoryRepository awarenessCategoryRepository;

  AwarenessCategoryBloc({required this.awarenessCategoryRepository})
      : super(const AwarenessCategoryState()) {
    _triggerEvents();
  }

  void _triggerEvents() {
    on<CreateNewAwarenessCategoryEvent>(_onCreateNewAwarenessCategoryEvent);
    on<PageChangeEvent>(_onPageChangeEvent);
    on<UpdateAwarenessCategoryEvent>(_onUpdateAwarenessCategoryEvent);
    on<AwarenessCategorySelectedEvent>(_onAwarenessCategorySelectedEvent);
    on<DeleteAwarenessCategoryEvent>(_onDeleteAwarenessCategoryEvent);
    on<AwarenessCategoryLoadingEvent>(_onAwarenessCategoryLoadingEvent);
    on<GetAwarenessCategoryByIdEvent>(_ongetAwarenessCategoryByIdEvent);
    on<CreateAwarenessCategoryEvent>(_onCreateAwarenessCategoryEvent);
  }

  FutureOr<void> _onCreateNewAwarenessCategoryEvent(
      CreateNewAwarenessCategoryEvent event,
      Emitter<AwarenessCategoryState> emit) async {
    emit(state.copyWith(
      crudStatus: EntityStatus.loading,
      page: 0,
    ));
    try {
      EntityResponse response =
          await awarenessCategoryRepository.createAwarenessCategory(event.awarenessCategory);
      if (response.isSuccess) {
        List<AwarenessCategory> awarenessCategoryList =
            await awarenessCategoryRepository.getAllAwarenessCategorys();
        emit(state.copyWith(
          awarenessCategoryList: awarenessCategoryList,
          selectedAwarenessCategory: awarenessCategoryList.first,
          crudStatus: EntityStatus.success,
          message: response.message,
        ));
      } else {
        emit(state.copyWith(
          awarenessCategoryList: null,
          selectedAwarenessCategory: null,
          message: response.message,
          crudStatus: EntityStatus.failure,
          page: 1,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        awarenessCategoryList: const [],
        selectedAwarenessCategory: null,
        message: e.toString(),
        crudStatus: EntityStatus.failure,
        page:1,
      ));
    }
  }

  FutureOr<void> _onPageChangeEvent(
      PageChangeEvent event, Emitter<AwarenessCategoryState> emit) {
   emit(state.copyWith(
      crudStatus: EntityStatus.loading,
      page: 0,
    ));
    try {
      emit(state.copyWith(
        page: event.page,
        crudStatus: EntityStatus.success,
        selectedAwarenessCategory: event.awarenessCategory,
      ));
    } catch (e) {
      emit(state.copyWith(
        page: 0,
        message: e.toString(),
        selectedAwarenessCategory: null,
        crudStatus: EntityStatus.failure,
      ));
    }
  }

  FutureOr<void> _onUpdateAwarenessCategoryEvent(
      UpdateAwarenessCategoryEvent event, Emitter<AwarenessCategoryState> emit) async {
   emit(state.copyWith(
      crudStatus: EntityStatus.loading,
      page: 0,
    ));
    try {
      EntityResponse response =
          await awarenessCategoryRepository.updateAwarenessCategory(event.awarenessCategory);
      if (response.isSuccess) {
        List<AwarenessCategory> awarenessCategoryList =
            await awarenessCategoryRepository.getAllAwarenessCategorys();
        emit(state.copyWith(
          awarenessCategoryList: awarenessCategoryList,
          selectedAwarenessCategory: event.awarenessCategory,
          crudStatus: EntityStatus.success,
          message: response.message,
          page: 0,
        ));
      } else {
        emit(state.copyWith(
          awarenessCategoryList: null,
          selectedAwarenessCategory: null,
          message: response.message,
          crudStatus: EntityStatus.failure,
          page: 2,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        awarenessCategoryList: const [],
        selectedAwarenessCategory: null,
        message: e.toString(),
        crudStatus: EntityStatus.failure,
        page: 2,
      ));
    }
  }

  FutureOr<void> _onAwarenessCategorySelectedEvent(
      AwarenessCategorySelectedEvent event, Emitter<AwarenessCategoryState> emit) {
        try {
      emit(state.copyWith(
        selectedAwarenessCategory: event.awarenessCategory,
        crudStatus: EntityStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        selectedAwarenessCategory: null,
        crudStatus: EntityStatus.failure,
        message: e.toString(),
      ));
    }
  }

  FutureOr<void> _onDeleteAwarenessCategoryEvent(
      DeleteAwarenessCategoryEvent event, Emitter<AwarenessCategoryState> emit) async {
    emit(state.copyWith(
      crudStatus: EntityStatus.loading,
      page: 0,
    ));
    try {
      EntityResponse response =
          await awarenessCategoryRepository.deleteAwarenessCategory(event.id);
      if (response.isSuccess) {
        emit(state.copyWith(
          crudStatus: EntityStatus.success,
          message: response.message,
          page: 0,
        ));
        add(AwarenessCategoryLoadingEvent());
      } else {
        emit(state.copyWith(
          awarenessCategoryList: null,
          selectedAwarenessCategory: null,
          message: response.message,
          crudStatus: EntityStatus.failure,
          page: 3,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        awarenessCategoryList: null,
        selectedAwarenessCategory: null,
        message: e.toString(),
        crudStatus: EntityStatus.failure,
        page: 3,
      ));
      debugPrint("Error while deleting Awareness Category : $e");
    }
  }

  FutureOr<void> _onAwarenessCategoryLoadingEvent(
      AwarenessCategoryLoadingEvent event, Emitter<AwarenessCategoryState> emit) async {
   emit(state.copyWith(crudStatus: EntityStatus.loading));
    try {
      List<AwarenessCategory> awarenessCategoryList =
          await awarenessCategoryRepository.getAllAwarenessCategorys();
      if (awarenessCategoryList.isNotEmpty) {
        emit(state.copyWith(
          page: 0,
          awarenessCategoryList: awarenessCategoryList,
          selectedAwarenessCategory: awarenessCategoryList.first,
          crudStatus: EntityStatus.success,
        ));
      } else {
        emit(state.copyWith(
          page: 0,
          awarenessCategoryList: const [],
          selectedAwarenessCategory: null,
          crudStatus: EntityStatus.failure,
        ));

      }
    } catch (e) {
      emit(state.copyWith(
        page: 0,
        crudStatus: EntityStatus.failure,
        message: e.toString(),
      ));
      debugPrint("Error while loading all Awareness Categories: $e");
    }
  }

  FutureOr<void> _ongetAwarenessCategoryByIdEvent(
      GetAwarenessCategoryByIdEvent event, Emitter<AwarenessCategoryState> emit) async {
    
  }

  FutureOr<void> _onCreateAwarenessCategoryEvent(
      CreateAwarenessCategoryEvent event, Emitter<AwarenessCategoryState> emit) async {
    emit(state.copyWith(
          page: event.page,
        ));
  }

}
