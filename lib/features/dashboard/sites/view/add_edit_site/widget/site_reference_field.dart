import '/common_libraries.dart';

class SiteReferenceField extends StatelessWidget {
  const SiteReferenceField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditSiteBloc, AddEditSiteState>(builder: (context, state) {
      return CustomTextNewField(
        initialValue: state.reference,
        maxLength: 50,
        hintText: AppStrings.projectReferenceHint,
        isNumber: true,
        validator: (value) {
          if (value == '' || Validation.isNotCheckedMin(value)) {
            return "";
          } else {
            return null;
          }
        },
        onChanged: (value) {
          context.read<AddEditSiteBloc>().add(AddEditSiteReferenceChanged(
                reference: value,
              ));
        },
      );
    });
  }
}
