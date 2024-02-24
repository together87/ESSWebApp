
import '../../../../../common_libraries.dart';
import '../data/model/awareness_category_response.dart';

class AwarenessCategoryEvents extends Equatable {
  @override
  List<Object?> get props => [];
}


class CreateNewAwarenessCategoryEvent extends AwarenessCategoryEvents {
  final int page;
  AwarenessCategory awarenessCategory;

  CreateNewAwarenessCategoryEvent(
      {required this.page, required this.awarenessCategory});
}

class PageChangeEvent extends AwarenessCategoryEvents {
  final int page;
  AwarenessCategory? awarenessCategory;

  PageChangeEvent({required this.page, this.awarenessCategory});
}

class UpdateAwarenessCategoryEvent extends AwarenessCategoryEvents {
  final int page;
  AwarenessCategory awarenessCategory;

  UpdateAwarenessCategoryEvent({required this.page, required this.awarenessCategory});
}

class AwarenessCategorySelectedEvent extends AwarenessCategoryEvents {
  AwarenessCategory awarenessCategory;

  AwarenessCategorySelectedEvent({required this.awarenessCategory});
}

class DeleteAwarenessCategoryEvent extends AwarenessCategoryEvents {
  final int page;
  int id;

  DeleteAwarenessCategoryEvent({required this.page, required this.id});
}

class AwarenessCategoryLoadingEvent extends AwarenessCategoryEvents {}

class GetAwarenessCategoryByIdEvent extends AwarenessCategoryEvents {
  int? id;

  GetAwarenessCategoryByIdEvent({required this.id});
}

class CreateAwarenessCategoryEvent extends AwarenessCategoryEvents {
  final int page;
  CreateAwarenessCategoryEvent({required this.page});
}
