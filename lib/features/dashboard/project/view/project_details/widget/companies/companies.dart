import '/common_libraries.dart';
import 'widget/widget.dart';

class TabCompaniesView extends StatefulWidget {
  final String? projectId;
  const TabCompaniesView(this.projectId, {super.key});

  @override
  State<TabCompaniesView> createState() => _TabCompaniesViewState();
}

class _TabCompaniesViewState extends State<TabCompaniesView> {
  @override
  void initState() {
    context.read<ProjectDetailsBloc>().add(ProjectDetailsCompaniesListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(builder: (context, state) {
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
                        text: "Associated Companies\t",
                        style: textNormal12.copyWith(color: themeData.textColor, fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
                      ),
                      TextSpan(text: "(8 total)", style: textNormal12.copyWith(color: themeData.textColor, fontSize: 11, fontWeight: FontWeight.w400, fontFamily: 'Montserrat'))
                    ]),
                  ),
                ),
                state.view == "1"
                    ? ElevatedButton(
                        onPressed: () {
                          context.read<ProjectDetailsBloc>().add(ProjectDetailsCompaniesViewChanged(view: "2"));
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: buttonFocusColor,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0), // Set the border radius as desired
                              side: BorderSide(color: buttonFocusColor, width: 1.2), // Set the border color and width
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16 * 1.1, horizontal: 16 - 4),
                            shadowColor: Colors.transparent),
                        child: Row(
                          children: [
                            Text(
                              'Association',
                              style: themeData.textTheme.labelMedium!.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            spacerx10,
                            const FaIcon(
                              FontAwesomeIcons.arrowRight,
                              size: 15,
                            ),
                          ],
                        ))
                    : ElevatedButton(
                        onPressed: () {
                          context.read<ProjectDetailsBloc>().add(ProjectDetailsCompaniesViewChanged(view: "1"));
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: buttonFocusColor,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0), // Set the border radius as desired
                              side: BorderSide(color: buttonFocusColor, width: 1.2), // Set the border color and width
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16 * 1.1, horizontal: 16 - 4),
                            shadowColor: Colors.transparent),
                        child: Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.arrowLeft,
                              size: 15,
                            ),
                            spacerx8,
                            Text(
                              'Back to list',
                              style: themeData.textTheme.labelMedium!.copyWith(fontSize: 13, fontWeight: FontWeight.w600, fontFamily: 'Montserrat'),
                            )
                          ],
                        )),
              ],
            ),
          ),
          state.view == "1" ? CompaniesListView() : AssociatedChangeView(),
        ],
      );
    });
  }
}
