import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'common/exports_commones.dart';
import 'states/allstates_exports.dart';
import 'widgets/routes.dart';

void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
        builder: (BuildContext context, themeModel, localModel, Widget child) {
          return MaterialApp(
            theme: ThemeData(primarySwatch: Colors.blue),
            onGenerateTitle: (context) {
              return "默认标题";
            },
            home: HomePage(),
            //初始化界面
            locale: localModel.getLocale(),

            //语言适配
            supportedLocales: [
              const Locale('en', 'US'),
              const Locale('zh', 'CN')
            ],

            localizationsDelegates: [
              //本地语言国际化的  代理类
              // 本地化的代理类
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
//              GmLocalizationsDelegate()
            ],

            //注册路由表：
            routes: <String, WidgetBuilder>{
              "login": (context) => LoginRoute(),
//              "login": (context) => LoginRoute(),
//              "login":(context) => LoginRoute(),
            },
          );
        },
      ),
    );
  }
}
