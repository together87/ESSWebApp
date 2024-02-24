import '../../../../../../../../common_libraries.dart';
import '/constants/dimens.dart';

class TemplatesDragDropWidget extends StatefulWidget {
  final double width;
  const TemplatesDragDropWidget({
    required this.width,
    super.key,
  });

  @override
  State<TemplatesDragDropWidget> createState() => _TemplatesDragDropState();
}

class _TemplatesDragDropState extends State<TemplatesDragDropWidget>
    with TickerProviderStateMixin {
  List<String> templatesInformationList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    templatesInformationList = [
      "Hygiene and Food Supply Audit",
      "Parking anti freeze conditions",
      "Signage and guidance audit",
      "Storage facility Fire Hazard Audit",
      "Lab Hygiene and Waste Disposal Audit",
      "HVAC and Environment Audit",
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<SiteDetailsBloc, SiteDetailsState>(
        builder: (context, state) {
      return DragAndDropWidget(
          informationList1: templatesInformationList,
          informationList2: templatesInformationList,
          header1: "Associated Templates",
          header2:"Available Templates",
          listWidth: widget.width,
          );
    });
  }
}
