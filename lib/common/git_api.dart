import 'dart:convert';
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
  }

  // TODO  登录 接口   登录成功后返回  用户信息：===================================
  Future<User> login(String login, String pwd) async {
    login = "zqHero";
    pwd = "zq229457269";

    String basic = 'Basic ' + base64.encode(utf8.encode('$login:$pwd'));
    var r = await dio.get(
      "/users/$login",
      options: options.merge(headers: {
        HttpHeaders.authorizationHeader: basic
      }, extra: {
        "noCache": true, //本接口禁用缓存
      }),
    );
    //登录成功后更新公共头（authorization），此后的所有请求都会带上用户身份信息
    dio.options.headers[HttpHeaders.authorizationHeader] = basic;
    Global.netCache.cache.clear(); //清空所有缓存
    Global.profile.token = basic; //更新profile中的token信息
    return User.fromJson(r.data);
  }

  // TODO  获取用户  仓库列表 ：
  Future<List<Repo>> getRepos(
      {Map<String, dynamic> queryParameters, refresh = false}) async {
    if (refresh) {
      //列表下拉刷新   需要删除缓存
      options.extra.addAll({"refresh": true, "list": true});
    }
    var r = await dio.get<List>("user/repos",
        queryParameters: queryParameters, options: options);
    return r.data.map((e) => Repo.fromJson(e)).toList();
  }
}
