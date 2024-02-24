import '/common_libraries.dart';
import 'widget/widget.dart';

class EntityListTemplate extends StatefulWidget {
  final List<Entity> entities;
  final String emptyMessage;
  final String label;
  final String path;
  final String screenName;
  final String screenNameOne;
  final String screenNameTwo;
  final IconData iconData;
  final EntityStatus crudStatus;
  final TextEditingController textEditingController;
  final VoidCallback? onSuffixClicked;
  final ValueChanged<Entity>? onRowClick;
  final ValueChanged<Entity>? onEditClick;
  final ValueChanged<String>? onDeleteClick;
  final int totalRows;
  const EntityListTemplate({
    super.key,
    this.entities = const [],
    required this.emptyMessage,
    required this.label,
    required this.iconData,
    required this.path,
    required this.screenName,
    required this.screenNameOne,
    required this.screenNameTwo,
    required this.textEditingController,
    this.crudStatus = EntityStatus.initial,
    this.onSuffixClicked,
    this.onRowClick,
    this.onEditClick,
    this.onDeleteClick,
    this.totalRows = 0,
  });

  @override
  State<EntityListTemplate> createState() => _CrudState();
}

class _CrudState extends State<EntityListTemplate> {
  final _dataTableHorizontalScrollController = ScrollController();
  late String selectedId;
  String token = '';

  Map<String, double> columnWidths = {};
  List<String> columns = [];

  @override
  void initState() {
    columns = widget.entities.isNotEmpty
        ? (widget.entities[0].columns.isNotEmpty ? widget.entities[0].columns : widget.entities[0].tableItemsToMap().keys.toList())
        : [];

    for (final column in columns) {
      columnWidths.addEntries([MapEntry(column, double.nan)]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) => setState(() => token = state.authUser?.token ?? ''),
      listenWhen: (previous, current) => previous.authUser?.token != current.authUser?.token,
      builder: (context, state) {
        token = state.authUser?.token ?? '';
        return Padding(
          padding: inset16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenTitle(
                  backClick: () {},
                  addButtonShow: true,
                  iconData: widget.iconData,
                  screenName: widget.screenName,
                  screenNameOne: widget.screenNameOne,
                  screenNameTwo: widget.screenNameTwo),
              spacery5,
              Expanded(
                child: Card(
                  elevation: 3,
                  child: widget.crudStatus.isLoading
                      ? const Center(
                          child: Loader(),
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 12,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.screenName + " List",
                                    style: themeData.textTheme.labelMedium!.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  const CustomSearchBar(
                                    width: 300,
                                    height: 40,
                                  ),
                                ],
                              ),
                            ),
                            _buildTableView(),
                            PaginationView(
                              totalRows: widget.totalRows,
                              onPaginate: (pageNum) {},
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTableView() {
    columns = widget.entities.isNotEmpty
        ? (widget.entities[0].columns.isNotEmpty ? widget.entities[0].columns : widget.entities[0].tableItemsToMap().keys.toList())
        : [];

    for (final column in columns) {
      if (!columnWidths.containsKey(column)) {
        columnWidths.addEntries([MapEntry(column, double.nan)]);
      }
    }
    final themeData = Theme.of(context);
    return Expanded(
      child: Container(
        constraints: const BoxConstraints(minHeight: 300),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        width: double.infinity,
        child: DataTableView(
          entities: widget.entities,
          columns: columns,
          emptyMessage: widget.emptyMessage,
          columnWidths: columnWidths,
          borderColor: themeData.textColor.withOpacity(0.7),
          onColumnSizedUpated: (value) {
            setState(() => columnWidths[value.key] = value.value);
          },
          onRowClick: (entity) {
            String location = GoRouter.of(context).location;
            int index = location.indexOf('/index');
            if (index != -1) {
              location = location.replaceRange(index, null, '');
            }
            selectedId = entity.id!.toString();
            GoRouter.of(context).go('$location/show/$selectedId');
          },
          onEditClick: (entity) {
            String location = GoRouter.of(context).location;
            int index = location.indexOf('/index');
            if (index != -1) {
              location = location.replaceRange(index, null, '');
            }
            selectedId = entity.id!.toString();
            GoRouter.of(context).go('$location/edit/$selectedId');
          },
          onDeleteClick: (entity) {
            setState(() {
              selectedId = entity.id!.toString();
            });
            _showAlertDialog(context, selectedId);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dataTableHorizontalScrollController.dispose();
    super.dispose();
  }

  void _showAlertDialog(BuildContext context, String selectedId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              const Icon(
                Icons.info,
                size: 100,
              ),
              const SizedBox(height: 15),
              const Text(
                'Are you sure?',
                style: TextStyle(color: AppColors.blackColor, fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 15),
              Text(
                "Do you really want to delete this ${widget.label}",
                style: const TextStyle(color: AppColors.blackColor, fontSize: 18, fontWeight: FontWeight.w500),
              )
            ],
          ),
          content: const SizedBox(width: 450, child: Text('')),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    widget.onDeleteClick!(selectedId);
                  },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: AppColors.greeenColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Yes, Delete it!',
                      style: TextStyle(color: AppColors.whiteColor, fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: AppColors.whiteColor, fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
