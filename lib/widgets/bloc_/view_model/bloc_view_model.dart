import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttergit_pro/states/allstates_exports.dart';
import 'package:fluttergit_pro/widgets/bloc_/view_model/base_view_model.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

//model 类  需要继承自  baseModel
class BlocViewModel extends BaseViewModel {
  //数据观察者
  BehaviorSubject<String> _dataObservable = BehaviorSubject();

  Stream<String> get dataStream => _dataObservable.stream; //将流返回

  @override
  void disPose() {
    // TODO: implement disPose
    _dataObservable.close();
  }

  @override
  void doInit(BuildContext context) {
    // TODO: implement doInit   初始化  请求一次数据
    refreshData(context);
  }

  //获取数据
  @override
  Future refreshData(BuildContext context) async {
//    UserModel  userModel = Provider.of<UserModel>(context);
//    var userName = "zqHero";
//    if (userModel.isLogin) {
//      userName = userModel.user.login;
//    }
    var response;
    try {
      response = await new Dio().get(
        "https://api.github.com/users/zqHero",
        options: Options().merge(extra: {
          "noCache": true, //本接口禁用缓存
        }),
      );
      _dataObservable.add(response.toString());
//      response = response.toString();
    } catch (e) {
      _dataObservable.addError(e);
//      response = e.toString();
    }
    return response;
  }
}
