import '/common_libraries.dart';

class CompaniesListView extends StatelessWidget {
  const CompaniesListView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    TextStyle valueStyle = textNormal12.copyWith(color: themeData.textColor, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Montserrat');
    return BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(builder: (context, state) {
      return Column(
        children: [
          for (final companies in state.companiesList)
            CustomBottomBorderContainer(
              padding: insetx16y10,
              alignment: Alignment.centerLeft,
              child: Text(companies, style: valueStyle),
            ),
        ],
      );
    });
  }
}
