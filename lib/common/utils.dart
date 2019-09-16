import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//展示一个圆形头像：=================================
Widget circleAvatar(
  String url, {
  double width = 30,
  double height,
  BoxFit fit,
  BorderRadius borderRadius,
}) {
  var placeholder = Image.asset(
    "imgs/avatar-default.png", //头像默认值
    width: width,
    height: height,
  );
  //裁剪  图片并  返回
  return ClipRRect(
    borderRadius: borderRadius ?? BorderRadius.circular(2),
    child: CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => placeholder,
      errorWidget: (context, url, error) => placeholder,
    ),
  );
}
