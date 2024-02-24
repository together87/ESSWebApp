import '/common_libraries.dart';
import 'widget.dart';

class AddEditView extends StatelessWidget {
  final GlobalKey<FormState> validationKey;
  const AddEditView(this.validationKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditCompanyBloc, AddEditCompanyState>(builder: (context, state) {
      if (state.detailsLoaded.isLoading) {
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
      return Form(
        key: validationKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormItemVertical(
              leftLabel: AppStrings.companyTitle,
              leftChild: const CompanyNameField(),
              leftValidationMessage: state.companyNameValidationMessage,
              rightLabel: AppStrings.einNumber,
              rightChild: const EINCompanyNumberField(),
            ),
            const FormItemVertical(
              leftLabel: AppStrings.mainContactName,
              leftChild: MainContactNameField(),
              rightLabel: AppStrings.mainContactEmail,
              rightChild: MainContactEmailField(),
            ),
            const FormItemVertical(
              leftLabel: AppStrings.hypercareValue,
              leftChild: HypercareValueSelectBox(),
              rightLabel: AppStrings.prequalificationMethod,
              rightChild: PrequalificationSelectBox(),
            ),
            FormItemVertical(
              leftLabel: AppStrings.mainContactPhone,
              leftChild: const MainContactPhoneField(),
              rightLabel: '',
              rightChild: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Approval Status",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textNormal14.copyWith(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: state.approvalStatus,
                          activeColor: primaryColor,
                          onChanged: (value) {
                            context.read<AddEditCompanyBloc>().add(AddEditApprovalStatusChanged(approvalStatus: value!));
                          },
                        ),
                        Text(
                          "Approved",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textNormal14.copyWith(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Radio(
                          value: false,
                          groupValue: state.approvalStatus,
                          activeColor: primaryColor,
                          onChanged: (value) {
                            context.read<AddEditCompanyBloc>().add(AddEditApprovalStatusChanged(approvalStatus: value!));
                          },
                        ),
                        Text(
                          "Not Approved",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: textNormal14.copyWith(
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
