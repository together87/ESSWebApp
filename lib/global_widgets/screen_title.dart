import '/common_libraries.dart';

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key, this.backClick, this.addButtonShow = false, this.backButtonShow = false, required this.iconData, required this.screenName, this.screenNameOne, this.screenNameTwo, this.screenNameThree});
  final String screenName;
  final String? screenNameOne;
  final String? screenNameTwo;
  final String? screenNameThree;
  final IconData iconData;
  final bool backButtonShow;
  final bool addButtonShow;
  final VoidCallback? backClick;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Padding(
              padding: insety10,
              child: Container(
                padding: inset4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: white,
                ),
                child: FaIcon(
                  iconData,
                  size: 15,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            spacerx8,
            Text(
              screenName,
              style: themeData.textTheme.labelMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            ),
          ],
        ),
        Row(
          children: [
            if (backButtonShow)
              ElevatedButton(
                  onPressed: () {
                    backClick!();
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
                        style: themeData.textTheme.labelMedium!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      )
                    ],
                  )),
            if (addButtonShow)
              CustomButton(
                backgroundColor: successColor,
                iconData: FontAwesomeIcons.plus,
                text: "Add New",
                onClick: () {
                  String location = GoRouter.of(context).location;
                  int index = location.indexOf('/index');
                  if (index != -1) {
                    location = location.replaceRange(index, null, '');
                  }
                  GoRouter.of(context).go('$location/new');
                },
                textStyle: textNormal14.copyWith(color: Colors.white),
              ),

            // Text(
            //   screenNameOne ?? '',
            //   style: themeData.textTheme.labelMedium!.copyWith(
            //     fontSize: 12,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
            // Text(
            //   screenNameTwo ?? '',
            //   style: themeData.textTheme.labelMedium!.copyWith(
            //     fontSize: 12,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
            // Text(
            //   screenNameThree ?? '',
            //   style: themeData.textTheme.labelMedium!.copyWith(
            //     fontSize: 12,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),
          ],
        )
      ],
    );
  }
}
