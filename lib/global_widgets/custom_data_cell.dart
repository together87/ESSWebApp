import '/common_libraries.dart';

class CustomDataCell extends StatefulWidget {
  final dynamic data;
  final VoidCallback? onRowClick;
  final VoidCallback? onDeleteClick;
  final VoidCallback? onEditClick;
  final int maxLines;
  const CustomDataCell({
    super.key,
    required this.data,
    this.onRowClick,
    this.onDeleteClick,
    this.onEditClick,
    this.maxLines = 3,
  });

  @override
  State<CustomDataCell> createState() => _CustomDataCellState();
}

class _CustomDataCellState extends State<CustomDataCell> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    String content = widget.data.toString();
    if (widget.data is bool) {
      return widget.data
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.green.shade200),
              child: const Text(
                'Activated',
                style: TextStyle(fontSize: 11, color: AppColors.greeenColor),
              ))
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red.shade200),
              child: const Text(
                'Deactivated',
                style: TextStyle(fontSize: 11, color: Colors.red),
              ));
    } else if (widget.data is Color) {
      return Container(
        constraints: const BoxConstraints(
          maxWidth: 300,
        ),
        height: 20,
        decoration: BoxDecoration(
          color: widget.data,
          border: Border.all(
            color: widget.data == Colors.white ? grey : Colors.transparent,
            width: 1,
          ),
        ),
      );
    } else if (widget.data is List) {
      content = widget.data.join(', ');
    } else if (widget.data is IconData) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              if (widget.onEditClick != null) {
                widget.onEditClick!();
              }
            },
            icon: const FaIcon(
              FontAwesomeIcons.pen,
              color: Colors.green,
              size: 15,
            ),
          ),
          IconButton(
            onPressed: () {
              if (widget.onDeleteClick != null) {
                widget.onDeleteClick!();
              }
            },
            icon: const FaIcon(
              FontAwesomeIcons.trashCan,
              color: Colors.red,
              size: 15,
            ),
          ),
        ],
      );
    }

    return MouseRegion(
      onEnter: (_) {
        if (widget.onRowClick != null) {
          setState(() => isHover = true);
        }
      },
      onExit: (_) {
        if (widget.onRowClick != null) {
          setState(() => isHover = false);
        }
      },
      child: GestureDetector(
        onTap: () {
          if (widget.onRowClick != null) {
            widget.onRowClick!();
          }
        },
        child: Text(
          content,
          style: TextStyle(
            fontSize: 13,
            fontFamily: "Montserrat",
            fontWeight: content == "Total" ? FontWeight.w600 : FontWeight.w400,
            decoration: isHover ? TextDecoration.underline : null,
            decorationStyle: isHover ? TextDecorationStyle.dotted : null,
            decorationColor: primaryColor,
            decorationThickness: 3,
          ),
          maxLines: widget.maxLines,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
