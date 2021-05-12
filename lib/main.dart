import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Added for select key support on Android TV
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _input = 'Input text';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Show text input result
            Text(_input ?? ''),
            // Open a text input dialog
            ElevatedButton(
                child: Text('Open text input'),
                onPressed: () async {
                  final result = await getTextInputFromDialog(
                    context,
                  );
                  setState(() {
                    _input = result;
                  });
                }),
            // Random buttons to traverse
            ElevatedButton(
              child: Text('Button for testing navigation'),
              onPressed: () => print('tap'),
            ),
            ElevatedButton(
              child: Text('Button for testing navigation'),
              onPressed: () => print('tap'),
            ),
            ElevatedButton(
              child: Text('Button for testing navigation'),
              onPressed: () => print('tap'),
            )
          ],
        ),
      ),
    );
  }
  
  Future<String> getTextInputFromDialog(BuildContext context) async {
    String _input = '';
    _input = await Future.delayed(
      Duration.zero,
      () {
        return showDialog<String>(
          context: context,
          barrierDismissible: true, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
                backgroundColor: Colors.transparent,
                insetPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                content: CustomTextInputField());
          },
        );
      },
    );
    return _input;
  }
}

class CustomTextInputField extends StatefulWidget {
  @override
  _CustomTextInputFieldState createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  TextEditingController _queryTextController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2.0, color: Colors.white70),
        ),
      ),
      child: TextField(
        autofocus: true,
        controller: _queryTextController,
        textInputAction: TextInputAction.search,
        onEditingComplete: () {
          Navigator.of(context).pop(_queryTextController.text);
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _queryTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _queryTextController?.dispose();
  }
}
