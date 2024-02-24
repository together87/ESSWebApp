import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/observation_types/bloc/observation_type_bloc.dart';
import 'package:ecosys_safety/features/administration/masters/observation_types/bloc/observation_type_event.dart';
import 'package:ecosys_safety/features/administration/masters/observation_types/bloc/observation_type_state.dart';
import 'package:ecosys_safety/features/administration/masters/observation_types/widget/observation_type_list_widget.dart';
import 'package:ecosys_safety/features/administration/masters/observation_types/widget/severity_level_select.dart';
import 'package:ecosys_safety/features/administration/masters/observation_types/widget/visibility_type_select.dart';

import '../data/model/observation_type_response.dart';

class ObservationTypePage extends StatefulWidget {
  const ObservationTypePage({super.key});

  @override
  State<StatefulWidget> createState() => _ObservationTypePageState();
}

class _ObservationTypePageState extends State<ObservationTypePage> {
  final TextEditingController _observationTypeController = TextEditingController();
  final TextEditingController _observationTypeUpdateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ScrollController _horizontal = ScrollController(), _vertical = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ObservationTypeBloc>().add(ObservationTypeLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ObservationTypeBloc, ObservationTypeState>(builder: (context, state) {
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
                      Text(AppStrings.pageTitleObservationTypes, style: mainTitle),
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
                              _observationTypeController.text = "";
                              context.read<ObservationTypeBloc>().add(CreateObservationTypeEvent(page: 1));
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
                    children: _buildObservationType(),
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

  _buildObservationType() {
    final state = context.read<ObservationTypeBloc>().state;
    return state.page == 0
        ? _observationTypeMainList(state)
        : state.page == 1
            ? _buildObservationTypeCreate()
            : state.page == 2
                ? _buildObservationTypeUpdate()
                : _buildObservationTypeDelete();
  }

  _observationTypeMainList(ObservationTypeState state) {
    if (state.crudStatus == EntityStatus.loading) {
      return <Widget>[
        Padding(
          padding: inset16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.pageTitleObservationTypes, style: subMenuTitle),
            ],
          ),
        ),
        CustomBottomBorderContainer(),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Center(
              child: Padding(
                padding: insety30,
                child: const Loader(),
              ),
            )),
      ];
    } else if (state.observationTypeList.isNotEmpty) {
      return <Widget>[
        Padding(
          padding: inset16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.pageTitleObservationTypes, style: subMenuTitle),
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
                      child: ObservationTypeListWidget(
                        observationTypeController: _observationTypeController,
                        observationTypeUpdateController: _observationTypeUpdateController,
                        dataTableWidth: dataTableWidth,
                      )),
                ),
              );
            }))
      ];
    } else {
      return _buildObservationTypeEmptyWidget();
    }
  }

  _buildObservationTypeEmptyWidget() {
    return <Widget>[
      Padding(
        padding: inset16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.pageTitleObservationTypes, style: subMenuTitle),
          ],
        ),
      ),
      CustomBottomBorderContainer(),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CustomEmptyPageWidget(
            message: AppStrings.emptyListMessage.replaceFirst("@listName", AppStrings.observationType).replaceFirst("@listNamePlural", AppStrings.pageTitleObservationTypes),
          )),
    ];
  }

  _buildObservationTypeCreate() {
    final state = context.read<ObservationTypeBloc>().state;

    return <Widget>[
      Padding(padding: inset16, child: Text(AppStrings.subTitleCreateObservationType, style: observationStyle)),
      CustomBottomBorderContainer(),
      Padding(
        padding: inset16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 8, 12, 8),
                  child: Text(
                    AppStrings.observationTypeTitle,
                    style: textNormal14,
                  ),
                ),
                spacery10,
                SizedBox(
                    width: (MediaQuery.of(context).size.width - 500) * 0.5,
                    child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _observationTypeController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textAlignVertical: TextAlignVertical.center,
                          maxLength: 50,
                          decoration: const InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 43, 43, 43),
                              ),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.textgreyColor)),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: AppStrings.observationTypeyHint),
                          validator: (value) {
                            if (Validation.isNotCheckedMin(value)) {
                              return AppStrings.minObservationTypeError;
                            } else if (Validation.isNotChecked2(value)) {
                              return AppStrings.maxObservationTypeError;
                            } else if (Validation.isAlphaNumericWithSpecialChars(value)) {
                              return AppStrings.alphaNumericError.replaceAll("@fieldName", AppStrings.observationType);
                            }
                            return null;
                          },
                        ))),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 8, 12, 8),
                  child: Text(
                    AppStrings.severityLevelTitle,
                    style: textNormal14,
                  ),
                ),
                spacery10,
                const SeverityLevelSelect(),
              ],
            ),
          ],
        ),
      ),
      CustomBottomBorderContainer(margin: const EdgeInsets.symmetric(horizontal: 16)),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 8, 12, 8),
              child: Text(
                AppStrings.visibilityTitle,
                style: textNormal14,
              ),
            ),
            spacery10,
            const VisibilityTypeSelect(),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
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
                  ObservationType observationType = ObservationType(
                    id: 0,
                    name: _observationTypeController.text,
                    severityLevelId: state.selectedSeverityLevel!.id,
                    visibilityTypeId: state.selectedVisibilityType!.id,
                  );

                  context.read<ObservationTypeBloc>().add(CreateNewObservationTypeEvent(page: 0, observationType: observationType));
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
                context.read<ObservationTypeBloc>().add(PageChangeEvent(page: 0, observationType: state.selectedObservationType));
              },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }

  _buildObservationTypeUpdate() {
    final state = context.read<ObservationTypeBloc>().state;
    return <Widget>[
      Padding(padding: inset16, child: Text(AppStrings.subTitleUpdateObservationType, style: observationStyle)),
      CustomBottomBorderContainer(),
      Padding(
        padding: inset16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 8, 12, 8),
                  child: Text(
                    AppStrings.observationTypeTitle,
                    style: textNormal14,
                  ),
                ),
                spacery10,
                SizedBox(
                    width: (MediaQuery.of(context).size.width - 500) * 0.5,
                    child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _observationTypeUpdateController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textAlignVertical: TextAlignVertical.center,
                          maxLength: 50,
                          decoration: const InputDecoration(counterText: '', border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))), hintText: AppStrings.observationTypeyHint),
                          validator: (value) {
                            if (Validation.isNotCheckedMin(value)) {
                              return AppStrings.minObservationTypeError;
                            } else if (Validation.isNotChecked2(value)) {
                              return AppStrings.maxObservationTypeError;
                            } else if (Validation.isAlphaNumericWithSpecialChars(value)) {
                              return AppStrings.alphaNumericError.replaceAll("@fieldName", AppStrings.observationType);
                            }
                            return null;
                          },
                        ))),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 8, 12, 8),
                  child: Text(
                    AppStrings.severityLevelTitle,
                    style: textNormal14,
                  ),
                ),
                spacery10,
                const SeverityLevelSelect(),
              ],
            ),
          ],
        ),
      ),
      CustomBottomBorderContainer(margin: const EdgeInsets.symmetric(horizontal: 16)),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 8, 12, 8),
              child: Text(
                AppStrings.visibilityTitle,
                style: textNormal14,
              ),
            ),
            spacery10,
            const VisibilityTypeSelect(),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
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
                  ObservationType observationType = ObservationType(
                    id: state.selectedObservationType!.id,
                    name: _observationTypeUpdateController.text,
                    severityLevelId: state.selectedSeverityLevel!.id,
                    visibilityTypeId: state.selectedVisibilityType!.id,
                  );
                  context.read<ObservationTypeBloc>().add(UpdateObservationTypeEvent(page: 0, observationType: observationType));
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
                context.read<ObservationTypeBloc>().add(PageChangeEvent(page: 0, observationType: state.selectedObservationType));
              },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }

  _buildObservationTypeDelete() {
    final state = context.read<ObservationTypeBloc>().state;
    return <Widget>[
      Padding(padding: inset16, child: Text(AppStrings.subTitleDeleteObservationType, style: subMenuTitle)),
      CustomBottomBorderContainer(),
      Padding(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.selectedObservationType!.name!,
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
                final state = context.read<ObservationTypeBloc>().state;
                if (state.selectedObservationType != null) {
                  context.read<ObservationTypeBloc>().add(DeleteObservationTypeEvent(page: 0, id: state.selectedObservationType!.id!));
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
                context.read<ObservationTypeBloc>().add(PageChangeEvent(page: 0, observationType: state.selectedObservationType));
              },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }
}
