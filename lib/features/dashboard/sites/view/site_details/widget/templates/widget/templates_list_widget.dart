import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../../../../../common_libraries.dart';
import '/constants/dimens.dart';

class TemplatesListWidget extends StatefulWidget {
  const TemplatesListWidget({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _TemplateListWidgetState();
}

class _TemplateListWidgetState extends State<TemplatesListWidget> {
  DataGridController dataGridController = DataGridController();

  List<String> get items {
    return const [
      "Hygiene and Food Supply Audit",
      "Parking anti freeze conditions",
      "Signage and guidance audit",
      "Storage facility Fire Hazard Audit",
      "Lab Hygiene and Waste Disposal Audit",
      "HVAC and Environment Audit",
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    TextStyle valueStyle = textNormal12.copyWith(color: themeData.textColor, fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'Montserrat');
    return BlocBuilder<SiteDetailsBloc, SiteDetailsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              for (final companies in items)
                CustomBottomBorderContainer(
                  padding: insetx16y10,
                  alignment: Alignment.centerLeft,
                  child: Text(companies, style: valueStyle),
                ),
            ],
          ),
        );
      },
    );
  }
}
