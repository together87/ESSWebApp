import '/common_libraries.dart';

class CompaniesListView extends StatefulWidget {
  const CompaniesListView({super.key});

  @override
  State<CompaniesListView> createState() => _CompaniesListViewState();
}

class _CompaniesListViewState extends State<CompaniesListView> {
  List<Information> companyInformationList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    companyInformationList = [
      Information(content: "Power Tools& Roofing LLC"),
      Information(content: "Galelio Weather Services Inc"),
      Information(content: "Geprgoia Concrete"),
      Information(content: "Kashi Inc"),
      Information(content: "Logistic and Manpower Placements LLC"),
      Information(content: "Maxwell and Gather Inc"),
      Information(content: "Runkin Associstes Glassworks Inc"),
      Information(content: "zodiac Builders Inc"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    TextStyle valueStyle = textNormal12.copyWith(color: themeData.textColor, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Montserrat');
    return BlocBuilder<SiteDetailsBloc, SiteDetailsState>(builder: (context, state) {
      return Column(
        children: [
          for (final companies in companyInformationList)
            CustomBottomBorderContainer(
              padding: insetx16y10,
              alignment: Alignment.centerLeft,
              child: Text(companies.content!, style: valueStyle),
            ),
        ],
      );
    });
  }
}
