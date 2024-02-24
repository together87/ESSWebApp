import 'package:flutter/material.dart';

class CustomTab extends StatefulWidget {
  ///Widgets that placed inside sliders
  final List<Widget> children;

  ///The function takes an index variable, which varies depending on the index of the current slider
  final void Function(int index) onSelect;

  ///Container height
  final double containerHeight;

  ///Container width
  final double containerWidth;

  ///The color of each slider. A single color in the array will fill all sliders
  final List<Color> slidersColors;

  ///The gradient of each slider. A single gradient in the array will fill all sliders
  final List<LinearGradient> slidersGradients;

  ///Container border widget
  final Border containerBorder;

  ///Slider border widget
  final Border slidersBorder;

  ///Container corner rounding radius
  final double containerBorderRadius;

  ///Container fill color
  final Color containerColor;

  ///Indents between the container and the sliders (the same on all sides)
  final double indents;

  ///Defining the direction of the slider swipe
  final Axis direction;

  ///A shadow cast by a box
  final List<BoxShadow> containerBoxShadow;

  ///Ability to tap on the current slider and change its index to the opposite (available only for 2 children)
  final bool isAllContainerTap;

  ///Initial index of the slider, which is rendering for the first time
  final int initialIndex;

  final Color borderColor;

  ///A class for creating sliders
  const CustomTab({
    Key? key,
    required this.children,
    required this.containerHeight,
    required this.containerWidth,
    required this.onSelect,
    this.containerBorder = const Border(),
    this.slidersBorder = const Border(),
    this.indents = 0,
    this.slidersColors = const [Colors.white],
    this.slidersGradients = const [],
    this.containerColor = Colors.grey,
    this.containerBorderRadius = 1000,
    this.direction = Axis.horizontal,
    this.containerBoxShadow = const [],
    this.isAllContainerTap = false,
    this.initialIndex = 0,
    this.borderColor = Colors.black,
  }) : super(key: key);

