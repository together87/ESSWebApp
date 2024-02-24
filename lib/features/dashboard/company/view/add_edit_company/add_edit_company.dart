import '/common_libraries.dart';
import 'widget/widget.dart';

class AddEditCompanyView extends StatelessWidget {
  final String? companyId;
  const AddEditCompanyView({
    super.key,
    this.companyId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditCompanyBloc(context),
      child: AddEditCompanyWidget(
        companyId: companyId,
      ),
    );
  }
}

class AddEditCompanyWidget extends StatefulWidget {
  final String? companyId;
  const AddEditCompanyWidget({
    super.key,
    this.companyId,
  });

  @override
  State<AddEditCompanyWidget> createState() => _AddEditCompanyWidgetState();
}

class _AddEditCompanyWidgetState extends State<AddEditCompanyWidget> {
  late AddEditCompanyBloc addEditProjectBloc;
  final validationKey = GlobalKey<FormState>();
  static String pageLabel = '';
  static String cancelPath = 'companies';

  @override
  void initState() {
    addEditProjectBloc = context.read();
    // ..add(AddEditProjectDirectorListLoaded())
    // ..add(AddEditProjectSiteListLoaded());

    pageLabel = widget.companyId != null
        ? AppStrings.subTitleUpdateCompanies
        : AppStrings.subTitleCreateCompanies;

    if (widget.companyId != null) {
      addEditProjectBloc
          .add(AddEditCompanyLoaded(companyId: widget.companyId!));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditCompanyBloc, AddEditCompanyState>(
      builder: (context, state) {
        return AddEditEntityTemplate(
          label: pageLabel,
          id: widget.companyId,
          iconData: FontAwesomeIcons.teamspeak,
          cancelPath: cancelPath,
          crudStatus: state.status,
          addEntity: () {
            validationKey.currentState!.validate();
            context.read<AddEditCompanyBloc>().add(AddEditCompanyAdded());
          },
          editEntity: () {
            validationKey.currentState!.validate();
            context.read<AddEditCompanyBloc>().add(
                AddEditCompanyEdited(companyId: widget.companyId.toString()));
          },
          screenName:
              widget.companyId != null ? "Edit Companies" : "Add Companies",
          screenNameOne: 'Companies / ',
          screenNameTwo:
              widget.companyId != null ? "Edit Companies" : "Add Companies",
          child: AddEditView(validationKey),
        );
      },
      listener: (context, state) {
        if (state.status.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            title: state.title,
            content: state.message,
          ).showNotification();
          context.go('/companies');
        }
        if (state.status.isFailure) {
          CustomNotification(
            context: context,
            title: state.title,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      listenWhen: (previous, current) => previous.status != current.status,
    );
  }
}
