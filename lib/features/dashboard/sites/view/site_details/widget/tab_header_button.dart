import 'package:ecosys_safety/common_libraries.dart';

class TabHeaderView extends StatefulWidget {
  const TabHeaderView({super.key});

  @override
  State<TabHeaderView> createState() => _TabHeaderViewState();
}

class _TabHeaderViewState extends State<TabHeaderView> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<SiteDetailsBloc, SiteDetailsState>(builder: (context, state) {
      return state.view == "1"
          ? ElevatedButton(
              onPressed: () {
                context.read<SiteDetailsBloc>().add(SiteDetailsTabSubViewChanged(view: "2"));
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
                context.read<SiteDetailsBloc>().add(SiteDetailsTabSubViewChanged(view: "1"));
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
              ));
    });
  }
}
