
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergit_pro/states/profile_change_notifier.dart';
import 'package:provider/provider.dart';
import '../common/global.dart';

//切换 主题的界面
class ThemeRoute extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("选择主题"),
      ),
      body: ListView(
        children: Global.themes.map((e){
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical:5,horizontal: 6),
              child: Container(
                color: e,
                height: 40,
              ),
            ),
            onTap: (){
              //主题更新后，MaterialApp会重新build
              Provider.of<ThemeModel>(context).theme = e;
            },
          );
        }).toList(),
      ),
    );
  }
}