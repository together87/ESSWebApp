import 'package:ecosys_safety/common_libraries.dart';
import 'package:ecosys_safety/constants/app_colors.dart';

class CustomEmptyPageWidget extends StatelessWidget {
  final String message;

  const CustomEmptyPageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: insety30,
        child: Text(
          message,
          style: textSemiBold12.copyWith(color: AppColors.textgreyColor),
        ),
      ),
    );
  }
}