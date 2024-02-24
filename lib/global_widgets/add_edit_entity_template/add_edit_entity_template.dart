import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:strings/strings.dart';

import '/common_libraries.dart';

class AddEditEntityTemplate extends StatefulWidget {
  final String label;
  final String cancelPath;
  final IconData iconData;
  final String? id;
  final Widget child;
  final String? addButtonName;
  final String? editButtonName;
  final VoidCallback addEntity;
  final VoidCallback editEntity;
  final EntityStatus crudStatus;
  final String screenName;
  final String screenNameOne;
  final String screenNameTwo;

  const AddEditEntityTemplate({
    super.key,
    required this.label,
    required this.iconData,
    required this.cancelPath,
    this.id,
    required this.child,
    this.addButtonName,
    this.editButtonName,
    required this.addEntity,
    required this.editEntity,
    this.crudStatus = EntityStatus.initial,
    required this.screenName,
    required this.screenNameOne,
    required this.screenNameTwo,
  });

  @override
  State<AddEditEntityTemplate> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddEditEntityTemplate> {
  String token = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) => setState(() => token = state.authUser?.token ?? ''),
      listenWhen: (previous, current) => previous.authUser?.token != current.authUser?.token,
      builder: (context, state) {
        token = state.authUser?.token ?? '';
        return PublicMasterLayout(
          body: Padding(
            padding: inset16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenTitle(backClick: goToList, backButtonShow: true, iconData: widget.iconData, screenName: widget.screenName, screenNameOne: widget.screenNameOne, screenNameTwo: widget.screenNameTwo),
                spacery10,
                Expanded(
                    child: SingleChildScrollView(
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        spacery10,
                        widget.child,
                        Padding(
                          padding: insetx16,
                          child: Row(
                            children: [
                              _buildAddEditButton(),
                              spacerx10,
                              _buildCancelButton(),
                            ],
                          ),
                        ),
                        spacery10,
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }

  goToList() {
    String location = GoRouter.of(context).location;
    if (widget.id == null) {
      location = location.replaceAll('new', '');
    } else {
      location = location.replaceRange(location.indexOf('edit'), null, '');
    }
    GoRouter.of(context).go(location);
  }

  Widget _buildAddEditButton() {
    return widget.crudStatus.isLoading
        ? CustomButton(
            backgroundColor: primaryColor,
            disabled: true,
            body: LoadingAnimationWidget.prograssiveDots(
              color: Colors.white,
              size: 22,
            ),
          )
        : CustomButton(
            backgroundColor: primaryColor,
            text: widget.id == null ? widget.addButtonName ?? camelize(widget.label) : widget.editButtonName ?? camelize(widget.label),
            onClick: () {
              if (widget.id != null) {
                widget.editEntity();
              } else {
                widget.addEntity();
              }
            },
            textStyle: textNormal14.copyWith(color: Colors.white),
          );
  }

  Widget _buildCancelButton() {
    return CustomButton(
      backgroundColor: cancelColor,
      text: "Cancel",
      textStyle: textNormal14.copyWith(color: Colors.black),
      onClick: () {
        context.go('/${widget.cancelPath}');
      },
    );
  }
}
