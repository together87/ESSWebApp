import '/common_libraries.dart';

class CompanyInformationView extends StatelessWidget {
  const CompanyInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyDetailsBloc, CompanyDetailsState>(builder: (context, state) {
      if (state.detailsLoader.isLoading) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
          child: Center(
            child: Padding(
              padding: insety30,
              child: const Loader(),
            ),
          ),
        );
      }

      return Row(
        children: [
          Expanded(
            child: Column(
              children: [
                AuditDetailItemView(
                  label: 'Company ID',
                  content: state.company?.id.toString() ?? '',
                ),
                AuditDetailItemView(
                  label: 'Main Contact',
                  content: state.company?.mainContact.toString() ?? '',
                ),
                AuditDetailItemView(
                  label: 'Hypercare Value',
                  content: state.company?.hyperCareValue.toString() ?? '',
                ),
                AuditDetailItemView(
                  label: 'Prequalification Method',
                  content: state.company?.preQualificationMethod.toString() ?? '',
                ),
                AuditDetailItemView(
                  label: 'Grade',
                  content: state.company?.grade.toString() ?? '',
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                AuditDetailItemView(label: 'EIN', content: state.company?.ein.toString() ?? ''),
                AuditDetailItemView(label: 'Contact Email', content: state.company?.contactEmail.toString() ?? ''),
                AuditDetailItemView(label: 'Approval Status', content: state.company?.approvalStatus.toString() ?? ''),
                AuditDetailItemView(label: 'Company ID', content: state.company?.companyId.toString() ?? ''),
                AuditDetailItemView(label: 'Grade Date', content: state.company?.gradeDate.toString() ?? ''),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const AuditDetailItemView(label: '', content: ''),
                AuditDetailItemView(label: 'Contact Phone', content: state.company?.phone.toString() ?? ''),
                const AuditDetailItemView(label: '', content: ''),
                AuditDetailItemView(label: 'Company Name', content: state.company?.companyName.toString() ?? ''),
                const AuditDetailItemView(label: '', content: ''),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class ActionItemInformationItemView extends StatelessWidget {
  final String label;
  final String content;
  const ActionItemInformationItemView({
    super.key,
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomBorderContainer(
      padding: inset20,
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label:',
              style: textSemiBold14.copyWith(fontSize: 13),
            ),
          ),
          spacerx10,
          Expanded(
            flex: 2,
            child: Text(
              content,
              style: textNormal14.copyWith(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
