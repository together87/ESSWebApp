
import '../../../../../common_libraries.dart';
import '../data/model/awareness_category_response.dart';

class AwarenessCategoryState extends Equatable {
  final List<AwarenessCategory> awarenessCategoryList;
  final EntityStatus? crudStatus;
  final AwarenessCategory? selectedAwarenessCategory;
  final int? page;
  final String message;
  final bool statechange;
  const AwarenessCategoryState(
      {this.awarenessCategoryList = const [],
      this.crudStatus = EntityStatus.initial,
      this.selectedAwarenessCategory,
      this.page = 0,
      this.statechange = true,
      this.message = ''});

  @override
  List<Object?> get props => [
        awarenessCategoryList,
        crudStatus,
        selectedAwarenessCategory,
        page,
        statechange,
        message
      ];

  AwarenessCategoryState copyWith(
      {List<AwarenessCategory>? awarenessCategoryList,
      EntityStatus? crudStatus,
      AwarenessCategory? selectedAwarenessCategory,
      int? page,
      bool? statechange,
      String? message}) {
    return AwarenessCategoryState(
        awarenessCategoryList: awarenessCategoryList ?? this.awarenessCategoryList,
      
        crudStatus: crudStatus ?? this.crudStatus,
        selectedAwarenessCategory:
            selectedAwarenessCategory??this.selectedAwarenessCategory ,
  
        page: page ?? this.page,
        statechange: statechange ?? this.statechange,
        message: message ?? '');
  }
}
