import 'di_ex.dart';

GetIt di = GetIt.instance;

Future<void> setupDi() async {
  // Network service
  di.registerSingleton<Dio>(Dio());

  // Helper
  di.registerSingleton(InternetConnectionHelper());

  // Hive Database
  await Hive.initFlutter();

  // DB Services
  // Home Databse Service
  di.registerSingleton<HomeDbService>(HomeDbService());
  await di<HomeDbService>().initDataBase();

  // DB Provider
  di.registerSingleton(HomeDbProvider(homeDbService: di<HomeDbService>()));

  // Api provider
  // Home Provider
  di.registerSingleton(HomeApiProvider(di<Dio>()));

  // Repository
  // Home repository
  di.registerSingleton(HomeRepository(
    apiProvider: di<HomeApiProvider>(),
    dbProvider: di<HomeDbProvider>(),
  ));

  // Bloc
  // Home bloc

  di.registerSingleton<HomeBloc>(HomeBloc(di<HomeRepository>()));
}
