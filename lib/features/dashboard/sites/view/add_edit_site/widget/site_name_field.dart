import '/common_libraries.dart';

class SiteNameField extends StatelessWidget {
  const SiteNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditSiteBloc, AddEditSiteState>(
        builder: (context, state) {
      return CustomTextNewField(
        initialValue: state.siteName,
        maxLength: 50,
        hintText: AppStrings.siteNameHint,
        validator: (value) {
          if (value == '' || Validation.isNotCheckedMin(value)) {
            return "";
          } else {
            return null;
          }
        },
        onChanged: (name) {
          context.read<AddEditSiteBloc>().add(AddEditSiteNameChanged(name: name,));
        },
      );
    });
  }
}
