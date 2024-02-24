import '/common_libraries.dart';

class DirectorSelectBox extends StatelessWidget {
  final String label;
  const DirectorSelectBox({required this.label, super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditProjectBloc, AddEditProjectState>(builder: (context, state) {
      Map<String, Director> items = {}..addEntries(state.directorList.map((site) => MapEntry(site.name ?? '', site)));
      return CustomSingleSelect(
          items: items,
          hint: 'Select Project Director',
          height: 52,
          selectedValue: state.directorList.isEmpty ? null : state.director?.name,
          onChanged: (director) {
            context.read<AddEditProjectBloc>().add(AddEditProjectItemDirectorChanged(director: director.value));
          });
    });
  }
}
