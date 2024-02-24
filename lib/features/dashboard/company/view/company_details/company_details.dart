import 'package:ecosys_safety/features/dashboard/company/view/company_details/widget/projects/project.dart';
import 'package:ecosys_safety/features/dashboard/company/view/company_details/widget/sites/sites.dart';

import '/common_libraries.dart';
import 'widget/widget.dart';

class CompanyDetailsView extends StatelessWidget {
  final String companyId;
  const CompanyDetailsView({
    super.key,
    required this.companyId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyDetailsBloc(context, companyId),
      child: CompanyDetailsWidget(
        companyId: companyId,
      ),
    );
  }
}

class CompanyDetailsWidget extends StatefulWidget {
  final String? companyId;
  const CompanyDetailsWidget({
    super.key,
    this.companyId,
  });

  @override
  State<CompanyDetailsWidget> createState() => _CompanyDetailsWidgetState();
}

class _CompanyDetailsWidgetState extends State<CompanyDetailsWidget> {
  static String pageLabel = AppStrings.pageTitleCompany;

  @override
  void initState() {
    context.read<CompanyDetailsBloc>().add(CompanyDetailsLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyDetailsBloc, CompanyDetailsState>(
      builder: (context, state) {
        return DetailsEntityTemplate(
          label: pageLabel,
          id: widget.companyId,
          iconData: FontAwesomeIcons.bacon,
          crudStatus: state.status,
          tabItems: {
            'Dashboard': Container(),
            'Projects': TabProjectView(widget.companyId!, "Projects"),
            'Sites': TabSiteView(widget.companyId!, 'Sites'),
            'Audit Trail': Container(),
          },
          onTabClick: (index) async {
            return true;
          },
          screenName: 'Companies Detail',
          screenNameOne: 'Companies / ',
          screenNameTwo: 'Companies Detail',
          child: const CompanyInformationView(),
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
