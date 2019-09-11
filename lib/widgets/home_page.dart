// 创建  主界面
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';
import 'package:fluttergit_pro/states/allstates_exports.dart';
import 'package:provider/provider.dart';

// ignore: slash_for_doc_comments
/**
 * 主界面
 */
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Git"),
      ),
      body: createBodyWidget(), //构建主界面
      drawer: Drawer(
        child: MediaQuery.removePadding(
            context: context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildHeader(),
                Expanded(child: buildMenus()),
              ],
            )),
      ), //抽屉菜单
    );
  }

  /**
   * 创建一个 主界面 组件
   */
  Widget createBodyWidget() {
    return Center(
      child: RaisedButton(
        child: Text("去登录"),
        onPressed: () => {
          Navigator.of(context).pushNamed("login")
        },
      ),
    );
  }

  /**
   * 抽屉菜单的  头部============================================
   */
  Widget buildHeader() {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel value, Widget child) {
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 60, bottom: 23),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipOval(
                    // 如果已登录，则显示用户头像；若未登录，则显示默认头像
                    child: Image.asset(
                      "imgs/avatar-default.png",
                      width: 80,
                    ),
                  ),
                ),
                Text(
                  "登录",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            if (!value.isLogin) Navigator.of(context).pushNamed("login");
          },
        );
      },
    );
  }

  /**
   * 创建菜单项
   */
  Widget buildMenus() {
    return Consumer<UserModel>(
        builder: (BuildContext context, UserModel userModel, Widget child) {
//          var gm = GmLocalizations.of(context);
      return ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text("选择主题"),
            onTap: () =>  Navigator.pushNamed(context, "themes"),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text("选择语言"),
            onTap: () => Navigator.pushNamed(context, "themes"),
          ),
        ],
      );
    });
  }
}
