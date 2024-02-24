import '../tab_header_button.dart';
import '/common_libraries.dart';
import 'widget/widget.dart';

class TabProjectView extends StatefulWidget {
  final String companyId;
  final String title;
  const TabProjectView(
    this.companyId,
    this.title, {
    super.key,
  });

  @override
  State<TabProjectView> createState() => _TabProjectViewState();
}

class _TabProjectViewState extends State<TabProjectView> {
  @override
  void initState() {
    super.initState();
    context.read<CompanyDetailsBloc>().add(CompanyDetailsTabSubViewChanged(view: "1"));
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<CompanyDetailsBloc, CompanyDetailsState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      TextSpan(
                          text: "(8 total)",
                          style:
                              textNormal12.copyWith(color: themeData.textColor, fontSize: 11, fontWeight: FontWeight.w400, fontFamily: 'Montserrat'))
                    ]),
                  ),
                ),
                const TabHeaderView(),
              ],
            ),
          ),
          state.view == "1"
              ? const ProjectsListWidget()
              : SizedBox(
                  height: 200,
                  child: ProjectsDragDropWidget(
                    width: (MediaQuery.of(context).size.width - 380) / 2,
                  ))
        ],
      );
    });
  }
}
