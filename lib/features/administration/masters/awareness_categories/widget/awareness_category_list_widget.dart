import 'package:ecosys_safety/features/administration/masters/awareness_categories/bloc/awareness_category_event.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../common_libraries.dart';
import '../bloc/awareness_category_bloc.dart';
import '../bloc/awareness_category_state.dart';

class AwarenessCategoryListWidget extends StatefulWidget {
  double dataTableWidth;

  AwarenessCategoryListWidget({
    super.key,
    required this.awarenessCategoryController,
    required this.awarenessCategoryUpdateController,
    required this.dataTableWidth,
  });

  final TextEditingController awarenessCategoryUpdateController;
  final TextEditingController awarenessCategoryController;

  @override
  State<StatefulWidget> createState() => _AwarenessCategoryListWidgetState();
}

class _AwarenessCategoryListWidgetState extends State<AwarenessCategoryListWidget> {
  DataGridController dataGridController = DataGridController();
  int selectedIndex = -1;
  double idBoxSize = 80.0;

  List<String> get tableColumns {
    return const [
      AppStrings.id,
      AppStrings.awarenessCategory,
      AppStrings.actions,
    ];
  }

  @override
  Widget build(BuildContext context) {
    //  widget.priorityTypeController.text = "";
    final themeData = Theme.of(context);
    return BlocBuilder<AwarenessCategoryBloc, AwarenessCategoryState>(
      builder: (context, state) {
        return DataTable(
            showCheckboxColumn: false,
            dividerThickness: 0,
            columns: [
              DataColumn(
                  label: Text(
                tableColumns[0],
                style: textSemiBold14,
              )),
              DataColumn(
                  label: Text(
                tableColumns[1],
                style: textSemiBold14,
              )),
              DataColumn(
                  label: Expanded(
                      child: Text(
                tableColumns[2],
                style: textSemiBold14,
                textAlign: TextAlign.center,
              ))),
            ],
            rows: List.generate(
                state.awarenessCategoryList.length,
                (index) => DataRow.byIndex(
                    color: MaterialStateColor.resolveWith((states) {
                      return index == selectedIndex ? bluePageHeader : Colors.white; //make tha magic!
                    }),
                    index: index,
                    cells: [
                      DataCell(SizedBox(
                        width: idBoxSize,
                        child: Text("${index + 1}"),
                      )),
                      DataCell(
                        state.awarenessCategoryList[index].name!.length > 30
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: (widget.dataTableWidth - 560 - idBoxSize) * 0.9,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Tooltip(
                                        message: "${state.awarenessCategoryList[index].name}",
                                        preferBelow: false,
                                        height: 30,
                                        textAlign: TextAlign.justify,
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Color.fromARGB(255, 255, 255, 255),
                                        ),
                                        child: Text(
                                          "${state.awarenessCategoryList[index].name}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: (widget.dataTableWidth - 560 - idBoxSize) * 0.1,
                                  )
                                ],
                              )
                            : SizedBox(
                                width: (widget.dataTableWidth - 560 - idBoxSize),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Text("${state.awarenessCategoryList[index].name}"),
                                ),
                              ),
                      ),
                      DataCell(Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                widget.awarenessCategoryUpdateController.text = state.awarenessCategoryList[index].name!;
                                context.read<AwarenessCategoryBloc>().add(PageChangeEvent(page: 2, awarenessCategory: state.awarenessCategoryList[index]));
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.pen,
                                color: Colors.green,
                                size: 15,
                              )),
                          spacery10,
                          IconButton(
                              onPressed: () {
                                context.read<AwarenessCategoryBloc>().add(PageChangeEvent(page: 3, awarenessCategory: state.awarenessCategoryList[index]));
                              },
                              icon: const FaIcon(FontAwesomeIcons.trashCan, color: Colors.red, size: 15))
                        ],
                      )),
                    ],
                    selected: selectedIndex == index,
                    onSelectChanged: (isSelected) {
                      setState(() {
                        selectedIndex = index;
                      });
                      context.read<AwarenessCategoryBloc>().add(AwarenessCategorySelectedEvent(awarenessCategory: state.awarenessCategoryList[index]));
                      //state.subRegionList[index].isSelected = true;
                    })),
            showBottomBorder: true,
            border: null,
            headingTextStyle: TextStyle(
                color: black,
                //fontFamily: 'Poppins,sans-serif',
                fontWeight: FontWeight.w700));
      },
    );
  }
}
