import 'package:flutter/cupertino.dart';
import 'package:fluttergit_pro/states/profile_change_notifier.dart';
import 'package:provider/provider.dart';

///所有viewModel的父类，提供一些公共功能
abstract class BaseViewModel {
  bool _isFirst = true;

  bool get isFirst => _isFirst;



  // 避免被初始化 多次
  @mustCallSuper
  void init(BuildContext context) {
    if(_isFirst){
       _isFirst = false;
       doInit(context);
     }
  }

  //初始化
  @protected
  void doInit(BuildContext context);

  //获取数据
  @protected
  Future refreshData(BuildContext context);

  //销毁 用于清空数据  避免内存泄漏
  void disPose();
}
