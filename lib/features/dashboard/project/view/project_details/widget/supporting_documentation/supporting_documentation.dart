import '../widget.dart';
import '/common_libraries.dart';

class TabSupportingDocumentationView extends StatefulWidget {
  final String? projectId;
  const TabSupportingDocumentationView(this.projectId, {super.key});

  @override
  State<TabSupportingDocumentationView> createState() => _TabSupportingDocumentationViewState();
}

class _TabSupportingDocumentationViewState extends State<TabSupportingDocumentationView> {
  @override
  void initState() {
    context.read<ProjectDetailsBloc>().add(ProjectDetailsSupportingDocumentListLoaded());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    TextStyle valueStyle = textNormal12.copyWith(
      color: themeData.textColor,
      fontSize: 13,
      fontWeight: FontWeight.w400,
    );

    return BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(builder: (context, state) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                CustomBottomBorderContainer(
                  padding: insetx16y10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        'Document',
                        style: textSemiBold12.copyWith(
                          color: themeData.textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                      spacerx8,
                      Expanded(
                          flex: 2,
                          child: Text(
                            'Short Description',
                            style: textSemiBold12.copyWith(
                              color: themeData.textColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          )),
                      spacerx8,
                      Expanded(
                          child: Text(
                        'Uploaded',
                        style: textSemiBold12.copyWith(
                          color: themeData.textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                    ],
                  ),
                ),
                for (final document in state.documentList)
                  CustomBottomBorderContainer(
                    padding: insetx16y10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: MouseRegion(
                            cursor: MaterialStateMouseCursor.clickable,
                            child: Tooltip(
                              message: document.fileName,
                              child: Text(
                                document.fileName.toString(),
                                style: valueStyle.copyWith(color: primaryColor),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        spacerx8,
                        Expanded(
                          flex: 2,
                          child: Tooltip(
                            message: document.shortDescription,
                            child: Text(
                              document.shortDescription ?? '--',
                              style: valueStyle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        spacerx8,
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Tooltip(
                                  message: document.upload,
                                  child: Text(
                                    document.upload.toString(),
                                    style: valueStyle,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              MouseRegion(
                                cursor: MaterialStateMouseCursor.clickable,
                                child: GestureDetector(
                                  onTap: () {},
                                  child: const FaIcon(
                                    FontAwesomeIcons.trashCan,
                                    color: Colors.red,
                                    size: 15,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          spacerx50,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomBottomBorderContainer(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 1,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        'Upload Document',
                        style: textSemiBold12.copyWith(
                          color: themeData.textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                    ],
                  ),
                ),
                spacery10,
                const ActionItemImagePicker(),
                spacery10,
                const ShortDesField(),
                spacery10,
                Row(
                  children: [
                    CustomButton(
                      backgroundColor: successColor,
                      text: 'Upload',
                      onClick: () {
                        context.read<ProjectDetailsBloc>().add(ProjectDetailsSupportingDocumentUpload());
                      },
                      textStyle: textNormal14.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
