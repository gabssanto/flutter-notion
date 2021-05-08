import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orgnz/widgets/Paragraph.dart';

class BlankPage extends StatefulWidget {
  BlankPage();

  @override
  _BlankPageState createState() => new _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  FocusNode _textNode = new FocusNode();
  final _children = [new TextEditingController()];

  @override
  initState() {
    super.initState();
  }

  handleKey(key) {
    if (key.runtimeType == RawKeyDownEvent) {
      print(key.data.keyLabel);
      if (key.data.keyLabel == 'Enter') {
        setState(() {
          _children.add(new TextEditingController());
        });
      }
    }
    if (key.runtimeType == RawKeyUpEvent) {
      if (key.data.keyLabel == 'Enter') {
        final node = FocusScope.of(context);
        for (var i = 0; i < _children.length; i++) {
          node.nextFocus();
        }
      }
    }
  }

  _buildTextComposer() {
    FocusScope.of(context).requestFocus(_textNode);

    return RawKeyboardListener(
        focusNode: _textNode,
        onKey: (RawKeyEvent key) => handleKey(key),
        child: SingleChildScrollView(
          child: Column(
            children: _children.map((ctrl) {
              if (ctrl.text.length == 0) print('cu');
              return Paragraph(controller: ctrl);
            }).toList(),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildTextComposer(),
    );
  }
}
