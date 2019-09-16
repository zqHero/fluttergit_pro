import 'package:flutter/material.dart';
import 'package:fluttergit_pro/common/exports_commones.dart';
import 'package:fluttergit_pro/models/allentities_exports.dart';
import 'package:fluttergit_pro/states/allstates_exports.dart';
import 'package:provider/provider.dart';

class LoginRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State<LoginRoute> {
  @override
  Widget build(BuildContext context) {
//    var gm = GmLocalizations.of(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("登录")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          autovalidate: true,
          child: Column(
            children: <Widget>[
              //账号 输入框
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TextFormField(
                  autofocus: true,
//                controller: _unameController,
                  decoration: InputDecoration(
//                  labelText: "请输入账号",
                    hintText: "请输入账号",
                  ),
                  validator: (v) {
                    return v.trim().isNotEmpty ? null : "输入不准为空";
                  },
                ),
              ),
              //密码 输入框
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  autofocus: false,
//                controller: _unameController,
                  decoration: InputDecoration(
//                  labelText: "请输入账号",
                    hintText: "请输入密码",
                  ),
                  validator: (v) {
                    return v.trim().isNotEmpty ? null : "输入不准为空";
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 50, width: 200),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: onClickLogin,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    highlightColor: Colors.green,
                    elevation: 10,
                    textColor: Colors.white,
                    child: Text("去登录"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //去登录
  void onClickLogin() async {
    //验证  输入内容是否合法;
    showLoading(context);
    User user;

    try {
      user = await Git(context).login("zqHero", "zq229457269");
      // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
      Provider.of<UserModel>(context, listen: false).user = user;
    } catch (e) {
//      showToast(e.toString());
    } finally {
      Navigator.of(context).pop(); //隐藏loading
    }
    if(user!=null){
      // 返回
      Navigator.of(context).pop();
    }
    print("==================${user.toJson()}");
  }

//  void showToast(String text, {
//    gravity: ToastGravity.CENTER,
//    toastLength: Toast.LENGTH_SHORT,
//  }) {
//    Fluttertoast.showToast(
//      msg: text,
//      toastLength: Toast.LENGTH_SHORT,
//      gravity: ToastGravity.BOTTOM,
//      timeInSecForIos: 1,
//      backgroundColor: Colors.grey[600],
//      fontSize: 16.0,
//    );
//  }

  /**
   * 展示一个  loading
   */
  void showLoading(BuildContext context, [String text]) {
    text = text ?? "加载中...";
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            constraints: BoxConstraints(minHeight: 120, minWidth: 180),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(3.0),
                boxShadow: [
                  //阴影
                  BoxShadow(
                    color: Colors.black12,
                    //offset: Offset(2.0,2.0),
                    blurRadius: 10.0,
                  )
                ]),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.body2,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
