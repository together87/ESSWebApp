import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'common_libraries.dart';
import 'features/administration/masters/awareness_categories/bloc/awareness_category_bloc.dart';
import 'features/administration/masters/awareness_categories/data/repository/awareness_category_repository.dart';
import 'features/administration/masters/observation_types/bloc/observation_type_bloc.dart';
import 'features/administration/masters/observation_types/data/repository/observation_type_repository.dart';
import 'features/administration/masters/priority_levels/bloc/priority_level_bloc.dart';
import 'features/administration/masters/priority_levels/data/repository/priority_level_repository.dart';
import 'features/administration/masters/priority_type/bloc/priority_type_bloc.dart';
import 'features/administration/masters/priority_type/data/repository/priority_type_repository.dart';
import 'features/administration/masters/regions_timezones/bloc/regions_timezone_bloc.dart';
import 'features/administration/masters/regions_timezones/data/repository/regions_repository.dart';
import 'features/administration/masters/regions_timezones/data/repository/timezones_repository.dart';
import 'features/administration/masters/severity_level/bloc/severity_level_bloc.dart';
import 'features/administration/masters/severity_level/data/repository/severity_level_repository.dart';
import 'features/dashboard/sites/data/repository/sites_repository.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //registerWebViewImplementation();
  await loadEnv();
  await setupHydratedLocalStorage();
  runApp(TimerServiceProvider(
    service: TimerService(),
    child: RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(authRepository: RepositoryProvider.of<AuthRepository>(context)),
        child: const EcoSysSafetyApp(),
      ),
    ),
  ));
}

class EcoSysSafetyApp extends StatefulWidget {
  const EcoSysSafetyApp({super.key});

  @override
  State<StatefulWidget> createState() => _EcoSysSafetyAppState();
}

class _EcoSysSafetyAppState extends State<EcoSysSafetyApp> {
  String token = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        token = state.authUser?.token ?? '';
        return MultiRepositoryProvider(
            key: UniqueKey(),
            providers: [
              RepositoryProvider(
                create: (context) => RegionsRepository(
                  token: token,
                  authBloc: BlocProvider.of(context),
                ),
              ),
              RepositoryProvider(
                create: (context) => TimeZonesRepository(
                  token: token,
                  authBloc: BlocProvider.of(context),
                ),
              ),
              RepositoryProvider(
                create: (context) => SeverityLevelRepository(
                  token: token,
                  authBloc: BlocProvider.of(context),
                ),
              ),
              RepositoryProvider(
                create: (context) => PriorityTypeRepository(
                  token: token,
                  authBloc: BlocProvider.of(context),
                ),
              ),
              RepositoryProvider(
                  create: (context) => PriorityLevelRepository(
                        token: token,
                        authBloc: BlocProvider.of(context),
                      )),
              RepositoryProvider(
                  create: (context) => ObservationTypeRepository(
                        token: token,
                        authBloc: BlocProvider.of(context),
                      )),
              RepositoryProvider(
                  create: (context) => AwarenessCategoryRepository(
                        token: token,
                        authBloc: BlocProvider.of(context),
                      )),
              RepositoryProvider(
                  create: (context) => SitesRepository(
                        token: token,
                        authBloc: BlocProvider.of(context),
                      )),
              RepositoryProvider(
                  create: (context) => ProjectRepository(
                        token: token,
                        authBloc: BlocProvider.of(context),
                      )),
              RepositoryProvider(
                  create: (context) => UsersRepository(
                        token: token,
                        authBloc: BlocProvider.of(context),
                      )),
              RepositoryProvider(
                  create: (context) => CompanyRepository(
                        token: token,
                        authBloc: BlocProvider.of(context),
                      )),
            ],
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => ThemeBloc()),
                BlocProvider(create: (context) => FormDirtyBloc()),
                BlocProvider(create: (context) => PaginationBloc()),
                BlocProvider(
                  create: (context) => RegionsTimezoneBloc(regionsRepository: RepositoryProvider.of(context), timeZoneRepository: RepositoryProvider.of<TimeZonesRepository>(context)),
                ),
                BlocProvider(create: (context) => SeveritylevelBloc(severityLevelRepository: RepositoryProvider.of(context))),
                BlocProvider(create: (context) => PriorityTypeBloc(priorityTypeRepository: RepositoryProvider.of(context))),
                BlocProvider(create: (context) => PriorityLevelBloc(repository: RepositoryProvider.of(context))),
                BlocProvider(create: (context) => ObservationTypeBloc(observationTypeRepository: RepositoryProvider.of(context), severityLevelRepository: RepositoryProvider.of<SeverityLevelRepository>(context))),
                BlocProvider(create: (context) => AwarenessCategoryBloc(awarenessCategoryRepository: RepositoryProvider.of(context))),
                BlocProvider(create: (context) => SitesBloc(sitesRepository: RepositoryProvider.of(context))),
              ],
              child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, stateTheme) {
                return MaterialApp.router(
                  title: 'Safety',
                  theme: AppTheme.themeData(stateTheme.isDarkThemeOn, context),
                  debugShowCheckedModeBanner: false,
                  routerConfig: router,
                  builder: FlutterSmartDialog.init(),
                  localizationsDelegates: const [
                    GlobalWidgetsLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [Locale('en', 'US')],
                );
              }),
            ));
      },
      listener: (context, state) {
        setState(() {
          token = state.authUser?.token ?? '';
        });
      },
      listenWhen: (previous, current) => previous.authUser?.token != current.authUser?.token,
    );
  }
}

setupHydratedLocalStorage() async {
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorage.webStorageDirectory,
  );
}

loadEnv() async {
  String environment = const String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'DEV',
  );

  String envFileName = '';

  switch (environment) {
    case 'DEV':
      envFileName = 'envs/env.dev';
      break;
    case 'UAT':
      envFileName = 'envs/env.uat';
      break;
    case 'PRODUCTION':
      envFileName = 'envs/env.production';
  }
  await dotenv.load(fileName: kReleaseMode ? envFileName : '../$envFileName', mergeWith: {
    'TEST_VAR': '5',
  });
}
