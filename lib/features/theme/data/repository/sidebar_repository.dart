import 'package:ecosys_safety/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../model/sidebar_item.dart';

class SidebarRepository {
  static List<SidebarItemModel> mainItems = <SidebarItemModel>[
    SidebarItemModel(
      label: 'Dashboard',
      color: AppColors.yellow,
      iconData: FontAwesomeIcons.gaugeHigh,
      subItems: <SidebarItemModel>[
        SidebarItemModel(
          label: 'Analytics',
          path: 'analytics',
          color: AppColors.yellow,
        ),
        SidebarItemModel(
          label: 'CRM',
          path: 'crm',
          color: AppColors.yellow,
        ),
        SidebarItemModel(
          label: 'Ecommerce',
          path: 'ecommerce',
          color: AppColors.yellow,
        ),
        SidebarItemModel(
          label: 'Crypto',
          path: 'crypto',
          color: AppColors.yellow,
        ),
        SidebarItemModel(
          label: 'NFT',
          color: AppColors.yellow,
          path: 'nft',
        ),
        SidebarItemModel(
          label: 'Job',
          color: AppColors.yellow,
          path: 'job',
        ),
      ],
    ),
    SidebarItemModel(
      label: 'Sites',
      color: AppColors.yellow,
      path: 'sites',
      iconData: FontAwesomeIcons.sitemap,
       ),
     SidebarItemModel(
      label: 'Projects',
      path: 'projects',
      color: AppColors.yellow,
      iconData: FontAwesomeIcons.productHunt,
       ),
    SidebarItemModel(
      label: 'People',
      color: AppColors.yellow,
      iconData: FontAwesomeIcons.peopleGroup,
      subItems: <SidebarItemModel>[
        SidebarItemModel(
          label: 'Companies',
          path: 'companies',
          color: AppColors.yellow,
          iconData: FontAwesomeIcons.teamspeak
        ),
        SidebarItemModel(
          label: 'Users',
          path: 'users',
          color: AppColors.yellow,
          iconData: FontAwesomeIcons.userGroup
        ),
        SidebarItemModel(
          label: 'Personnel',
          path: 'personnel',
          color: AppColors.yellow,
          iconData: FontAwesomeIcons.person
        ),
        SidebarItemModel(
          label: 'Work Hours',
          path: 'work_hours',
          color: AppColors.yellow,
          iconData: FontAwesomeIcons.hourglassStart
        ),
      ],
    ),
     
  ];

  static List<SidebarItemModel> administrationItems = <SidebarItemModel>[
    SidebarItemModel(
      label: 'Master Data',
      iconData: FontAwesomeIcons.listCheck,
      subItems: <SidebarItemModel>[
        SidebarItemModel(
            label: 'Regions & Time zones',
            color: AppColors.yellow,
            path: 'regions',
            iconData: FontAwesomeIcons.globe),
        SidebarItemModel(
            label: 'Priority Types',
            color: AppColors.yellow,
            path: 'priority_types',
            iconData: FontAwesomeIcons.arrowDownWideShort),
        SidebarItemModel(
            label: 'Priority Levels',
            color: AppColors.yellow,
            path: 'priority_levels',
            iconData: FontAwesomeIcons.listOl),
        SidebarItemModel(
            label: 'Severity Levels',
            color: AppColors.yellow,
            path: 'severity_levels',
            iconData: FontAwesomeIcons.icicles),
        SidebarItemModel(
            label: 'Observation Types',
            color: AppColors.yellow,
            path: 'observation_types',
            iconData: FontAwesomeIcons.microscope),
        SidebarItemModel(
            label: 'Awareness Categories',
            color: AppColors.yellow,
            path: 'awareness_categories',
            iconData: FontAwesomeIcons.volumeHigh),
      ],
      color: AppColors.yellow,
    )
  ];

  static List<SidebarItemModel> profileItems = <SidebarItemModel>[
    SidebarItemModel(
      label: 'Logout',
      color: AppColors.yellow,
      path: 'logout',
    ),
  ];

  static List<SidebarItemModel> getItems() {
    List<SidebarItemModel> items = List.from(mainItems);
    for (var item in administrationItems) {
      for (var i in item.subItems) {
        items.add(i);
      }
      if (item.subItems.isEmpty) {
        items.add(item);
      }
    }
    return items;
  }

  static String getPath(String label) {
    return [...mainItems, ...administrationItems]
        .firstWhere((element) => element.label == label)
        .path;
  }
}
