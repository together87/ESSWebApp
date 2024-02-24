import 'package:ecosys_safety/constants/app_colors.dart';

import '/features/theme/view/widgets/sidebar/sidebar_style.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 4,
      height: 40,
      child: TextField(
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 8,
          ),
          fillColor: AppColors.generalBgColor,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide.none,),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(5),
          ),
          hintText: 'Search',
          hintStyle: const TextStyle(
            color: Color(0xff909092),
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            PhosphorIconsRegular.magnifyingGlass,
            size: 20,
            color: Color(0xff909092),
          ),
          suffixIcon: InkWell(
            onTap: () {},
            child: Icon(
              PhosphorIconsRegular.fadersHorizontal,
              size: 20,
              color: backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
