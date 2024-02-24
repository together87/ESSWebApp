import '/common_libraries.dart';

class FormItemVertical extends StatelessWidget {
  final Widget leftChild;
  final Widget? rightChild;
  final Widget? subRightChild;
  final String leftLabel;
  final String? rightLabel;
  final String leftValidationMessage;
  final String? rightValidationMessage;
  const FormItemVertical({
    super.key,
    required this.leftChild,
    required this.leftLabel,
    this.rightChild,
    this.subRightChild,
    this.rightLabel,
    this.leftValidationMessage = '',
    this.rightValidationMessage = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: insetx16y5,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      leftLabel,
                      style: textNormal14.copyWith(fontFamily: 'Montserrat'),
                    ),
                    spacery2,
                    Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: leftChild,
                    ),
                  ],
                ),
              ),
              if (rightChild != null)
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (rightLabel != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text(
                            "$rightLabel",
                            style: textNormal14.copyWith(fontFamily: 'Montserrat'),
                          ),
                        ),
                      spacery2,
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: rightChild!,
                      ),
                    ],
                  ),
                ),
              subRightChild ?? Container()
            ],
          ),
          spacery3,
          Row(
            children: [
              Expanded(
                child: Text(
                  leftValidationMessage,
                  style: textNormal12.copyWith(
                    color: Colors.red,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              spacerx50,
              Expanded(
                child: Row(
                  children: [
                    if (rightValidationMessage != null)
                      Expanded(
                        flex: 3,
                        child: Text(
                          rightValidationMessage!,
                          style: textNormal12.copyWith(
                            color: Colors.red,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
