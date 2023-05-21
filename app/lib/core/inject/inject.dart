import 'package:app/core/services/enviroments.dart';
import 'package:app/layers/data/datasource/local/login_datasource_local_imp.dart';
import 'package:app/layers/data/datasource/login_datasource.dart';
import 'package:app/layers/data/datasource/remote/login_datasource_remote_imp.dart';
import 'package:app/layers/data/repositories/login_repository_imp.dart';
import 'package:app/layers/domain/repositories/login_repository.dart';
import 'package:app/layers/presentation/containers/login_container.dart';
import 'package:app/layers/presentation/controllers/login_controller.dart';
import 'package:app/layers/presentation/router/login_router.dart';
import 'package:get_it/get_it.dart';

class Inject {
  static init() {
    const enviroment = String.fromEnvironment('mode', defaultValue: 'dev');
    GetIt getIt = GetIt.instance;

    //datasource
    getIt.registerLazySingleton<ILoginDatasource>(() {
      if (Enviroments.development.mode == enviroment) {
        return LoginDatasourceLocalImp(Enviroments.development.url);
      } else if (Enviroments.production.mode == enviroment) {
        return LoginDatasourceRemoteImp(Enviroments.production.url);
      }
      throw 'FALHA AO IDENTIFICAR AMBIENT';
    });

    //repositories
    getIt.registerLazySingleton<ILoginRepository>(
        () => LoginRepositoryImp(getIt()));

    //usecases

    //controllers
    getIt.registerLazySingleton<ILoginController>(
        () => LoginController(getIt()));

    //containers
    getIt.registerLazySingleton<LoginContainer>(
        () => LoginContainer(controller: getIt()));

    getIt.registerLazySingleton<LoginRouter>(
        () => LoginRouter(repository: getIt()));
  }

  static T get<T extends Object>() {
    GetIt getIt = GetIt.instance;

    return getIt.get<T>();
  }
}
