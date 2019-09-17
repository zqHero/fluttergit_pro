//演示   Bloc 模式
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttergit_pro/states/allstates_exports.dart';
import 'package:fluttergit_pro/widgets/bloc_/bloc_mode_page.dart';
import 'package:fluttergit_pro/widgets/bloc_/provider/bloc_model_provider.dart';
import 'package:provider/provider.dart';

import 'view_model/bloc_view_model.dart';

class BlocPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_BlocPageState();
}

//==========================================================================================
class _BlocPageState extends State<BlocPage> {
  String response = "";

  //请求数据------
  void requestData() async {
    UserModel userModel = Provider.of<UserModel>(context);
    var r;
    var userName = "zqHero";

    if (userModel.isLogin) {
      userName = userModel.user.login;
    }
    try {
      r = await new Dio().get(
        "https://api.github.com/users/$userName",
        options: Options().merge(extra: {
          "noCache": true, //本接口禁用缓存
        }),
      );
      response = r.toString();
    } catch (e) {
      response = e.toString();
    } finally {
      setState(() {
        response = response;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child:
      //use the  bloc model 使用bloc模式
      BlocModelProvider(
         viewModel:BlocViewModel(),//指定 viewModel
         child:BlocModePage(),//直接  界面
      ),

//        暂时不适用 bloc 模式
//          getWidget(),
    );
  }

  //  //NO Provider  no user the  bloc mode  暂时不适用 bloc 模式
  Widget getWidget() {
    return new Column(
      children: <Widget>[
        RaisedButton(
          child: new Text("点击获取Git个人信息"),
          onPressed: () {
            setState(() {
              response = "加载中...";
            });
            requestData();
          },
          color: Colors.blue,
        ),
        Text("$response"),
      ],
    );
  }
}
