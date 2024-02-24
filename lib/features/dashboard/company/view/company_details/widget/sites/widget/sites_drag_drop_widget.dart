import '../../../../../../../../common_libraries.dart';

class SitesDragDropWidget extends StatefulWidget {
  final double width;
  const SitesDragDropWidget({
    required this.width,
    super.key,
  });

  @override
  State<SitesDragDropWidget> createState() => _SitesDragDropState();
}

class _SitesDragDropState extends State<SitesDragDropWidget> with TickerProviderStateMixin {
  List<String> projectInformationList = [];

  @override
  void initState() {
    super.initState();
    projectInformationList = [
      'Artemis Research Center - Cryogenic Lab',
      'Artemis Research Center - Freezer Facility',
      'New HVAC Install Project',
      'Light poles install',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SiteDetailsBloc, SiteDetailsState>(builder: (context, state) {
      return DragAndDropWidget(
        informationList1: projectInformationList,
        informationList2: projectInformationList,
        header1: "Associated Projects",
        header2: "Available Projects",
        listWidth: widget.width,
      );
    });
  }
}
