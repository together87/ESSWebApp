import '/common_libraries.dart';

class CustomButton extends StatefulWidget {
  final Color backgroundColor;
  final TextStyle textStyle;
  final IconData? iconData;
  final Color iconColor;
  final Color iconBGColor;
  final double iconSize;
  final String text;
  final VoidCallback? onClick;
  final bool disabled;
  final Widget? body;
  final EdgeInsets padding;
  final EdgeInsets iconpadding;
  final double borderRadius;
  final Color borderColor;
  final bool isOnlyIcon;
  final bool isNoBorder;
  const CustomButton({
    Key? key,
    required this.backgroundColor,
    this.textStyle = const TextStyle(
      color: Colors.white,
    ),
    this.borderRadius = 8,
    this.padding = const EdgeInsets.symmetric(vertical: 16 * 1.1, horizontal: 12),
    this.iconpadding = const EdgeInsets.fromLTRB(0, 2.5, 0, 2.5),
    this.iconColor = Colors.white,
    this.iconBGColor = Colors.blue,
    this.borderColor = Colors.white,
    this.iconData,
    this.text = '',
    this.onClick,
    this.iconSize = 18,
    this.disabled = false,
    this.body,
    this.isOnlyIcon = false,
    this.isNoBorder = false,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius), // Set the border radius as desired
            side: BorderSide(color: !widget.isNoBorder ? widget.backgroundColor : Colors.transparent, width: 1.2), // Set the border color and width
          ),
          padding: widget.padding,
          shadowColor: Colors.transparent),
      child: widget.body ??
          Wrap(
            children: [
              widget.iconData == null
                  ? Container()
                  : Icon(
                      widget.iconData,
                      size: widget.iconSize,
                      color: isHover ? Colors.white : widget.iconColor,
                    ),
              if (widget.iconData != null && !widget.isOnlyIcon) spacerx8,
              if (!widget.isOnlyIcon)
                Text(
                  widget.text,
                  style: widget.textStyle,
                ),
            ],
          ),
      onPressed: () => widget.disabled
          ? null
          : widget.onClick == null
              ? null
              : widget.onClick!(),
    );
  }
}
