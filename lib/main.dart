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
      ],
      child: Consumer2<ThemeModel, UserModel>(
        builder: (BuildContext context, themeModel, userModel, Widget child) {
          return MaterialApp(
            theme: ThemeData(platform: TargetPlatform.iOS, primarySwatch: themeModel.theme),
            onGenerateTitle: (context) {
              return "默认标题";
            },
            home: HomePage(),
            //注册路由表：
            routes: <String, WidgetBuilder>{
              "login": (context) => LoginRoute(),
              "themes": (context) => ThemeRoute(),
            },
          );
        },
      ),
    );
  }
}
