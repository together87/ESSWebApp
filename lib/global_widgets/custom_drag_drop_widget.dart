import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:ecosys_safety/common_libraries.dart';
import 'package:flutter/material.dart';

class DragAndDropWidget extends StatefulWidget {
  DragAndDropWidget({
    Key? key,
    required this.informationList1,
    required this.informationList2,
    required this.header1,
    required this.header2,
    this.listWidth = 500,
  }) : super(key: key);
  List<String> informationList1;
  List<String> informationList2;
  String header1;
  String header2;
  double listWidth;
  @override
  State createState() => _DragAndDropWidget();
}

class _DragAndDropWidget extends State<DragAndDropWidget> {
  late List<DragAndDropList> _contents = [];

  @override
  void initState() {
    super.initState();

    _contents.add(DragAndDropList(
        header: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Text(
                    widget.header1,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
        canDrag: false,
        children: List<DragAndDropItem>.generate(
          widget.informationList1.length,
          (index) => DragAndDropItem(
            child: Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    widget.informationList1[index],
                    style: textNormal12.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ],
            ),
          ),
        )));
    _contents.add(DragAndDropList(
        header: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 10),
                  child: Text(
                    widget.header2,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
        canDrag: false,
        children: List<DragAndDropItem>.generate(
          widget.informationList2.length,
          (index) => DragAndDropItem(
            child: Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    widget.informationList2[index],
                    style: textNormal12.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ],
            ),
          ),
        )));
  }

  @override
  Widget build(BuildContext context) {
    var backgroundColor = const Color.fromARGB(255, 243, 242, 248);
    return DragAndDropLists(
      children: _contents,
      onItemReorder: _onItemReorder,
      onListReorder: _onListReorder,
      axis: Axis.horizontal,
      listWidth: widget.listWidth,
      listPadding: const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
      itemDivider: Divider(
        thickness: 2,
        height: 2,
        color: greyBorder,
      ),
      itemDecorationWhileDragging: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      listInnerDecoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _contents[oldListIndex].children.removeAt(oldItemIndex);
      _contents[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _contents.removeAt(oldListIndex);
      _contents.insert(newListIndex, movedList);
    });
  }
}
