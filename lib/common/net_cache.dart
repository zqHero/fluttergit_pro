import 'dart:collection';
import 'package:dio/dio.dart';

import 'exports_commones.dart';

class CacheObject {
  Response response;
  int timeStamp;

  CacheObject(this.response)
      : timeStamp = DateTime.now().millisecondsSinceEpoch;

  @override
  bool operator ==(other) {
    // TODO: implement ==
    return response.hashCode == other.hashCode;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => response.realUri.hashCode;
}

//缓存 类
class NetCache extends Interceptor {
  //为 确保迭代器   顺序和对象插入时间一致  顺序一致  使用LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  onRequest(RequestOptions options) {
    if (!Global.profile.cache.enable) return options;
    bool refresh = options.extra["refresh"] == true;

    //refresh 标记是否是下拉刷新
    if (refresh) {
      if (options.extra["list"] == true) {
        //若是列表 则只要url 中包含当前 path 的缓存全部删除
        cache.removeWhere((key, v) => key.contains(options.path));
      } else {
        //如果不是列表  则只删除uri相同的缓存
        delete(options.uri.toString());
      }
      return options;
    }

    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      var ob = cache[key];
      if (ob != null) {
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            Global.profile.cache.maxAge) {
          return cache[key].response;
        } else {
          cache.remove(key);
        }
      }
    }
  }

  void delete(String key) {
    cache.remove(key);
  }
}
