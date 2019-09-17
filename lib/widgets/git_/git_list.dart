import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergit_pro/common/exports_commones.dart';
import 'package:fluttergit_pro/models/allentities_exports.dart';
import 'package:fluttergit_pro/states/allstates_exports.dart';
import 'package:provider/provider.dart';
import '../routes.dart';


class GitProListPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new GitListState();
  }
}

class GitListState extends State<GitProListPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return createBodyWidget();
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
}