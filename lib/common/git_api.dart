import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttergit_pro/models/allentities_exports.dart';

import 'global.dart';

class Git {
  BuildContext context;
  Options options;

  //在 网络请求过程中  可能会需要当前的context 信息 比如在请求失败时
  //打开一个新路由  而打开  新路由需要context 信息
  Git([this.context]) {
    options = Options(extra: {"context": context});
  }

  static Dio dio = new Dio(BaseOptions(
    baseUrl: "https://api.github.com/",
    headers: {
      HttpHeaders.acceptHeader: "application/vnd.github.squirrel-girl-preview,"
          "application/vhd.github.symmetra-preview+json"
    },
  ));

  static void init() {
    //添加  缓存插件
    dio.interceptors.add(Global.netCache);
    //设置 用户token  可能为 null 代表未登录
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;

    //在  调试模式下  需要抓包 进行调试   并禁用代理HTTPS证书校验
    if (!Global.isRelease) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (uri) {
          return "PROXY 10.1.10.250:8888";
        };
        //代理  工具会自动提供一个抓包的 自签名证书  会通不过证书校验  所以我们禁用证书校验
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  //登录 接口   登录成功后返回  用户信息：
  Future<User> login(String login,String pwd) {
//      String basic =
  }
}
