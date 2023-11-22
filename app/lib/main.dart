import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hebi/validation/validation.dart';
import 'package:http/http.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:http_interceptor/http_interceptor.dart';

import './/core/core.dart';
import './/data/cache/cache.dart';
import './/data/http/http.dart';
import './/data/repositories/repositories.dart';
import './/data/usecases/usecases.dart';
import './/domain/repositories/repositories.dart';
import './/domain/usecases/usecases.dart';
import './/infra/cache/cache.dart';
import './/infra/http/http.dart';
import './/presentation/blocs/blocs.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<LocalStorage>(create: (_) => LocalStorage('hebi')),
      Provider<ICacheStorage>(
        create: (context) => LocalStorageAdapter(localStorage: context.read()),
      ),
      Provider<IHttpClient>(
        create: (context) => InterceptedHttpAdapter(
          storage: context.read(),
          client: InterceptedClient.build(
            interceptors: [RedirectOn401Interceptor(context.read())],
          ),
        ),
      ),
      Provider<DeviceInfo>(create: (_) => DeviceInfo()),
      Provider<IAuthRepository>(
        create: (context) => AuthRepositoryData(
          cacheStorage: context.read(),
          httpClient: HttpAdapter(client: Client(), storage: context.read()),
          httpClientWithInterceptor: context.read(),
        ),
      ),
      Provider<Authentication>(
        create: (context) => RemoteAuthentication(
          loginRepository: context.read(),
        ),
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
    ],
    child: const HebiApp(),
  ));
}

class HebiApp extends StatelessWidget {
  const HebiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationService.navigatorKey,
      title: 'HebiApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routers.initialRoute,
      onGenerateRoute: Routers.generateRoutes,
    );
  }
}
