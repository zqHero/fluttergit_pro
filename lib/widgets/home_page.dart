// 创建  主界面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergit_pro/common/exports_commones.dart';
import 'package:fluttergit_pro/models/allentities_exports.dart';
import 'package:fluttergit_pro/states/allstates_exports.dart';
import 'package:fluttergit_pro/widgets/routes.dart';
import 'package:provider/provider.dart';

import 'package:flukit/flukit.dart';

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
                buildDrawerHeader(),
                Expanded(child: buildDrawerMenus()),
              ],
            )),
      ), //抽屉菜单
    );
  }

  /**
   * 创建一个 主界面 组件
   */
  Widget createBodyWidget() {
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      //未登录  显示一个登录  按钮
      return Center(
        child: RaisedButton(
          child: Text("去登录"),
          onPressed: () => {Navigator.of(context).pushNamed("login")},
        ),
      );
    } else {
      return InfiniteListView<Repo>(
        onRetrieveData: (int page, List<Repo> items, bool refresh) async {
          //刷新数据
          var data =
              await Git(context).getRepos(refresh: refresh, queryParameters: {
            'page': page,
            'page_size': 10,
          });
          //添加 请求到的数据 添加到items 中
          items.addAll(data);
          return data.length > 0 && data.length % 10 == 0;
        },
        itemBuilder: (List list, int index, BuildContext ctx) {
          return RepoItem(list[index]);
        },
      );
    }
  }

  /**
   * 抽屉菜单的  头部============================================
   */
  Widget buildDrawerHeader() {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel value, Widget child) {
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 60, bottom: 23),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16, bottom: 16, right: 16),
                      child: ClipOval(
                        // 如果已登录，则显示用户头像；若未登录，则显示默认头像
                        child: value.isLogin
                            ? circleAvatar(value.user.avatar_url, width: 80)
                            : Image.asset(
                                "imgs/avatar-default.png",
                                width: 80,
                              ),
                      ),
                    ),
                    Text(
                      value.isLogin ? value.user.login : "登录",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Text(
                  value.isLogin ? value.user.bio : "",
                  softWrap: false,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            if (!value.isLogin) Navigator.of(context).pushNamed("login");
            if (value.isLogin && value.user.avatar_url != null) {
              // TODO 执行一个  查看个人信息的 界面
              print("================");
            }
          },
        );
      },
    );
  }

  /**
   * 创建菜单项
   */
  Widget buildDrawerMenus() {
    return Consumer<UserModel>(
        builder: (BuildContext context, UserModel userModel, Widget child) {
//          var gm = GmLocalizations.of(context);
      return ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: Text("选择主题"),
            onTap: () => Navigator.pushNamed(context, "themes"),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text("选择语言"),
            onTap: () => Navigator.pushNamed(context, "themes"),
          ),
          ListTile(
              leading: const Icon(Icons.language),
              title: Text(userModel.isLogin ? "退出登录" : "去登录"),
              onTap: () => userModel.isLogin
                  ? loginOut(userModel)
                  : Navigator.pushNamed(context, "login"))
        ],
      );
    });
  }

  //退出登录
  loginOut(UserModel userModel) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: Text("确认退出"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text("确认"),
                onPressed: () {
                  //该赋值语句会触发MaterialApp rebuild
                  userModel.user = null;
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