  @override
  _CustomTabState createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab>
    with SingleTickerProviderStateMixin {
  late final double sliderBorderRadius;
  late final double slidersHeight;
  late final double slidersWidth;
  late final double containerBorderHeight;
  late final double containerBorderWight;
  late final bool verticalBadSize;
  late final bool horizontalBadSize;
  late final EdgeInsets padding;
  late int index;
  int lastIndex = -1;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 150),
    vsync: this,
  );
  late Animation<Offset> offsetAnimation = Tween<Offset>(
    begin: Offset(widget.initialIndex.toDouble(), 0.0),
    end: widget.direction == Axis.horizontal
        ? const Offset(1.0, 0.0)
        : const Offset(0.0, 1.0),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ),
  );

  @override
  void initState() {
    verticalBadSize = widget.direction == Axis.vertical &&
        widget.containerHeight < widget.containerWidth * widget.children.length;

    horizontalBadSize = widget.direction == Axis.horizontal &&
        widget.containerHeight * widget.children.length > widget.containerWidth;

    containerBorderHeight =
        widget.containerBorder.top.width + widget.containerBorder.bottom.width;

    containerBorderWight =
        widget.containerBorder.left.width + widget.containerBorder.right.width;

    sliderBorderRadius =
        (widget.containerHeight - widget.indents - containerBorderWight) *
            (widget.containerBorderRadius / widget.containerHeight);

    if (widget.direction == Axis.horizontal) {
      slidersHeight =
          widget.containerHeight - widget.indents * 2 - containerBorderHeight;
      padding = EdgeInsets.symmetric(horizontal: widget.indents);
      slidersWidth =
          (widget.containerWidth - widget.indents * 2 - containerBorderWight) /
              widget.children.length;
    } else {
      slidersWidth =
          widget.containerWidth - widget.indents * 2 - containerBorderWight;
      padding = EdgeInsets.symmetric(vertical: widget.indents);
      slidersHeight = (widget.containerHeight -
              widget.indents * 2 -
              containerBorderHeight) /
          widget.children.length;
    }
    index = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (lastIndex == -1) _checkForExceptions();
    return Container(
      height: widget.children.isEmpty ? 0 : widget.containerHeight,
      width: widget.children.isEmpty ? 0 : double.infinity,
      decoration: BoxDecoration(
        color: widget.containerColor,
        borderRadius: BorderRadius.circular(widget.containerBorderRadius),
        border: widget.containerBorder,
        boxShadow: widget.containerBoxShadow,
      ),
      child: Stack(
        alignment: widget.direction == Axis.horizontal
            ? Alignment.centerLeft
            : Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 1,
              color: widget.borderColor,
            ),
          ),
          Padding(
            padding: padding,
            child: SlideTransition(
              position: offsetAnimation,
              child: SizedBox(
                width: slidersWidth,
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      height: slidersHeight,
                      decoration: BoxDecoration(
                        border: widget.slidersBorder,
                        borderRadius: _makingBorder(index),
                        color: widget.slidersGradients.isEmpty
                            ? widget.slidersColors[
                                index + 1 > widget.slidersGradients.length
                                    ? 0
                                    : index]
                            : null,
                        gradient: widget.slidersGradients.isNotEmpty
                            ? widget.slidersGradients[
                                index + 1 > widget.slidersGradients.length
                                    ? 0
                                    : index]
                            : null,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 1,
                        width: slidersWidth - 2,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: padding,
            child: Flex(
              direction: widget.direction,
              children: List.generate(
                widget.children.length,
                (slidersIndex) => GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    if (slidersIndex != widget.children.length - 1) {
                      _slidersOnTap(
                        widget.isAllContainerTap && widget.children.length == 2
                            ? 1 - index
                            : slidersIndex,
                      );
                    }
                  },
                  onHorizontalDragEnd: widget.direction == Axis.horizontal
                      ? (details) {
                          _slidersOnSwipe(details);
                        }
                      : null,
                  onVerticalDragEnd: widget.direction == Axis.vertical
                      ? (details) {
                          _slidersOnSwipe(details);
                        }
                      : null,
                  child: Container(
                    height: slidersHeight,
                    width: slidersWidth,
                    decoration: slidersIndex == index
                        ? null
                        : BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: widget.borderColor,
                              ),
                            ),
                          ),
                    child: SizedBox(
                      child: Center(
                        child: widget.children[slidersIndex],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BorderRadius _makingBorder(int index) {
    return BorderRadius.only(
      // bottomLeft: index == 0 && verticalBadSize ||
      //         index == widget.children.length - 1 && horizontalBadSize
      //     ? Radius.zero
      //     : Radius.circular(sliderBorderRadius),
      // bottomRight: index == 0 && (verticalBadSize || horizontalBadSize)
      //     ? Radius.zero
      //     : Radius.circular(sliderBorderRadius),
      topLeft: index == widget.children.length - 1 && verticalBadSize ||
              index == widget.children.length - 1 && horizontalBadSize
          ? Radius.zero
          : Radius.circular(sliderBorderRadius),
      topRight: index == widget.children.length - 1 && verticalBadSize ||
              index == 0 && horizontalBadSize
          ? Radius.zero
          : Radius.circular(sliderBorderRadius),
    );
  }

  void _slidersOnTap(int slidersIndex) {
    lastIndex = index;
    index = slidersIndex;
    setState(() {});
    widget.onSelect(index);
    if (widget.children.length == 2) {
      index == 1 ? _controller.forward() : _controller.reverse();
    } else {
      if (widget.direction == Axis.horizontal) {
        offsetAnimation = Tween<Offset>(
          begin: Offset(lastIndex.toDouble(), 0.0),
          end: Offset(index.toDouble(), 0.0),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.linear,
          ),
        );
      } else {
        offsetAnimation = Tween<Offset>(
          begin: Offset(0.0, lastIndex.toDouble()),
          end: Offset(0.0, index.toDouble()),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.linear,
          ),
        );
      }
      _controller.reset();
      _controller.forward();
    }
  }

  void _slidersOnSwipe(DragEndDetails details) {
    if (details.primaryVelocity! > 0 && index != widget.children.length - 1) {
      _slidersOnTap(index + 1);
    }
    if (details.primaryVelocity! < 0 && index != 0) {
      _slidersOnTap(index - 1);
    }
  }

  void _checkForExceptions() {
    if (widget.isAllContainerTap && widget.children.length != 2) {
      debugPrint(
          '\x1B[31mThe "isAllContainerTap" parameter can be "true" only when "children" length is 2\nRemove "isAllContainerTap" or make 2 "children"\x1B[0m');
      throw 'The "isAllContainerTap" parameter can be "true" only when "children" length is 2\nRemove "isAllContainerTap" or make 2 "children"';
    }

    double shortSide = widget.containerHeight > widget.containerWidth
        ? widget.containerWidth
        : widget.containerHeight;
    double longSide = widget.containerHeight > widget.containerWidth
        ? widget.containerHeight
        : widget.containerWidth;
    if (shortSide * widget.children.length * 0.5 > longSide &&
        widget.containerBorderRadius * 2 > shortSide &&
        widget.children.length != 2) {
      debugPrint(
          '\x1B[31mAll widgets from the list of "children" do not fit into the given container size.\nTry applying other container sizes\x1B[0m');
      throw 'All widgets from the list of "children" do not fit into the given container size.\nTry applying other container sizes';
    }
    lastIndex = 0;
  }
}
