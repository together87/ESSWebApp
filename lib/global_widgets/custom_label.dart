
import '/common_libraries.dart';
class CustomLabel extends StatelessWidget {
  final String message;
  final EdgeInsetsGeometry labelPadding;
  final TextStyle labelStyle;
  const CustomLabel(
      {super.key, required this.message, required this.labelPadding,required this.labelStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: labelPadding,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 242, 247),
          border: Border.all(
              color: const Color.fromARGB(255, 206, 212, 218), width: 1),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
        ),
        child: Text(
          message,
          style: labelStyle
        ));
  }
}
