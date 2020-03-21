import 'package:dio/dio.dart';

// 或者通过传递一个 `options`来创建dio实例
BaseOptions options = BaseOptions(
    baseUrl: "http://47.94.254.236:55",
    connectTimeout: 5000,
    receiveTimeout: 3000,
);
Dio dio = Dio(options);

Future<Response> getHttp() async {
  Response response =
      await dio.get("/hackapi.php?router=index");
  return response;
}

Future<Response> getCatagory(String type,int page) async {
  print("type:$type,page:$page");
  Response response =
      await dio.get("/hackapi.php?router=$type&page=$page");
  return response;
}

