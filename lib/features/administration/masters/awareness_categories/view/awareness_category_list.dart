import '../../../../../common_libraries.dart';
import '../bloc/awareness_category_bloc.dart';
import '../bloc/awareness_category_event.dart';
import '../bloc/awareness_category_state.dart';
import '../data/model/awareness_category_response.dart';
import '../widget/awareness_category_list_widget.dart';

class AwarenessCategoryPage extends StatefulWidget {
  const AwarenessCategoryPage({super.key});

  @override
  State<StatefulWidget> createState() => _AwarenessCategoryPageState();
}

class _AwarenessCategoryPageState extends State<AwarenessCategoryPage> {
  final TextEditingController _awarenessCategoryController = TextEditingController();
  final TextEditingController _awarenessCategoryUpdateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ScrollController _horizontal = ScrollController(), _vertical = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<AwarenessCategoryBloc>().add(AwarenessCategoryLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AwarenessCategoryBloc, AwarenessCategoryState>(builder: (context, state) {
      return SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 10),
        child: Stack(
          children: [
            Container(
                color: bluePageHeader,
                width: double.infinity,
                height: 180,
                padding: inset16,
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: insety10,
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 37,
                        child: FaIcon(
                          FontAwesomeIcons.bacon,
                          size: 51,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                    spacerx20,
                    Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                      Padding(
                        padding: insety10,
                      ),
                      Text(AppStrings.pageTitleAwarenessCategories, style: mainTitle),
                      spacery10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomButton(
                            backgroundColor: Colors.blue,
                            borderRadius: 80,
                            textStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 7.8, vertical: 2.2),
                            onClick: () {
                              _awarenessCategoryController.text = "";
                              context.read<AwarenessCategoryBloc>().add(CreateAwarenessCategoryEvent(page: 1));
                            },
                            text: AppStrings.createNew,
                          ),
                        ],
                      ),
                    ])
                  ],
                )),
            Positioned(
                child: Padding(
              padding: EdgeInsets.fromLTRB(
                  12,
                  115,
                  12,
                  state.page == 0
                      ? 12
                      : state.page == 3
                          ? MediaQuery.of(context).size.height - topbarHeight - containerHeight - 260
                          : MediaQuery.of(context).size.height - topbarHeight - containerHeight - 370),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(
                    child: Card(
                  margin: inset12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildAwarenessCategory(),
                  ),
                )),
              ]),
            ))
          ],
        ),
      ));
    }, listener: (context, state) {
      if (state.message.isNotEmpty) {
        if (state.crudStatus == EntityStatus.success) {
          _showNotification(message: state.message, notifyType: NotifyType.success);
        } else if (state.crudStatus == EntityStatus.failure) {
          _showNotification(message: state.message, notifyType: NotifyType.error);
        }
      }
    });
  }

  _showNotification({required String message, required NotifyType notifyType}) {
    CustomNotification(
      context: context,
      notifyType: notifyType,
      content: message,
    ).showNotification();
  }

  _buildAwarenessCategory() {
    final state = context.read<AwarenessCategoryBloc>().state;
    return state.page == 0
        ? _awarenessCategoryMainList(state)
        : state.page == 1
            ? _buildAwarenessCategoryCreate()
            : state.page == 2
                ? _buildAwarenessCategoryUpdate()
                : _buildAwarenessCategoryDelete();
  }

  _awarenessCategoryMainList(AwarenessCategoryState state) {
    if (state.crudStatus == EntityStatus.loading) {
      return <Widget>[
        Padding(
          padding: inset16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.pageTitleAwarenessCategories, style: subMenuTitle),
            ],
          ),
        ),
        CustomBottomBorderContainer(),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Center(
              child: Padding(
                padding: insety30,
                child: const Loader(),
              ),
            )),
      ];
    } else if (state.awarenessCategoryList.isNotEmpty) {
      return <Widget>[
        Padding(
          padding: inset16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.pageTitleAwarenessCategories, style: subMenuTitle),
            ],
          ),
        ),
        CustomBottomBorderContainer(),
        Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
              final double dataTableWidth = MediaQuery.of(context).size.width;
              return Scrollbar(
                controller: _vertical,
                thumbVisibility: true,
                trackVisibility: true,
                child: SingleChildScrollView(
                  controller: _vertical,
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                      width: double.infinity,
                      child: AwarenessCategoryListWidget(
                        awarenessCategoryController: _awarenessCategoryController,
                        awarenessCategoryUpdateController: _awarenessCategoryUpdateController,
                        dataTableWidth: dataTableWidth,
                      )),
                ),
              );
            }))
      ];
    } else {
      return _buildAwarenessCategoryEmptyWidget();
    }
  }

  _buildAwarenessCategoryEmptyWidget() {
    return <Widget>[
      Padding(
        padding: inset16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.pageTitleAwarenessCategories, style: subMenuTitle),
          ],
        ),
      ),
      CustomBottomBorderContainer(),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CustomEmptyPageWidget(
            message: AppStrings.emptyListMessage.replaceFirst("@listName", AppStrings.awarenessCategory).replaceFirst("@listNamePlural", AppStrings.pageTitleAwarenessCategories),
          )),
    ];
  }

  _buildAwarenessCategoryCreate() {
    final state = context.read<AwarenessCategoryBloc>().state;

    return <Widget>[
      Padding(padding: inset16, child: Text(AppStrings.subTitleCreateAwarenessCategory, style: subMenuTitle)),
      CustomBottomBorderContainer(),
      Padding(
          padding: inset16,
          child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _awarenessCategoryController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 50,
                decoration: const InputDecoration(
                    labelText: AppStrings.awarenessCategoryTitle,
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 43, 43, 43),
                    ),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.textgreyColor)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    counterText: '',
                    hintText: AppStrings.awarenessCategoryHint),
                validator: (value) {
                  if (Validation.isNotCheckedMin(value)) {
                    return AppStrings.minAwarenessCategoryError;
                  } else if (Validation.isNotChecked2(value)) {
                    return AppStrings.maxAwarenessCategoryError;
                  } else if (Validation.isAlphaNumericWithSpecialChars(value)) {
                    return AppStrings.alphaNumericError.replaceAll("@fieldName", AppStrings.awarenessCategory);
                  }
                  return null;
                },
              ))),
      CustomBottomBorderContainer(margin: const EdgeInsets.symmetric(horizontal: 16)),
      Padding(
        padding: const EdgeInsets.fromLTRB(32, 32, 16, 30),
        child: Text(AppStrings.actionAppliedWarning, style: textRed),
      ),
      CustomBottomBorderContainer(margin: const EdgeInsets.symmetric(horizontal: 16)),
      spacery40,
      Padding(
          padding: inset16,
          child: Row(children: [
            CustomButton(
              backgroundColor: greenBtn,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
              onClick: () {
                if (_formKey.currentState!.validate()) {
                  AwarenessCategory awarenessCategory = AwarenessCategory(
                    id: 0,
                    name: _awarenessCategoryController.text,
                  );

                  context.read<AwarenessCategoryBloc>().add(CreateNewAwarenessCategoryEvent(page: 0, awarenessCategory: awarenessCategory));
                }
              },
              text: AppStrings.create,
            ),
            spacerx4,
            CustomButton(
              backgroundColor: AppColors.buttonSecondaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: textNormal14,
              onClick: () {
                context.read<AwarenessCategoryBloc>().add(PageChangeEvent(page: 0, awarenessCategory: state.selectedAwarenessCategory));
              },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }

  _buildAwarenessCategoryUpdate() {
    final state = context.read<AwarenessCategoryBloc>().state;

    return <Widget>[
      Padding(padding: inset16, child: Text(AppStrings.subTitleUpdateAwarenessCategory, style: subMenuTitle)),
      CustomBottomBorderContainer(),
      Padding(
          padding: inset16,
          child: Form(
              key: _formKey,
              child: TextFormField(
                controller: _awarenessCategoryUpdateController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 50,
                decoration: const InputDecoration(
                    labelText: AppStrings.awarenessCategoryTitle,
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 43, 43, 43),
                    ),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.textgreyColor)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    counterText: '',
                    hintText: AppStrings.awarenessCategoryHint),
                validator: (value) {
                  if (Validation.isNotCheckedMin(value)) {
                    return AppStrings.minAwarenessCategoryError;
                  } else if (Validation.isNotChecked2(value)) {
                    return AppStrings.maxAwarenessCategoryError;
                  } else if (Validation.isAlphaNumericWithSpecialChars(value)) {
                    return AppStrings.alphaNumericError.replaceAll("@fieldName", AppStrings.awarenessCategory);
                  }
                  return null;
                },
              ))),
      CustomBottomBorderContainer(margin: const EdgeInsets.symmetric(horizontal: 16)),
      Padding(
        padding: const EdgeInsets.fromLTRB(32, 32, 16, 30),
        child: Text(AppStrings.actionAppliedWarning, style: textRed),
      ),
      CustomBottomBorderContainer(margin: const EdgeInsets.symmetric(horizontal: 16)),
      spacery40,
      Padding(
          padding: inset16,
          child: Row(children: [
            CustomButton(
              backgroundColor: greenBtn,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
              onClick: () {
                if (_formKey.currentState!.validate()) {
                  AwarenessCategory awarenessCategory = AwarenessCategory(
                    id: state.selectedAwarenessCategory!.id,
                    name: _awarenessCategoryUpdateController.text,
                  );
                  context.read<AwarenessCategoryBloc>().add(UpdateAwarenessCategoryEvent(page: 0, awarenessCategory: awarenessCategory));
                }
              },
              text: AppStrings.update,
            ),
            spacerx4,
            CustomButton(
              backgroundColor: AppColors.buttonSecondaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: textNormal14,
              onClick: () {
                context.read<AwarenessCategoryBloc>().add(PageChangeEvent(page: 0, awarenessCategory: state.selectedAwarenessCategory));
              },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }

  _buildAwarenessCategoryDelete() {
    final state = context.read<AwarenessCategoryBloc>().state;
    return <Widget>[
      Padding(padding: inset16, child: Text(AppStrings.subTitleDeleteAwarenessCategory, style: subMenuTitle)),
      CustomBottomBorderContainer(),
      Padding(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.selectedAwarenessCategory!.name!,
                style: textNormal22,
                overflow: TextOverflow.ellipsis,
              ),
              spacery30,
              Text(AppStrings.actionAppliedWarning, style: textRed),
            ],
          )),
      CustomBottomBorderContainer(margin: const EdgeInsets.symmetric(horizontal: 16)),
      spacery40,
      Padding(
          padding: inset16,
          child: Row(children: [
            CustomButton(
              backgroundColor: warnColor,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
              onClick: () {
                final state = context.read<AwarenessCategoryBloc>().state;
                if (state.selectedAwarenessCategory != null) {
                  context.read<AwarenessCategoryBloc>().add(DeleteAwarenessCategoryEvent(page: 0, id: state.selectedAwarenessCategory!.id!));
                }
              },
              text: AppStrings.delete,
            ),
            spacerx4,
            CustomButton(
              backgroundColor: AppColors.buttonSecondaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: textNormal14,
              onClick: () {
                context.read<AwarenessCategoryBloc>().add(PageChangeEvent(page: 0, awarenessCategory: state.selectedAwarenessCategory));
              },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }
}
