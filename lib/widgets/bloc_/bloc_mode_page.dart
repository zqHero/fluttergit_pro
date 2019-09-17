import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttergit_pro/widgets/bloc_/provider/bloc_model_provider.dart';
import 'package:fluttergit_pro/widgets/bloc_/view_model/bloc_view_model.dart';

class BlocModePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BlocModePageState();
}

class _BlocModePageState extends State<BlocModePage> {
  //获取  model
  BlocViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    //获取 当前ViewModel
    _viewModel = BlocModelProvider.of(context);
    _viewModel.init(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
        child: new Column(
      children: <Widget>[
        new RaisedButton(
          onPressed: () {
            //刷新数据
            _viewModel.refreshData(context).toString();
          },
          child: new Text("点击获取数据"),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: StreamBuilder(
              stream: _viewModel.dataStream,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Text(
                  "${snapshot.hasError ? snapshot.error : snapshot.data}",
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}
