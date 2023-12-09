import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hebi/presentation/blocs/settings/settings.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import './/core/core.dart';
import './/data/cache/cache.dart';
import './/data/http/http.dart';
import './/data/repositories/repositories.dart';
import './/data/usecases/usecases.dart';
import './/domain/repositories/repositories.dart';
import './/domain/usecases/usecases.dart';
import './/infra/cache/cache.dart';
import './/infra/http/http.dart';
import './/presentation/blocs/auth/auth.dart';
import './/presentation/blocs/jb/jb.dart';
import './/presentation/blocs/login/login.dart';
import './/validation/validation.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<LocalStorage>(create: (_) => LocalStorage('hebi')),
      Provider<ICacheStorage>(
        create: (context) => LocalStorageAdapter(localStorage: context.read()),
      ),
      ChangeNotifierProvider<ThemeController>(
        create: (context) => ThemeController(storage: context.read()),
      ),
      Provider<IHttpClient>(
        create: (context) => HttpAdapter(
          storage: context.read(),
          client: Client(),
        ),
      ),
      Provider<DeviceInfo>(create: (_) => DeviceInfo()),
      Provider<IAuthRepository>(
        create: (context) => AuthRepository(
          cacheStorage: context.read(),
          httpClient: context.read(),
        ),
      ),
      Provider<IShiftsRepository>(
        create: (context) => ShiftsRepository(
          cacheStorage: context.read(),
          httpClient: context.read(),
        ),
      ),
      Provider<IAuthentication>(
        create: (context) => RemoteAuthentication(
          authRepository: context.read(),
        ),
      ),
      Provider<ICreateJb>(
        create: (context) => RemoteCreateJb(shiftsRepository: context.read()),
      ),
      BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          authentication: context.read(),
          storage: context.read<ICacheStorage>(),
          validation: ValidationComposite([
            ...ValidationBuilder.field('user').required().onlyNumber().build(),
            ...ValidationBuilder.field('password')
                .required()
                .onlyNumber()
                .build(),
          ]),
        ),
      ),
      BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(
          repository: context.read(),
          storage: context.read(),
        ),
      ),
      BlocProvider<JBBloc>(
        create: (context) => JBBloc(useCase: context.read()),
      ),
      BlocProvider<SettingsBloc>(create: (context) => SettingsBloc()),
    ],
    child: const HebiApp(),
  ));
}

class HebiApp extends StatelessWidget {
  const HebiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ThemeController>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      title: 'HebiApp',
      theme: controller.value.theme,
      themeMode: controller.value.themeMode,
      initialRoute: Routers.initialRoute,
      onGenerateRoute: Routers.generateRoutes,
    );
  }
}
