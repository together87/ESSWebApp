import '/common_libraries.dart';
import 'widget.dart';

class AddEditView extends StatelessWidget {
  final GlobalKey<FormState> validationKey;
  const AddEditView(this.validationKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditProjectBloc, AddEditProjectState>(builder: (context, state) {
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
              leftLabel: AppStrings.projectTitle,
              leftChild: const ProjectNameField(),
              leftValidationMessage: state.nameValidationMessage,
              rightLabel: AppStrings.projectNumber,
              rightChild: const ProjectNumberField(),
              rightValidationMessage: state.numberValidationMessage,
            ),
            FormItemVertical(
              leftLabel: AppStrings.projectSite,
              leftChild: const SiteSelectBox(label: AppStrings.projectSite),
              leftValidationMessage: state.siteValidationMessage,
              rightLabel: AppStrings.projectDirector,
              rightChild: const DirectorSelectBox(label: AppStrings.projectDirector),
              rightValidationMessage: state.directorValidationMessage,
            ),
            FormItemVertical(
              leftLabel: AppStrings.projectReference,
              leftChild: const ProjectReferenceField(),
              leftValidationMessage: state.referenceValidationMessage,
              rightLabel: '',
              rightChild: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: CustomSwitch(
                        switchValue: state.activeStatus,
                        onChanged: (value) {
                          context.read<AddEditProjectBloc>().add(AddEditProjectActiveStatusChanged(activeStatus: value));
                        },
                        label: "Active",
                        active: true,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomSwitch(
                      switchValue: state.kpiStatus,
                      onChanged: (value) {
                        context.read<AddEditProjectBloc>().add(AddEditProjectKPIStatusChanged(kpiStatus: value));
                      },
                      label: "KPI",
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: CustomSwitch(
                      switchValue: state.peerReviewRequiredStatus,
                      onChanged: (value) {
                        context.read<AddEditProjectBloc>().add(AddEditProjectPeerReviewRequiredStatusStatusChanged(peerReviewRequiredStatus: value));
                      },
                      label: "Peer Review Required",
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
