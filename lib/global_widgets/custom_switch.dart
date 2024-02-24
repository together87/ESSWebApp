import '/common_libraries.dart';

class CustomSwitch extends StatefulWidget {
  final String label;
  final bool switchValue;
  final String trueString;
  final String falseString;
  final bool onlySwitch;
  final Color textColor;
  final bool active;
  final ValueChanged<bool> onChanged;

  const CustomSwitch({
    super.key,
    this.label = '',
    required this.switchValue,
    required this.onChanged,
    this.trueString = 'Deactivated',
    this.falseString = '',
    this.onlySwitch = false,
    this.textColor = Colors.red,
    this.active = true,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool switchValue;

  @override
  void initState() {
    switchValue = widget.switchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Switch(
          value: widget.switchValue,
          activeTrackColor: Colors.grey.shade300,
          inactiveTrackColor: Colors.grey.shade300,
          activeColor: widget.active ? successColor : lightRed,
          onChanged: (val) {
            setState(() => switchValue = !switchValue);
            if (widget.active) {
              widget.onChanged(val);
            }
          },
        ),
        widget.onlySwitch
            ? Container()
            : Expanded(
                child: Tooltip(
                  message: widget.label,
                  child: Text(
                    widget.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textNormal14,
                  ),
                ),
              )
      ],
    );
  }
}
