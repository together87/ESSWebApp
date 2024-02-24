import '/common_libraries.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({super.key});

  @override
  State<UsersListView> createState() => _UsersListViewState();
}

class _UsersListViewState extends State<UsersListView> {
  List<Information> usersInformationList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usersInformationList = [
      Information(content: "All Aboujoudeh", others: "Safety Professional"),
      Information(content: "Barbara Smart", others: "Global Admin"),
      Information(content: "Carl kitteridge", others: "Site Amid"),
      Information(content: "Harry Berg", others: "Safety Professional"),
      Information(content: "Nora Eddington", others: "CM Safefy Rep"),
      Information(content: "Oscar Peterman", others: "Contractor Safety Rep"),
      Information(content: "Peter Perrine", others: "Construction Operations"),
      Information(content: "Rusty Abner", others: "Safety Professional"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    TextStyle valueStyle = textNormal12.copyWith(color: themeData.textColor, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Montserrat');
    return BlocBuilder<SiteDetailsBloc, SiteDetailsState>(builder: (context, state) {
      return Column(
        children: [
          for (final companies in usersInformationList)
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
