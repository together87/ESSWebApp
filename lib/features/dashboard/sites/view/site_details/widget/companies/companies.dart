import '../tab_header_button.dart';
import '/common_libraries.dart';
import 'widget/widget.dart';

class TabCompaniesView extends StatefulWidget {
  final String siteId;
  final String title;
  const TabCompaniesView(
    this.siteId,
    this.title, {
    super.key,
  });

  @override
  State<TabCompaniesView> createState() => _TabCompaniesViewState();
}

class _TabCompaniesViewState extends State<TabCompaniesView> {
  @override
  void initState() {
    super.initState();
    context.read<SiteDetailsBloc>().add(SiteDetailsTabSubViewChanged(view: "1"));
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<SiteDetailsBloc, SiteDetailsState>(builder: (context, state) {
      return Column(
        children: [
          CustomBottomBorderContainer(
            padding: insetx16y10,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Associated ${widget.title}\t",
                        style: textNormal12.copyWith(color: themeData.textColor, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
                      ),
                      TextSpan(text: "(8 total)", style: textNormal12.copyWith(color: themeData.textColor, fontSize: 11, fontWeight: FontWeight.w400, fontFamily: 'Montserrat'))
                    ]),
                  ),
                ),
                const TabHeaderView(),
              ],
            ),
          ),
          state.view == "1" ? const CompaniesListView() :
           SizedBox(
            height: 300,
            child: CompaniesDragDropWidget(width: (MediaQuery.of(context).size.width - 380)/2,))
        ],
      );
    });
  }
}
