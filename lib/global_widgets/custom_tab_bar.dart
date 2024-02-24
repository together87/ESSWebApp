import '../common_libraries.dart';

class CustomTabBar extends StatefulWidget {
  final int activeIndex;
  final Map<String, Widget> tabs;
  final Future<bool> Function(int, int) onTabClick;
  const CustomTabBar({
    super.key,
    required this.activeIndex,
    required this.tabs,
    required this.onTabClick,
  });

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  int _activeIndex = 0;
  @override
  void initState() {
    _activeIndex = widget.activeIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: List.generate(
              widget.tabs.length,
              (index) => CustomTabBarItem(
                active: index == _activeIndex,
                isLast: widget.tabs.length == index + 1 ? true : false,
                isFirst: index == 0 ? true : false,
                name: widget.tabs.keys.toList()[index],
                onClick: () async {
                  if (await widget.onTabClick(index, _activeIndex)) {
                    setState(() => _activeIndex = index);
                  }
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: widget.tabs[widget.tabs.keys.toList()[_activeIndex]],
        ),
      ],
    );
  }
}

class CustomTabBarItem extends StatefulWidget {
  final bool active;
  final bool isLast;
  final bool isFirst;
  final String name;
  final VoidCallback onClick;
  const CustomTabBarItem({
    super.key,
    required this.active,
    required this.isLast,
    required this.isFirst,
    required this.name,
    required this.onClick,
  });

  @override
  State<CustomTabBarItem> createState() => _CustomTabBarItemState();
}

class _CustomTabBarItemState extends State<CustomTabBarItem> {
  Color _getBackgroundColor() {
    if (widget.active) {
      return AppColors.tabcolor;
    } else {
      return AppColors.buttonunselect;
    }
  }

  BorderRadius _getShape() {
    if (widget.isLast) {
      return const BorderRadius.only(bottomRight: Radius.circular(4), topRight: Radius.circular(4), bottomLeft: Radius.zero, topLeft: Radius.zero);
    } else if (widget.isFirst) {
      return const BorderRadius.only(bottomLeft: Radius.circular(4), topLeft: Radius.circular(4), bottomRight: Radius.zero, topRight: Radius.zero);
    } else {
      return const BorderRadius.all(Radius.zero);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onClick,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(0.0),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide.none, // Remove left-side border for all button states
        ),
        shape: MaterialStateProperty.resolveWith(
          (states) {
            return RoundedRectangleBorder(
              borderRadius: _getShape(),
            );
          },
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 15), // Adjust the padding values as needed
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) {
            return _getBackgroundColor();
          },
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          widget.name,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
