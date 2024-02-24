import '/common_libraries.dart';

class SiteCodeField extends StatelessWidget {
  const SiteCodeField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditSiteBloc, AddEditSiteState>(builder: (context, state) {
      return CustomTextNewField(
        initialValue: state.siteCode,
        maxLength: 50,
        hintText: AppStrings.siteCodeHint,
        validator: (value) {
          if (value == '' || Validation.isNotCheckedMin(value)) {
            return "";
          } else {
            return null;
          }
        },
        onChanged: (value) {
          context.read<AddEditSiteBloc>().add(AddEditSiteCodeChanged(
                code: value,
              ));
        },
      );
    });
  }
}
