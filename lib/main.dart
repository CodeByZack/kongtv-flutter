import 'package:flutter/material.dart';
import 'homeLayout.dart';
import 'pages/moveDetail.dart';
import 'pages/playMovie.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(new MyApp());
}


//  onGenerateRoute = (RouteSettings settings) {
//   print("onGenerateRoute");
//   final String name = settings.name;
//   final Function pageContentBuilder = routers[name];
//   if (pageContentBuilder != null) {
//     final Route route = MaterialPageRoute(
//       builder: (context) {
//         //将RouteSettings中的arguments参数取出来，通过构造函数传入
//         return pageContentBuilder(context, arguments: settings.arguments);
//       },
//       settings: settings,
//     );
//     return route;
//   }
// };

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "风影院",
      theme: new ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        print('build route for ${settings.name}');
        var routes = <String, WidgetBuilder>{
          "/": (ctx) => MyHomePage(),
          "/moviedetail": (ctx) => MovieDetail(),
          "/playmovie": (ctx) => PlayMovie(settings.arguments),
        };
        WidgetBuilder builder = routes[settings.name];
        return MaterialPageRoute(
            builder: (ctx) => builder(ctx), settings: settings);
      },
      // home: new MyHomePage(title: "home"),
      // routes: routers
    );
  }
}
