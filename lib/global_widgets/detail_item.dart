import '/common_libraries.dart';

class AuditDetailItemView extends StatelessWidget {
  final String label;
  final String content;
  final bool twoLines;
  final bool highlighted;
  final VoidCallback? onClick;
  const AuditDetailItemView({
    super.key,
    required this.label,
    required this.content,
    this.twoLines = false,
    this.highlighted = false,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    TextStyle labelStyle = textSemiBold12.copyWith(
      color: themeData.textColor,
      fontSize: 13,
      fontWeight: FontWeight.w600,
    );
    TextStyle valueStyle = textNormal12.copyWith(
      color: themeData.textColor,
      fontSize: 13,
      fontWeight: FontWeight.w400,
    );
    if (twoLines) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomBottomBorderContainer(
            padding: inset10,
            child: Text(label, style: labelStyle),
          ),
          CustomBottomBorderContainer(
            padding: inset10,
            child: Text(
              label.isEmpty
                  ? ''
                  : content.isEmpty
                      ? '--'
                      : content,
              style: valueStyle,
            ),
          )
        ],
      );
    } else {
      return CustomBottomBorderContainer(
        padding: inset12,
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: labelStyle,
              ),
            ),
            spacerx20,
            Expanded(
              child: highlighted
                  ? MouseRegion(
                      cursor: highlighted ? SystemMouseCursors.click : MouseCursor.defer,
                      child: GestureDetector(
                        onTap: highlighted ? onClick : null,
                        child: Container(
                          padding: inset0,
                          child: Text(
                            label.isEmpty
                                ? ''
                                : content.isEmpty
                                    ? '--'
                                    : content,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: valueStyle.copyWith(
                              color: highlighted ? primaryColor : themeData.textColor,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Text(
                      label.isEmpty
                          ? ''
                          : content.isEmpty
                              ? '--'
                              : content,
                      style: valueStyle,
                    ),
            ),
          ],
        ),
      );
    }
  }
}
