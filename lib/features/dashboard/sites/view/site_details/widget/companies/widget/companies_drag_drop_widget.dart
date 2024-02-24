import '../../../../../../../../common_libraries.dart';
import '/constants/dimens.dart';

class CompaniesDragDropWidget extends StatefulWidget {
  final double width;
  const CompaniesDragDropWidget({
    required this.width,
    super.key,
  });

  @override
  State<CompaniesDragDropWidget> createState() => _CompaniesDragDropState();
}

class _CompaniesDragDropState extends State<CompaniesDragDropWidget>
    with TickerProviderStateMixin {
  List<String> companiesInformationList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    companiesInformationList = [
      "Power Tools& Roofing LLC",
      "Galelio Weather Services Inc",
      "Geprgoia Concrete",
      "Kashi Inc",
      "Logistic and Manpower Placements LLC",
      "Maxwell and Gather Inc",
      "Runkin Associstes Glassworks Inc",
      "zodiac Builders Inc",
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<SiteDetailsBloc, SiteDetailsState>(
        builder: (context, state) {
      return DragAndDropWidget(
          informationList1: companiesInformationList,
          informationList2: companiesInformationList,
          header1: "Associated Companies",
          header2:"Available Companies",
          listWidth: widget.width,
          );
    });
  }
}
