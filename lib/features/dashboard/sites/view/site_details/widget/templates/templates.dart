import 'package:ecosys_safety/features/dashboard/sites/view/site_details/widget/templates/widget/templates_drag_drop_widget.dart';

import '../tab_header_button.dart';
import '/common_libraries.dart';
import 'widget/widget.dart';

class TabTemplatesView extends StatefulWidget {
  final String siteId;
  final String title;
  const TabTemplatesView(
    this.siteId,
    this.title, {
    super.key,
  });

  @override
  State<TabTemplatesView> createState() => _TabTemplatesViewState();
}

class _TabTemplatesViewState extends State<TabTemplatesView> {
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
                TabHeaderView(),
              ],
            ),
          ),
          state.view == "1"
              ? const TemplatesListWidget()
              : SizedBox(height: 300,
                  child: TemplatesDragDropWidget(width: (MediaQuery.of(context).size.width - 380) / 2,))
        ],
      );
    });
  }
}
