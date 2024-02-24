import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/severity_level/bloc/severity_level_bloc.dart';
import 'package:ecosys_safety/features/administration/masters/severity_level/bloc/severity_level_event.dart';
import 'package:ecosys_safety/features/administration/masters/severity_level/bloc/severity_level_state.dart';
import 'package:ecosys_safety/features/administration/masters/severity_level/data/model/severityLevel.dart';
import 'package:ecosys_safety/features/administration/masters/severity_level/widgets/severity_level.dart';

class SeverityLevelListView extends StatefulWidget {
  const SeverityLevelListView({super.key});

  @override
  State<SeverityLevelListView> createState() => _SeverityLevelState();
}

class _SeverityLevelState extends State<SeverityLevelListView> {
  _SeverityLevelState();

  TextEditingController severitylevelController = TextEditingController();
  TextEditingController severitylevelUpdateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final ScrollController _horizontal = ScrollController(), _vertical = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<SeveritylevelBloc>().add(SeveritylevelLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SeveritylevelBloc, SeveritylevelState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 10),
            child: Stack(
              children: [
                Container(
                    color: bluePageHeader,
                    width: double.infinity,
                    height: containerHeight,
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
                          Text(AppStrings.pageTitleSeverityLevels, style: mainTitle),
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
                                  severitylevelController.text = "";
                                  context.read<SeveritylevelBloc>().add(SeveritylevelPageChangeEvent(page: 1));
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
                      state.severityPage == 0
                          ? 12
                          : state.severityPage == 3
                              ? MediaQuery.of(context).size.height - topbarHeight - containerHeight - 280
                              : MediaQuery.of(context).size.height - topbarHeight - containerHeight - 320),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Card(
                        margin: inset12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildSeveritylevel(),
                        ),
                      )),
                    ],
                  ),
                ))
              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state.message.isNotEmpty) {
          if (state.severitylevelCrud == EntityStatus.success) {
            _showNotification(message: state.message, notifyType: NotifyType.success);
          } else if (state.severitylevelCrud == EntityStatus.failure) {
            _showNotification(message: state.message, notifyType: NotifyType.error);
          }
        }
      },
    );
  }

  _showNotification({required String message, required NotifyType notifyType}) {
    CustomNotification(
      context: context,
      notifyType: notifyType,
      content: message,
    ).showNotification();
  }

  _buildSeveritylevel() {
    final state = context.read<SeveritylevelBloc>().state;
    return state.severityPage == 0
        ? _serverityLevelMainList(state)
        : state.severityPage == 1
            ? _buildServerityLevelCreate()
            : state.severityPage == 2
                ? _buildSeverityLevelUpdate()
                : _buildSeverityLevelDelete();
  }

  _serverityLevelMainList(SeveritylevelState state) {
    if (state.severitylevelCrud == EntityStatus.loading) {
      return <Widget>[
        Padding(
          padding: inset16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.pageTitleSeverityLevels, style: subMenuTitle),
            ],
          ),
        ),
        CustomBottomBorderContainer(),
        Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Center(
              child: Padding(
                padding: insety30,
                child: const Loader(),
              ),
            )),
      ];
    } else if (state.severityLevelList.isNotEmpty) {
      return <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.pageTitleSeverityLevels, style: subMenuTitle),
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
                  scrollDirection: Axis.vertical,
                  controller: _vertical,
                  child: SizedBox(
                    width: double.infinity,
                    child: SeverityLevelList(
                      severitylevelController: severitylevelController,
                      severitylevelUpdateController: severitylevelUpdateController,
                      dataTableWidth: dataTableWidth,
                    ),
                  ),
                ),
              );
            }))
      ];
    } else {
      return _buildSeverityLevelEmptyWidget();
    }
  }

  _buildSeverityLevelEmptyWidget() {
    return <Widget>[
      Padding(
        padding: inset16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.pageTitleSeverityLevels, style: subMenuTitle),
          ],
        ),
      ),
      CustomBottomBorderContainer(),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: CustomEmptyPageWidget(
            message: AppStrings.emptyListMessage.replaceFirst('@listName', AppStrings.severityLevel).replaceFirst('@listNamePlural', AppStrings.pageTitleSeverityLevels),
          )),
    ];
  }

  _buildServerityLevelCreate() {
    return <Widget>[
      Padding(padding: inset16, child: Text(AppStrings.subTitleCreateSeverityLevel, style: subMenuTitle)),
      CustomBottomBorderContainer(),
      Padding(
          padding: inset16,
          child: Form(
              key: _formKey,
              child: TextFormField(
                controller: severitylevelController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 100,
                decoration: const InputDecoration(
                    labelText: AppStrings.severityLevelTitle,
                    counterText: '',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 43, 43, 43),
                    ),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.textgreyColor)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: AppStrings.severityLevelHint),
                validator: (value) {
                  if (Validation.isNotCheckedMin(value)) {
                    return AppStrings.minSeverityLevelError;
                  } else if (Validation.isNotCheckedMax(value)) {
                    return AppStrings.maxSeverityLevelError;
                  } else if (Validation.isAlphaNumericWithSpecialChars(value)) {
                    return AppStrings.alphaNumericError.replaceAll("@fieldName", AppStrings.severityLevel);
                  }
                  return null;
                },
              ))),
      CustomBottomBorderContainer(margin: const EdgeInsets.symmetric(horizontal: 16)),
      Padding(padding: const EdgeInsets.fromLTRB(32, 32, 16, 30), child: Text(AppStrings.actionAppliedWarning, style: textRed)),
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
                  final state = context.read<SeveritylevelBloc>().state;
                  SeverityLevel severitylevel = SeverityLevel(id: 0, level: severitylevelController.text);
                  context.read<SeveritylevelBloc>().add(SeveritylevelCreateNewEvent(page: 0, severitylevel: severitylevel));
                }
              },
              text: AppStrings.create,
            ),
            spacerx8,
            CustomButton(
              backgroundColor: AppColors.buttonSecondaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: textNormal14,
              onClick: () {
                context.read<SeveritylevelBloc>().add(SeveritylevelPageChangeEvent(page: 0));
              },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }

  _buildSeverityLevelUpdate() {
    return <Widget>[
      Padding(padding: inset16, child: Text(AppStrings.subTitleUpdateSeverityLevel, style: subMenuTitle)),
      CustomBottomBorderContainer(),
      Padding(
          padding: inset16,
          child: Form(
              key: _formKey,
              child: TextFormField(
                controller: severitylevelUpdateController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 100,
                decoration: const InputDecoration(
                    labelText: AppStrings.severityLevelTitle,
                    counterText: '',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 43, 43, 43),
                    ),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.textgreyColor)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: AppStrings.severityLevelHint),
                validator: (value) {
                  if (Validation.isNotCheckedMin(value)) {
                    return AppStrings.minSeverityLevelError;
                  } else if (Validation.isNotCheckedMax(value)) {
                    return AppStrings.maxSeverityLevelError;
                  } else if (Validation.isAlphaNumericWithSpecialChars(value)) {
                    return AppStrings.alphaNumericError.replaceAll("@fieldName", AppStrings.severityLevel);
                  }
                  return null;
                },
              ))),
      CustomBottomBorderContainer(margin: const EdgeInsets.symmetric(horizontal: 16)),
      Padding(padding: const EdgeInsets.fromLTRB(32, 32, 16, 30), child: Text(AppStrings.actionAppliedWarning, style: textRed)),
      CustomBottomBorderContainer(margin: const EdgeInsets.symmetric(horizontal: 16)),
      spacery50,
      Padding(
          padding: inset16,
          child: Row(children: [
            CustomButton(
              backgroundColor: greenBtn,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
              onClick: () {
                if (_formKey.currentState!.validate()) {
                  final state = context.read<SeveritylevelBloc>().state;
                  SeverityLevel severitylevel = SeverityLevel(id: state.selectedSeverityLevel!.id!, level: severitylevelUpdateController.text);
                  context.read<SeveritylevelBloc>().add(SeveritylevelUpdateEvent(page: 0, severitylevel: severitylevel));
                }
              },
              text: AppStrings.update,
            ),
            spacerx8,
            CustomButton(
              backgroundColor: AppColors.buttonSecondaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: textNormal14,
              onClick: () {
                context.read<SeveritylevelBloc>().add(SeveritylevelPageChangeEvent(page: 0));
              },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }

  _buildSeverityLevelDelete() {
    final state = context.read<SeveritylevelBloc>().state;
    return <Widget>[
      Padding(padding: inset16, child: Text(AppStrings.subTitleDeleteSeverityLevel, style: subMenuTitle)),
      CustomBottomBorderContainer(),
      Padding(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.selectedSeverityLevel!.level!,
                style: textNormal22,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
              spacery30,
              Text(AppStrings.actionAppliedWarning, style: textRed),
            ],
          )),
      CustomBottomBorderContainer(margin: const EdgeInsets.symmetric(horizontal: 16)),
      spacery50,
      Padding(
          padding: inset16,
          child: Row(children: [
            CustomButton(
              backgroundColor: warnColor,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
              onClick: () {
                final state = context.read<SeveritylevelBloc>().state;
                if (state.selectedSeverityLevel != null) {
                  context.read<SeveritylevelBloc>().add(SeveritylevelDeleteEvent(page: 0, id: state.selectedSeverityLevel!.id!));
                }
                /* showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete Severity Level'),
                      content: const Text(
                          'Do you want to delete the Severity Level really?'),
                      backgroundColor: const Color.fromARGB(255, 248, 169, 169),
                      actions: [
                        TextButton(
                          onPressed: () {
                            final state =
                                context.read<SeveritylevelBloc>().state;
                            if (state.selectedSeverityLevel != null) {
                              context.read<SeveritylevelBloc>().add(
                                  SeveritylevelDeleteEvent(
                                      page: 0,
                                      id: state.selectedSeverityLevel!.id!));
                            }
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );*/
              },
              text: AppStrings.delete,
            ),
            spacerx8,
            CustomButton(
              backgroundColor: AppColors.buttonSecondaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: textNormal14,
              onClick: () {
                context.read<SeveritylevelBloc>().add(SeveritylevelPageChangeEvent(page: 0));
              },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }
}
