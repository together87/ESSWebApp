import '../../../../../../../../common_libraries.dart';
import '/constants/dimens.dart';

class ProjectsDragDropWidget extends StatefulWidget {
  final double width;
  const ProjectsDragDropWidget({
    required this.width,
    super.key,
  });

  @override
  State<ProjectsDragDropWidget> createState() => _ProjectsDragDropState();
}

class _ProjectsDragDropState extends State<ProjectsDragDropWidget>
    with TickerProviderStateMixin {
  List<String> projectInformationList = [];

  @override
  void initState() {
    // TODO: implement initState
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
    final themeData = Theme.of(context);
    return BlocBuilder<SiteDetailsBloc, SiteDetailsState>(
        builder: (context, state) {
      return DragAndDropWidget(
          informationList1: projectInformationList,
          informationList2: projectInformationList,
          header1: "Associated Projects",
          header2:"Available Projects",
          listWidth: widget.width,
          );
    });
  }
}
