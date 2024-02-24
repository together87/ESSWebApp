import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/priority_levels/bloc/priority_level_bloc.dart';
import 'package:ecosys_safety/features/administration/masters/priority_levels/bloc/priority_level_state.dart';
import 'package:ecosys_safety/features/administration/masters/priority_levels/widget/priority_level_list_widget.dart';
import 'package:ecosys_safety/features/administration/masters/priority_levels/widget/priority_type_select.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../bloc/priority_level_event.dart';
import '../data/model/priority_level_response.dart';

class PriorityLevelPage extends StatefulWidget {
  const PriorityLevelPage({super.key});

  @override
  State<StatefulWidget> createState() => _PriorityLevelPageState();
}

class _PriorityLevelPageState extends State<PriorityLevelPage> {
  final TextEditingController _priorityLevelController = TextEditingController();
  final TextEditingController _priorityLevelUpdateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ScrollController _horizontal = ScrollController(), _vertical = ScrollController();
  Color currentColor = Color.fromARGB(255, 14, 52, 83);
  Color createColor = Color.fromARGB(255, 0, 0, 0); // Default color
  @override
  void initState() {
    super.initState();
    context.read<PriorityLevelBloc>().add(PriorityLevelLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PriorityLevelBloc, PriorityLevelState>(builder: (context, state) {
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
                      Text(AppStrings.pageTitlePriorityLevels, style: mainTitle),
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
                              _priorityLevelController.text = "";
                              context.read<PriorityLevelBloc>().add(CreatePriorityLevelEvent(page: 1));
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
                    children: _buildPriorityLevel(),
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

  _buildPriorityLevel() {
    final state = context.read<PriorityLevelBloc>().state;
    return state.page == 0
        ? _priorityLevelMainList(state)
        : state.page == 1
            ? _buildPriorityLevelCreate()
            : state.page == 2
                ? _buildPriorityLevelUpdate()
                : _buildPriorityLevelDelete();
  }

  _priorityLevelMainList(PriorityLevelState state) {
    if (state.crudStatus == EntityStatus.loading) {
      return <Widget>[
        Padding(
          padding: inset16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.pageTitlePriorityLevels, style: subMenuTitle),
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
    } else if (state.priorityLevelList.isNotEmpty) {
      return <Widget>[
        Padding(
          padding: inset16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.pageTitlePriorityLevels, style: subMenuTitle),
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
                      child: PriorityLevelListWidget(
                        prioritylevelController: _priorityLevelController,
                        prioritylevelUpdateController: _priorityLevelUpdateController,
                        dataTableWidth: dataTableWidth,
                      )),
                ),
              );
            }))
      ];
    } else {
      return _buildPriorityLevelEmptyWidget();
    }
  }

  _buildPriorityLevelEmptyWidget() {
    return <Widget>[
      Padding(
        padding: inset16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.pageTitlePriorityLevels, style: subMenuTitle),
          ],
        ),
      ),
      CustomBottomBorderContainer(),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CustomEmptyPageWidget(
            message: AppStrings.emptyListMessage.replaceFirst("@listName", AppStrings.priorityLevel).replaceFirst("@listNamePlural", AppStrings.pageTitlePriorityLevels),
          )),
    ];
  }

  _buildPriorityLevelCreate() {
    final state = context.read<PriorityLevelBloc>().state;

    return <Widget>[
      Padding(padding: inset16, child: Text(AppStrings.subTitleCreatePriorityLevel, style: subMenuTitle)),
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
                    AppStrings.priorityLevelTitle,
                    style: textNormal14,
                  ),
                ),
                spacery10,
                SizedBox(
                    width: (MediaQuery.of(context).size.width - 500) * 0.5,
                    child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _priorityLevelController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textAlignVertical: TextAlignVertical.center,
                          maxLength: 50,
                          decoration: InputDecoration(
                              counterText: '',
                              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                              labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 43, 43, 43),
                              ),
                              focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.textgreyColor)),
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              hintText: AppStrings.priorityLevelHint,
                              hintStyle: textNormal14),
                          validator: (value) {
                            if (Validation.isNotCheckedMin(value)) {
                              return AppStrings.minPriorityLevelError;
                            } else if (Validation.isNotChecked2(value)) {
                              return AppStrings.maxPriorityLevelError;
                            } else if (Validation.isAlphaNumericWithSpecialChars(value)) {
                              return AppStrings.alphaNumericError.replaceAll("@fieldName", AppStrings.priorityLevel);
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
                    AppStrings.priorityLevel_priorityTypeTitle,
                    style: textNormal14,
                  ),
                ),
                spacery10,
                const PriorityTypeSelect(),
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
                AppStrings.color,
                style: textNormal14,
              ),
            ),
            spacery10,
            ElevatedButton(
              style: ButtonStyle(
                side: MaterialStateProperty.resolveWith<BorderSide>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return const BorderSide(color: Colors.grey, width: 2.0);
                    }
                    return const BorderSide(color: Colors.black, width: 2.0);
                  },
                ),
                backgroundColor: MaterialStateProperty.all<Color>(createColor),
                fixedSize: MaterialStateProperty.all<Size>(
                  const Size(30.0, 52.0),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Picker Color'),
                      backgroundColor: Colors.grey[70],
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: createColor,
                          onColorChanged: (Color color) {
                            setState(() {
                              createColor = color;
                            });
                          },
                          pickerAreaHeightPercent: 0.8,
                          enableAlpha: true,
                          displayThumbColor: true,
                          paletteType: PaletteType.hsv,
                          colorPickerWidth: 300,
                          hexInputBar: true,
                          portraitOnly: true,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(AppStrings.close),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text(''),
            ),
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
                  PriorityLevel priorityLevel = PriorityLevel(
                    id: 0,
                    name: _priorityLevelController.text,
                    color: colorToHex(createColor),
                    priorityTypeId: state.selectedPriorityType!.id,
                    priorityTypeName: state.selectedPriorityType!.name,
                  );
                  createColor = const Color.fromARGB(255, 0, 0, 0); // Default
                  context.read<PriorityLevelBloc>().add(CreateNewPriorityLevelEvent(page: 0, priorityLevel: priorityLevel));
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
                createColor = const Color.fromARGB(255, 0, 0, 0); // Defau
                context.read<PriorityLevelBloc>().add(PageChangeEvent(page: 0, priorityLevel: state.selectedPriorityLevel));
              },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }

  _buildPriorityLevelUpdate() {
    final state = context.read<PriorityLevelBloc>().state;
    currentColor = _getColor(state.selectedPriorityLevel!.color!);
    return <Widget>[
      Padding(padding: inset16, child: Text(AppStrings.subTitleUpdatePriorityLevel, style: subMenuTitle)),
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
                    AppStrings.priorityLevelTitle,
                    style: textNormal14,
                  ),
                ),
                spacery10,
                SizedBox(
                    width: (MediaQuery.of(context).size.width - 500) * 0.5,
                    child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _priorityLevelUpdateController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textAlignVertical: TextAlignVertical.center,
                          style: textNormal14,
                          maxLength: 50,
                          decoration: InputDecoration(counterText: '', border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))), labelStyle: const TextStyle(color: Color.fromARGB(255, 43, 43, 43), fontSize: 14), hintStyle: textNormal14, focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: AppColors.textgreyColor)), floatingLabelBehavior: FloatingLabelBehavior.always, hintText: AppStrings.priorityLevelHint),
                          validator: (value) {
                            if (Validation.isNotCheckedMin(value)) {
                              return AppStrings.minPriorityLevelError;
                            } else if (Validation.isNotChecked2(value)) {
                              return AppStrings.maxPriorityLevelError;
                            } else if (Validation.isAlphaNumericWithSpecialChars(value)) {
                              return AppStrings.alphaNumericError.replaceAll("@fieldNmae", AppStrings.priorityLevel);
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
                    AppStrings.priorityLevel_priorityTypeTitle,
                    style: textNormal14,
                  ),
                ),
                spacery10,
                const PriorityTypeSelect(),
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
                AppStrings.color,
                style: textNormal14,
              ),
            ),
            spacery10,
            ElevatedButton(
              style: ButtonStyle(
                side: MaterialStateProperty.resolveWith<BorderSide>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return const BorderSide(color: Colors.grey, width: 2.0);
                    }
                    return const BorderSide(color: Colors.black, width: 2.0);
                  },
                ),
                backgroundColor: MaterialStateProperty.all<Color>(_getColor(state.selectedPriorityLevel!.color ?? '#000000')),
                fixedSize: MaterialStateProperty.all<Size>(
                  const Size(30.0, 52.0),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Picker Color'),
                      backgroundColor: Colors.grey[70],
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: _getColor(state.selectedPriorityLevel!.color!),
                          onColorChanged: (Color color) {
                            setState(() {
                              currentColor = color;
                              PriorityLevel priorityLevel = PriorityLevel(
                                id: state.selectedPriorityLevel!.id,
                                name: _priorityLevelUpdateController.text,
                                color: colorToHex(currentColor),
                                priorityTypeId: state.selectedPriorityType!.id,
                                priorityTypeName: state.selectedPriorityType!.name,
                              );
                              context.read<PriorityLevelBloc>().add(PriorityLevelSelectedEvent(priorityLevel: priorityLevel));
                            });
                          },
                          pickerAreaHeightPercent: 0.8,
                          enableAlpha: true,
                          displayThumbColor: true,
                          paletteType: PaletteType.hsv,
                          colorPickerWidth: 300,
                          hexInputBar: true,
                          portraitOnly: true,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(AppStrings.close),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text(''),
            ),
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
                  PriorityLevel priorityLevel = PriorityLevel(
                    id: state.selectedPriorityLevel!.id,
                    name: _priorityLevelUpdateController.text,
                    color: colorToHex(currentColor),
                    priorityTypeId: state.selectedPriorityType!.id,
                    priorityTypeName: state.selectedPriorityType!.name,
                  );
                  context.read<PriorityLevelBloc>().add(UpdatePriorityLevelEvent(page: 0, priorityLevel: priorityLevel, priorityType: state.selectedPriorityType!));
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
                context.read<PriorityLevelBloc>().add(PageChangeEvent(page: 0, priorityLevel: state.selectedPriorityLevel));
              },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }

  _getColor(String colorCode) {
    if (colorCode.startsWith("#")) {
      return Color(int.parse(colorCode.substring(1, 7), radix: 16) + 0xFF000000);
    } else {
      return Colors.black;
    }
  }

  String colorToHex(Color color) {
    return '#' + color.value.toRadixString(16).substring(2);
  }

  _buildPriorityLevelDelete() {
    final state = context.read<PriorityLevelBloc>().state;
    return <Widget>[
      Padding(padding: inset16, child: Text(AppStrings.subTitleDeletePriorityLevel, style: subMenuTitle)),
      CustomBottomBorderContainer(),
      Padding(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.selectedPriorityLevel!.name!,
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
                final state = context.read<PriorityLevelBloc>().state;
                if (state.selectedPriorityLevel != null) {
                  context.read<PriorityLevelBloc>().add(DeletePriorityLevelEvent(page: 0, id: state.selectedPriorityLevel!.id!));
                }
                /*  showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete Priority Level'),
                      content: const Text(
                          'Do you want to delete the Priority Level really?'),
                      backgroundColor: const Color.fromARGB(255, 248, 169, 169),
                      actions: [
                        TextButton(
                          onPressed: () {
                            final state =
                                context.read<PriorityLevelBloc>().state;
                            if (state.selectedPriorityLevel != null) {
                              context.read<PriorityLevelBloc>().add(
                                  DeletePriorityLevelEvent(
                                      page: 0,
                                      id: state.selectedPriorityLevel!.id!));
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
            spacerx4,
            CustomButton(
              backgroundColor: AppColors.buttonSecondaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              textStyle: textNormal14,
              onClick: () {
                context.read<PriorityLevelBloc>().add(PageChangeEvent(page: 0, priorityLevel: state.selectedPriorityLevel));
              },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }
}
