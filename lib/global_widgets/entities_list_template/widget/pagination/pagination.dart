import '/common_libraries.dart';

class PaginationView extends StatefulWidget {
  final void Function(int selectedPageNum) onPaginate;
  final int totalRows;
  const PaginationView({
    super.key,
    required this.onPaginate,
    required this.totalRows,
  });

  @override
  State<PaginationView> createState() => _PaginationViewState();
}

class _PaginationViewState extends State<PaginationView> {
  late PaginationBloc paginationBloc;

  @override
  void initState() {
    paginationBloc = context.read()..add(PaginationInit());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.totalRows <= 0) {
      return Container();
    }
    return BlocBuilder<PaginationBloc, PaginationState>(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MediaQuery.of(context).size.width < 576.0
                ? NumberPaginator(
                    config: const NumberPaginatorUIConfig(buttonUnselectedForegroundColor: Colors.black),
                    controller: state.numberpagecontroller,
                    numberPages: widget.totalRows,
                    onPageChange: (value) {
                      setState(() {
                        widget.onPaginate(state.selectedPageNum);
                      });
                    },
                    initialPage: state.selectedPageNum,
                  )
                : MediaQuery.of(context).size.width < 768.0
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: NumberPaginator(
                          config: const NumberPaginatorUIConfig(buttonUnselectedForegroundColor: Colors.black),
                          controller: state.numberpagecontroller,
                          numberPages: widget.totalRows,
                          onPageChange: (value) {
                            setState(() {
                              widget.onPaginate(state.selectedPageNum);
                            });
                          },
                          initialPage: state.selectedPageNum,
                        ),
                      )
                    : MediaQuery.of(context).size.width < 992.0
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: NumberPaginator(
                              config: const NumberPaginatorUIConfig(buttonUnselectedForegroundColor: Colors.black),
                              controller: state.numberpagecontroller,
                              numberPages: widget.totalRows,
                              onPageChange: (value) {
                                setState(() {
                                  widget.onPaginate(state.selectedPageNum);
                                });
                              },
                              initialPage: state.selectedPageNum,
                            ),
                          )
                        : SizedBox(
                            width: MediaQuery.of(context).size.width / 4,
                            child: NumberPaginator(
                              config: const NumberPaginatorUIConfig(buttonUnselectedForegroundColor: Colors.black),
                              controller: state.numberpagecontroller,
                              numberPages: widget.totalRows,
                              onPageChange: (value) {
                                setState(() {
                                  widget.onPaginate(state.selectedPageNum);
                                });
                              },
                              initialPage: state.selectedPageNum,
                            ),
                          ),
          ],
        ),
      );
    });
  }
}
