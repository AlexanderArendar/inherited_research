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
    return oldWidget.data != data;
  }
}

class ColorPickerState extends State<ColorPicker> {
  Color _data;

  @override
  void initState() {
    super.initState();
    _data = Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Radio(
                  value: Colors.red,
                  groupValue: _data,
                  onChanged: (value) {
                    setState(() {
                      _data = value;
                    });
                  },
                ),
                Text(
                  "Red Color",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Radio(
                  value: Colors.green,
                  groupValue: _data,
                  onChanged: (value) {
                    setState(() {
                      _data = value;
                    });
                  },
                ),
                Text(
                  "Green Color",
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: ColorProvider(
            child: widget.child,
            data: _data,
          ),
        )
      ],
    );
  }
}

class ColorPicker extends StatefulWidget {
  final Widget child;

  ColorPicker({this.child, Key key})
      : super(
          key: key,
        );

  @override
  State<StatefulWidget> createState() => ColorPickerState();
}

class ContextDependentTextState extends State<ContextDependentText> {
  Color _borderColor;

  void _saveColorStateInPreferences(){
    //some expensive BE call here
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Color textColor = ColorProvider.of(context).data;
    if (textColor == Colors.green)
      _borderColor = Colors.red;
    else
      _borderColor = Colors.green;
    _saveColorStateInPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut "
        "labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip "
        "ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "
        "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        style: TextStyle(
          color: ColorProvider.of(context).data,
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          style: BorderStyle.solid,
          color: _borderColor,
        ),
      ),
    );
  }
}

class ContextDependentText extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ContextDependentTextState();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inherited Research',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
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
      body: ColorPicker(
        child: ContextDependentText(),
      ),
    );
  }
}
