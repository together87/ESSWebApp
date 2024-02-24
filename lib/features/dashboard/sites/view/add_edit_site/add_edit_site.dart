import '/common_libraries.dart';
import 'widget/widget.dart';

class AddEditSiteView extends StatelessWidget {
  final String? siteId;
  const AddEditSiteView({
    super.key,
    this.siteId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEditSiteBloc(context),
      child: SiteAddEditWidget(
        siteId: siteId,
      ),
    );
  }
}

class SiteAddEditWidget extends StatefulWidget {
  const SiteAddEditWidget({super.key, this.siteId});
  final String? siteId;
  @override
  State<StatefulWidget> createState() => _SiteAddEditWidgetState();
}

class _SiteAddEditWidgetState extends State<SiteAddEditWidget> {
  late AddEditSiteBloc addEditSiteBloc;
  final validationKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();

  bool isSwitchedUpdate = false;

  static String pageLabel = '';
  static String cancelPath = 'sites';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageLabel = widget.siteId != null
        ? AppStrings.subTitleUpdateSites
        : AppStrings.subTitleCreateSites;
    addEditSiteBloc = context.read()
      ..add(AddEditSiteRegionsListLoadingEvent())
      ..add(AddEditSiteJSAMethodListLoadingEvent());

    if (widget.siteId != null) {
      addEditSiteBloc.add(AddEditSiteLoaded(siteId: widget.siteId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddEditSiteBloc, AddEditSiteState>(
      builder: (context, state) {
        if (state.detailsLoaded == EntityStatus.loading) {
          return const Loader();
        }
        return AddEditEntityTemplate(
            label: pageLabel,
            id: widget.siteId,
            iconData: FontAwesomeIcons.bacon,
            cancelPath: cancelPath,
            crudStatus: state.status,
            addEntity: () {
              validationKey.currentState!.validate();
              context.read<AddEditSiteBloc>().add(CreateSitesEvent());
            },
            editEntity: () {
              validationKey.currentState!.validate();
              context.read<AddEditSiteBloc>().add(UpdateSitesEvent(
                  siteId: int.parse(widget.siteId.toString())));
            },
            screenName: widget.siteId != null ? "Edit Site" : "Add Site",
            screenNameOne: 'Site / ',
            screenNameTwo: widget.siteId != null ? "Edit Site" : "Add Site",
            child: Form(
              key: validationKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormItemVertical(
                    leftLabel: AppStrings.siteNameTitle,
                    leftChild: const SiteNameField(),
                    leftValidationMessage: state.siteNameValidationMessage,
                    rightLabel: AppStrings.siteCodeTitle,
                    rightChild: const SiteCodeField(),
                    rightValidationMessage: state.siteCodeValidationMessage,
                  ),
                  FormItemVertical(
                    leftLabel: AppStrings.regionTitle,
                    leftChild: RegionSelect(
                      scrollController: scrollController,
                    ),
                    leftValidationMessage: state.regionValidationMessage,
                    rightLabel: AppStrings.timezoneTitle,
                    rightChild: const TimezoneSelect(),
                    rightValidationMessage: state.timezoneValidationMessage,
                  ),
                  FormItemVertical(
                    leftLabel: AppStrings.jsaMethodTitle,
                    leftChild: const JSAMethodSelect(),
                    leftValidationMessage: state.jsaMethodValidationMessage,
                    rightLabel: AppStrings.referenceTitle,
                    rightChild: const SiteReferenceField(),
                    subRightChild: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: CustomSwitch(
                          switchValue: state.jsaArchiveReviewStatus,
                          onChanged: (value) {
                            context.read<AddEditSiteBloc>().add(
                                AddEditSiteJSAReviewRequiredStatusStatusChanged(
                                    jsaArchiveReviewStatus: value));
                          },
                          label: "JSA Achieve Review",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
      listener: (context, state) {
        if (state.status.isSuccess) {
          CustomNotification(
            context: context,
            notifyType: NotifyType.success,
            title: state.title,
            content: state.message,
          ).showNotification();
          context.go('/sites');
        }
        if (state.status.isFailure) {
          CustomNotification(
            context: context,
            title: state.title,
            notifyType: NotifyType.error,
            content: state.message,
          ).showNotification();
        }
      },
      listenWhen: (previous, current) => previous.status != current.status,
    );
  }
}
