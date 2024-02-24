import 'common_libraries.dart';
import 'features/administration/masters/awareness_categories/view/awareness_category_list.dart';
import 'features/administration/masters/observation_types/view/observation_type_list.dart';
import 'features/administration/masters/priority_levels/view/priority_level.dart';
import 'features/administration/masters/priority_type/view/priority_type_list.dart';
import 'features/administration/masters/regions_timezones/view/regions_list.dart';
import 'features/administration/masters/severity_level/view/severity_level_list.dart';
import 'features/theme/layout.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (_, __) => '/login',
    ),
    GoRoute(
      path: '/forgot_password',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: BlocProvider(
          create: (context) => ForgotPasswordBloc(context),
          child: const ForgotPasswordView(),
        ),
      ),
    ),
    /*  GoRoute(
      path: '/reset_password',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: BlocProvider(
          create: (context) => ResetPasswordBloc(context),
          child: const ResetPasswordView(),
        ),
      ),
    ),*/
    GoRoute(
      path: '/users',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: UserListView(),
          selectedItemName: 'users',
        ),
      ),
    ),
    GoRoute(
      path: '/users/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: UserListView(),
          selectedItemName: 'users',
        ),
      ),
    ),
    GoRoute(
      path: '/users/new',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AddEditUserView(),
          selectedItemName: 'users',
        ),
      ),
    ),
    GoRoute(
      path: '/users/edit/:userId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AddEditUserView(
            userId: state.params['userId']!,
          ),
          selectedItemName: 'users',
        ),
      ),
    ),
    GoRoute(
      path: '/users/show/:userId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: UserDetailView(
            userId: state.params['userId']!,
          ),
          selectedItemName: 'users',
        ),
      ),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const LoginView(),
      ),
    ),
    GoRoute(
      path: '/dashboard',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: DashboardView(),
          selectedItemName: 'dashboard',
        ),
      ),
    ),
    GoRoute(
      path: '/dashboard/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: DashboardView(),
          selectedItemName: 'dashboard',
        ),
      ),
    ),
    GoRoute(
      path: '/analytics',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: DashboardView(),
          selectedItemName: 'analytics',
        ),
      ),
    ),
    GoRoute(
      path: '/crm',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: DashboardView(),
          selectedItemName: 'crm',
        ),
      ),
    ),
    GoRoute(
      path: '/ecommerce',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: DashboardView(),
          selectedItemName: 'ecommerce',
        ),
      ),
    ),
    GoRoute(
      path: '/crypto',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: DashboardView(),
          selectedItemName: 'crypto',
        ),
      ),
    ),
    GoRoute(
      path: '/projects/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: ProjectsListView(),
          selectedItemName: 'projects',
        ),
      ),
    ),
    GoRoute(
      path: '/projects',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: ProjectsListView(),
          selectedItemName: 'projects',
        ),
      ),
    ),
    GoRoute(
      path: '/projects/new',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AddEditProjectView(),
          selectedItemName: 'projects',
        ),
      ),
    ),
    GoRoute(
      path: '/projects/show/:projectId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: ProjectDetailsView(
            projectId: state.params['projectId']!,
          ),
          selectedItemName: 'projects',
        ),
      ),
    ),
    GoRoute(
      path: '/projects/edit/:projectId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AddEditProjectView(
            projectId: state.params['projectId']!,
          ),
          selectedItemName: 'projects',
        ),
      ),
    ),
    GoRoute(
      path: '/nft',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: DashboardView(),
          selectedItemName: 'nft',
        ),
      ),
    ),
    GoRoute(
      path: '/job',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: DashboardView(),
          selectedItemName: 'job',
        ),
      ),
    ),
    GoRoute(
      path: '/sites',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: SitesPage(),
          selectedItemName: 'sites',
        ),
      ),
    ),
    GoRoute(
      path: '/sites/new',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AddEditSiteView(),
          selectedItemName: 'sites',
        ),
      ),
    ),
    GoRoute(
      path: '/sites/edit/:siteId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AddEditSiteView(
            siteId: state.params['siteId']!,
          ),
          selectedItemName: 'siteId',
        ),
      ),
    ),
    GoRoute(
      path: '/sites/show/:siteId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: SiteDetailsView(
            siteId: state.params['siteId']!,
          ),
          selectedItemName: 'siteId',
        ),
      ),
    ),
    GoRoute(
      path: '/sites/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: SitesPage(),
          selectedItemName: 'sites',
        ),
      ),
    ),
    GoRoute(
      path: '/regions',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: RegionsListView(),
          selectedItemName: 'regions',
        ),
      ),
    ),
    GoRoute(
      path: '/regions/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: RegionsListView(),
          selectedItemName: 'regions',
        ),
      ),
    ),
    GoRoute(
      path: '/priority_types',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: PriorityTypeListView(),
          selectedItemName: 'priority_types',
        ),
      ),
    ),
    GoRoute(
      path: '/priority_types/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: PriorityTypeListView(),
          selectedItemName: 'priority_types',
        ),
      ),
    ),
    GoRoute(
      path: '/priority_levels',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: PriorityLevelPage(),
          selectedItemName: 'priority_levels',
        ),
      ),
    ),
    GoRoute(
      path: '/priority_levels/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: PriorityLevelPage(),
          selectedItemName: 'priority_levels',
        ),
      ),
    ),
    GoRoute(
      path: '/severity_levels',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: SeverityLevelListView(),
          selectedItemName: 'severity_levels',
        ),
      ),
    ),
    GoRoute(
      path: '/severity_levels/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: SeverityLevelListView(),
          selectedItemName: 'severity_levels',
        ),
      ),
    ),
    GoRoute(
      path: '/observation_types/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: ObservationTypePage(),
          selectedItemName: 'observation_types',
        ),
      ),
    ),
    GoRoute(
      path: '/observation_types',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: ObservationTypePage(),
          selectedItemName: 'observation_types',
        ),
      ),
    ),
    GoRoute(
      path: '/awareness_categories',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AwarenessCategoryPage(),
          selectedItemName: 'awareness_categories',
        ),
      ),
    ),
    GoRoute(
      path: '/awareness_categories/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AwarenessCategoryPage(),
          selectedItemName: 'awareness_categories',
        ),
      ),
    ),
    GoRoute(
      path: '/regions_timezone/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: RegionsListView(),
          selectedItemName: 'regions',
        ),
      ),
    ),
    GoRoute(
      path: '/companies/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: CompanyListView(),
          selectedItemName: 'companies',
        ),
      ),
    ),
    GoRoute(
      path: '/companies',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: CompanyListView(),
          selectedItemName: 'companies',
        ),
      ),
    ),
    GoRoute(
      path: '/companies/new',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AddEditCompanyView(),
          selectedItemName: 'companies',
        ),
      ),
    ),
    GoRoute(
      path: '/companies/show/:companyId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: CompanyDetailsView(
            companyId: state.params['companyId']!,
          ),
          selectedItemName: 'companies',
        ),
      ),
    ),
    GoRoute(
      path: '/companies/edit/:companyId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AddEditCompanyView(
            companyId: state.params['companyId']!,
          ),
          selectedItemName: 'companies',
        ),
      ),
    ),
  ],
  // errorBuilder: (context, state) => Container(
  //   child: Text('Page not found.'),
  // ),
  errorPageBuilder: (context, state) => const NoTransitionPage<void>(
    child: Center(
      child: Text('Page not found.'),
    ),
  ),
);
