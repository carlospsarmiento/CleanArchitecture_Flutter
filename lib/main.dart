import 'package:app_flutter/core/di/di.dart';
import 'package:app_flutter/shared/presentation/bloc/auth_cubit.dart';
import 'package:app_flutter/features/auth/presentation/screens/login_screen.dart';
import 'package:app_flutter/features/auth/presentation/screens/splash_page.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/catalog_list_screen.dart';
import 'package:app_flutter/shared/presentation/theme/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_preview/device_preview.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDi();
  //runApp(const MyApp());
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => di<AuthCubit>())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme(context),
        //home: LoginScreen()
        initialRoute: "auth/splash",
        routes: {
          "auth/splash": (BuildContext context) => SplashPage(),
          "auth/login": (BuildContext context) => LoginScreen(),
          "ecommerce/catalog/list": (BuildContext context) => CatalogListScreen(),
        },

        /*
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.light
          ),
          useMaterial3: true,
          brightness: Brightness.light
        ),
        */
        //darkTheme: AppTheme.darkTheme,
        //themeMode: ThemeMode.system,
      ),
    );
  }
}