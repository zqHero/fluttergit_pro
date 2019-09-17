// 创建  主界面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergit_pro/common/exports_commones.dart';
import 'package:fluttergit_pro/states/allstates_exports.dart';
import 'package:fluttergit_pro/widgets/bloc_/bloc_page.dart';
import 'package:provider/provider.dart';
import 'git_/git_list.dart';

// ignore: slash_for_doc_comments
/**
 * 主界面
 */
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomePageState();
}

List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
  new BottomNavigationBarItem(title: new Text("Git"), icon: Icon(Icons.home)),
  new BottomNavigationBarItem(title: new Text("Bloc"), icon: Icon(Icons.lock)),
  new BottomNavigationBarItem(title: new Text("Git"), icon: Icon(Icons.info)),
];

class HomePageState extends State<HomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Git"),
      ),
      body: getCurrentBodyView(),
//      createBodyWidget(), //构建主界面
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        items: items,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
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

  //获取  当前  bodyView
  Widget getCurrentBodyView() {
    switch (_index) {
      case 0:
        return new GitProListPage();
      case 1:
        return new BlocPage();
      case 2:
        return new Center();
    }
  }
}
