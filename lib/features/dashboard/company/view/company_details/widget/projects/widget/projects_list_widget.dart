import '../../../../../../../../common_libraries.dart';

class ProjectsListWidget extends StatefulWidget {
  const ProjectsListWidget({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ProjectsListWidgetState();
}

class _ProjectsListWidgetState extends State<ProjectsListWidget> {
  List<String> items = [
    "Artemis Research Center - Cryogenic Lab",
    "Artemis Research Center - Freezer Facility",
    "New HVAC Install Project",
    "Light poles install",
  ];

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    TextStyle valueStyle = textNormal12.copyWith(color: themeData.textColor, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Montserrat');
    return BlocBuilder<CompanyDetailsBloc, CompanyDetailsState>(
      builder: (context, state) {
        return Column(
          children: [
            for (final companies in items)
              CustomBottomBorderContainer(
                padding: insetx16y10,
                alignment: Alignment.centerLeft,
                child: Text(companies, style: valueStyle),
              ),
          ],
        );
      },
    );
  }
}
