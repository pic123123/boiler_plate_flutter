import 'package:boiler_plate_flutter/common/constants/sizes.dart';
import 'package:boiler_plate_flutter/firebase_options.dart';
import 'package:boiler_plate_flutter/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  runApp(
    //RiverPod Setting
    const ProviderScope(
      child: FlutterBolilerPlateApp(),
    ),
  );
}

class FlutterBolilerPlateApp extends ConsumerWidget {
  const FlutterBolilerPlateApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: 'Flutter Boiler Plate',

      ///localizationsDelegates 리스트에는 앱에서 사용할 각종 로컬라이제이션 데이터를 제공하는 델리게이트가 포함되어 있습니다.
      localizationsDelegates: const [
        ///Flutter 위젯의 기본 텍스트 방향(왼쪽에서 오른쪽 또는 오른쪽에서 왼쪽)과 같은 기본적인 지역화 데이터를 제공합니다.
        GlobalWidgetsLocalizations.delegate,

        ///Cupertino 및 Material 디자인 위젯의 지역화된 문자열과 다른 값들을 제공합니다.
        GlobalCupertinoLocalizations.delegate,

        ///Cupertino 및 Material 디자인 위젯의 지역화된 문자열과 다른 값들을 제공합니다.
        GlobalMaterialLocalizations.delegate,
      ],

      ///앱이 지원하는 언어의 목록
      supportedLocales: const [
        Locale('en'), //basic locale
        Locale('ko'),
      ],
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: false,
        textTheme: Typography.blackMountainView,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        splashColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey.shade500,
          indicatorColor: Colors.black,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: false,
        tabBarTheme: TabBarTheme(
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade700,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        textTheme: Typography.whiteMountainView,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          surfaceTintColor: Colors.grey.shade900,
          backgroundColor: Colors.grey.shade900,
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.grey.shade100,
          ),
          iconTheme: IconThemeData(
            color: Colors.grey.shade100,
          ),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900,
        ),
        primaryColor: const Color(0xFFE9435A),
      ),
    );
  }
}
