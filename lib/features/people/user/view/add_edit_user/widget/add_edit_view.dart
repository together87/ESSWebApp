import '/common_libraries.dart';
import 'widget.dart';

class AddEditView extends StatelessWidget {
  final GlobalKey<FormState> validationKey;
  const AddEditView(this.validationKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditUsersBloc, AddEditUsersState>(builder: (context, state) {
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
              leftLabel: AppStrings.userFirstName,
              leftChild: const UserFirstNameField(),
              leftValidationMessage: state.firstNameValidationMessage,
              rightLabel: AppStrings.userLastName,
              rightChild: const UserLastNameField(),
              rightValidationMessage: state.lastNameValidationMessage,
            ),
            FormItemVertical(
              leftLabel: AppStrings.userTitle,
              leftChild: const UserTitleField(),
              rightLabel: AppStrings.userEmail,
              rightChild: const UserEmailField(),
              rightValidationMessage: state.emailValidationMessage,
            ),
            FormItemVertical(
              leftLabel: AppStrings.userPhone,
              leftChild: UserMobileField(),
              rightLabel: AppStrings.projectSite,
              rightChild: SiteSelectBox(),
              rightValidationMessage: state.siteValidationMessage,
            ),
            FormItemVertical(
              leftLabel: AppStrings.userRole,
              leftChild: RoleSelectBox(),
              leftValidationMessage: state.roleValidationMessage,
              rightChild: SizedBox(),
            ),
          ],
        ),
      );
    });
  }
}
