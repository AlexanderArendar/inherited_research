import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class ColorProvider extends InheritedWidget {
  final Color data;

  ColorProvider({
    this.data,
    Widget child,
    Key key,
  }) : super(
          child: child,
          key: key,
        );

  static ColorProvider of(BuildContext context) => context.inheritFromWidgetOfExactType(ColorProvider);

  @override
  bool updateShouldNotify(ColorProvider oldWidget) {
    return false;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColorProvider(
      data: Colors.blue,
      child: MaterialApp(
        title: 'Inherited Research',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("What are inherited widgets?"),
      ),
      body: Center(
        child: Text(
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut "
          "labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip "
          "ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "
          "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          style: TextStyle(color: ColorProvider.of(context).data),
        ),
      ),
    );
  }
}
