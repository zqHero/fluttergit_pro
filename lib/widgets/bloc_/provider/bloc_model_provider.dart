import 'package:flutter/cupertino.dart';
import 'package:fluttergit_pro/widgets/bloc_/view_model/base_view_model.dart';

//绑定   view 和 Page
class BlocModelProvider<T extends BaseViewModel> extends StatefulWidget {
  final T viewModel;
  final Widget child;

  //构造器
  const BlocModelProvider({Key key, this.viewModel, this.child})
      : super(key: key);

  //当前 viewmodel 类型
  static Type _typeOf<T>() => T;

  //获取  当前viewModel:
  static T of<T extends BaseViewModel>(BuildContext context) {
    final type = _typeOf<BlocModelProvider<T>>();
    BlocModelProvider<T> provider = context.ancestorWidgetOfExactType(type);
    return provider.viewModel;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BlocModelProviderState(); //管理  状态
  }
}



class BlocModelProviderState extends State<BlocModelProvider> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return widget.child; //返回当前  指定的 child 组件
  }


  @override
  void dispose() {
    // TODO: implement dispose
    widget.viewModel.disPose();
    super.dispose();
  }
}
