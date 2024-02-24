import '/common_libraries.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, this.width, this.height, this.onChanged});
  final double? width;
  final double? height;
  final ValueChanged<String>? onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: CustomTextField(
            onChanged: onChanged,
            hintText: 'Search to ...',
            isBorderStatus: false,
            textAlignVertical: TextAlignVertical.bottom,
          ),
        ),
        Container(
            padding: inset10,
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 206, 212, 218), width: 1),
              borderRadius: const BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
            ),
            child: const Icon(Icons.search, size: 18))
      ],
    );
  }
}
