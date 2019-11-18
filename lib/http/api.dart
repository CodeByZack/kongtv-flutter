import 'package:dio/dio.dart';

Future<Response> getHttp() async {
  Response response =
      await Dio().get("http://47.94.254.236:55/hackapi.php?router=index");
  return response;
}
