import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/bloc/priority_type_bloc.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/bloc/priority_type_event.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/bloc/priority_type_state.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/data/model/priorityType.dart';
import 'package:ecosys_safety/features/administration/masters/priority_type/widgets/priority_type_widget.dart';

class PriorityTypeListView extends StatefulWidget {
  const PriorityTypeListView({super.key});

  @override
  State<PriorityTypeListView> createState() => _PriorityTypeState();
}

class _PriorityTypeState extends State<PriorityTypeListView> {
  _PriorityTypeState();

  TextEditingController priorityTypeController = TextEditingController();
  TextEditingController priorityTypeUpdateController = TextEditingController();
  final ScrollController _horizontal = ScrollController(), _vertical = ScrollController();
  bool _showScrollbar = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _vertical.addListener(_scrollListener);
    context.read<PriorityTypeBloc>().add(PriorityTypeLoadingEvent());
  }

  void _scrollListener() {
    setState(() {
      _showScrollbar = _vertical.offset > 0;
    });
  }

  @override
  void dispose() {
    _vertical.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PriorityTypeBloc, PriorityTypeState>(
      builder: (context, state) {
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
                        Text(AppStrings.pageTitlePriorityTypes, style: mainTitle),
                        spacery10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomButton(
                              backgroundColor: AppColors.buttonButtonColor,
                              borderRadius: 80,
                              textStyle: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                //fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 7.8, vertical: 2.2),
                              onClick: () {
                                priorityTypeController.text = "";
                                context.read<PriorityTypeBloc>().add(PriorityTypePageChangeEvent(page: 1));
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
                    state.priorityTypePage == 0
                        ? 12
                        : state.priorityTypePage == 3
                            ? MediaQuery.of(context).size.height - topbarHeight - containerHeight - 280
                            : MediaQuery.of(context).size.height - topbarHeight - containerHeight - 320),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Card(
                      clipBehavior: Clip.hardEdge,
                      margin: inset12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildPriorityType(),
                      ),
                    )),
                  ],
                ),
              ))
            ],
          ),
        ));
      },
      listener: (context, state) {
        if (state.message.isNotEmpty) {
          if (state.priorityTypeCrud == EntityStatus.success) {
            _showNotification(message: state.message, notifyType: NotifyType.success);
          } else if (state.priorityTypeCrud == EntityStatus.failure) {
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

  _buildPriorityType() {
    final state = context.read<PriorityTypeBloc>().state;
    return state.priorityTypePage == 0
        ? _priorityTypeMainList(state)
        : state.priorityTypePage == 1
            ? _buildPriorityTypeCreate()
            : state.priorityTypePage == 2
                ? _buildPriorityTypeUpdate()
                : _buildPriorityTypeDelete();
  }

  _priorityTypeMainList(PriorityTypeState state) {
    if (state.priorityTypeCrud == EntityStatus.loading) {
      return <Widget>[
        Padding(
          padding: inset16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.pageTitlePriorityTypes, style: subMenuTitle),
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
    } else if (state.priorityTypeList.isNotEmpty) {
      return <Widget>[
        Padding(
          padding: inset16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStrings.pageTitlePriorityTypes, style: subMenuTitle),
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
                      child: PriorityTypeList(
                        priorityTypeController: priorityTypeController,
                        priorityTypeUpdateController: priorityTypeUpdateController,
                        dataTableWidth: dataTableWidth,
                      ),
                    )),
              );
            }))
      ];
    } else {
      return _buildPriorityTypeEmptyWidget();
    }
  }

  _buildPriorityTypeEmptyWidget() {
    return <Widget>[
      Padding(
        padding: inset16,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppStrings.pageTitlePriorityTypes, style: subMenuTitle),
          ],
        ),
      ),
      CustomBottomBorderContainer(),
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CustomEmptyPageWidget(
            message: AppStrings.emptyListMessage.replaceFirst('@listName', AppStrings.priorityType).replaceFirst('@listNamePlural', AppStrings.pageTitlePriorityTypes),
          )),
    ];
  }

  _buildPriorityTypeCreate() {
    return <Widget>[
      Padding(padding: inset16, child: Text(AppStrings.subTitleCreatePriorityType, style: subMenuTitle)),
      CustomBottomBorderContainer(),
      Padding(
          padding: inset16,
          child: Form(
              key: _formKey,
              child: TextFormField(
                controller: priorityTypeController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 50,
                decoration: const InputDecoration(
                    labelText: AppStrings.priorityTypeTitle,
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 43, 43, 43),
                    ),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.textgreyColor)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    counterText: '',
                    hintText: AppStrings.priorityTypeHint),
                validator: (value) {
                  if (Validation.isNotCheckedMin(value)) {
                    return AppStrings.minPriorityTypeError;
                  } else if (Validation.isNotChecked2(value)) {
                    return AppStrings.maxPriorityTypeError;
                  } else if (Validation.isAlphaNumericWithSpecialChars(value)) {
                    return AppStrings.alphaNumericError.replaceFirst('@fieldName', AppStrings.priorityType);
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
                  final state = context.read<PriorityTypeBloc>().state;
                  PriorityType priorityType = PriorityType(id: 0, name: priorityTypeController.text);
                  context.read<PriorityTypeBloc>().add(PriorityTypeCreateNewEvent(page: 0, priorityType: priorityType));
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
                context.read<PriorityTypeBloc>().add(PriorityTypePageChangeEvent(page: 0));
              },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }

  _buildPriorityTypeUpdate() {
    return <Widget>[
      Padding(padding: inset16, child: Text(AppStrings.subTitleUpdatePriorityType, style: subMenuTitle)),
      CustomBottomBorderContainer(),
      Padding(
          padding: inset16,
          child: Form(
              key: _formKey,
              child: TextFormField(
                controller: priorityTypeUpdateController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLength: 50,
                /* inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp('\\s+'))
                ],*/
                decoration: const InputDecoration(
                    labelText: AppStrings.priorityTypeTitle,
                    counterText: '',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 43, 43, 43),
                    ),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.textgreyColor)),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: AppStrings.priorityTypeHint),
                validator: (value) {
                  if (Validation.isNotCheckedMin(value)) {
                    return AppStrings.minPriorityTypeError;
                  } else if (Validation.isNotChecked2(value)) {
                    return AppStrings.maxPriorityTypeError;
                  } else if (Validation.isAlphaNumericWithSpecialChars(value)) {
                    return AppStrings.alphaNumericError.replaceAll('@fieldName', AppStrings.priorityType);
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
                  final state = context.read<PriorityTypeBloc>().state;
                  PriorityType priorityType = PriorityType(id: state.selectedPriorityType!.id!, name: priorityTypeUpdateController.text);
                  debugPrint("Click worked???? ");
                  context.read<PriorityTypeBloc>().add(PriorityTypeUpdateEvent(page: 0, priorityType: priorityType));
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
                context.read<PriorityTypeBloc>().add(PriorityTypePageChangeEvent(page: 0));
              },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }

  _buildPriorityTypeDelete() {
    final state = context.read<PriorityTypeBloc>().state;
    return <Widget>[
      Padding(padding: inset16, child: Text(AppStrings.subTitleDeletePriorityType, style: subMenuTitle)),
      CustomBottomBorderContainer(),
      Padding(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.selectedPriorityType!.name!,
                style: textNormal22,
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
                final state = context.read<PriorityTypeBloc>().state;
                if (state.selectedPriorityType != null) {
                  context.read<PriorityTypeBloc>().add(PriorityTypeDeleteEvent(page: 0, id: state.selectedPriorityType!.id!));
                }
                /*showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete Priority Type'),
                      content: const Text(
                          'Do you want to delete the Priority Type really?'),
                      backgroundColor: const Color.fromARGB(255, 248, 169, 169),
                      actions: [
                        TextButton(
                          onPressed: () {
                            final state =
                                context.read<PriorityTypeBloc>().state;
                            if (state.selectedPriorityType != null) {
                              context.read<PriorityTypeBloc>().add(
                                  PriorityTypeDeleteEvent(
                                      page: 0,
                                      id: state.selectedPriorityType!.id!));
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
                context.read<PriorityTypeBloc>().add(PriorityTypePageChangeEvent(page: 0));
              },
              text: AppStrings.cancel,
            )
          ]))
    ];
  }
}
