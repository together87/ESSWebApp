import '../../../../../../../../common_libraries.dart';
import '/constants/dimens.dart';

class UserDragDropWidget extends StatefulWidget {
  final double width;
  const UserDragDropWidget({
    required this.width,
    super.key,
  });

  @override
  State<UserDragDropWidget> createState() => _UserDragDropState();
}

class _UserDragDropState extends State<UserDragDropWidget>
    with TickerProviderStateMixin {
  List<String> userInformationList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userInformationList = [
      "All Aboujoudeh     Safety Professional",
      "Barbara Smart     Global Admin",
      "Carl kitteridge     Site Amid",
      "Harry Berg      Safety Professional",
      "Nora Eddington     CM Safefy Rep",
      "Oscar Peterman     Contractor Safety Rep",
      "Peter Perrine     Construction Operations",
      "Rusty Abner     Safety Professional",
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<SiteDetailsBloc, SiteDetailsState>(
        builder: (context, state) {
      return DragAndDropWidget(
          informationList1: userInformationList,
          informationList2: userInformationList,
          header1: "Associated Users",
          header2:"Available Users",
          listWidth: widget.width,
          );
    });
  }
}
