part of 'pagination_bloc.dart';

class PaginationState extends Equatable {
  final int selectedPageNum;
  final int rowsPerPage;
  final NumberPaginatorController? numberpagecontroller;

  const PaginationState({
    this.selectedPageNum = 0,
    this.rowsPerPage = initialRowsPerPage,
    this.numberpagecontroller,
  });

  @override
  List<Object> get props => [
        selectedPageNum,
        rowsPerPage,
      ];

  PaginationState copyWith({
    int? selectedPageNum,
    int? rowsPerPage,
    NumberPaginatorController? numberPagecontroller,
  }) {
    return PaginationState(
      selectedPageNum: selectedPageNum ?? this.selectedPageNum,
      rowsPerPage: rowsPerPage ?? this.rowsPerPage,
      numberpagecontroller: numberPagecontroller ?? this.numberpagecontroller,
    );
  }
}
