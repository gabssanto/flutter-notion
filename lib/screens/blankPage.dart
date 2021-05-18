import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orgnz/widgets/Paragraph.dart';

class BlankPage extends StatefulWidget {
  @override
  _BlankPageState createState() => new _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  final focusNode = new FocusNode();
  final _children = [
    Paragraph(),
  ];
  var canDelete = false;


  handleKey(key) {
    if (key.runtimeType == RawKeyDownEvent) {
      if (key.data.keyLabel == 'Escape' || key.logicalKey.keyLabel == 'Escape') {
        print('hehe');
      }
      if (key.data.keyLabel == 'Backspace' || key.logicalKey.keyLabel == 'Backspace') setState(() {
        for (var i = 0; i < _children.length; i++) {
          // print(_children[i].controller.text);
          if (i != 0
              && FocusScope.of(context).focusedChild == _children[i].focus
              && _children[i].controller.text.length == 0) {
            setState(() {
              canDelete = true;
            });
          }
        }
      });
      if (key.data.keyLabel == 'Enter' || key.logicalKey.keyLabel == 'Enter') setState(() {
        for (var i = 0; i < _children.length; i++) {
          if (FocusScope.of(context).focusedChild == _children[i].focus) {
            _children.insert(i + 1, Paragraph());
            _children[i + 1].focus.requestFocus();
          }
        }
      });
    }
    if (key.runtimeType == RawKeyUpEvent) {
      if (key.data.keyLabel == 'Backspace' || key.logicalKey.keyLabel == 'Backspace') setState(() {
        for (var i = 0; i < _children.length; i++) {
          // print(_children[i].controller.text);
          if (i != 0
              && FocusScope.of(context).focusedChild == _children[i].focus
              && _children[i].controller.text.length == 0) {
            if (canDelete) {
              _children[i-1].focus.requestFocus();
              _children.removeAt(i);
              setState(() {
                canDelete = false;
              });
            }
          }
        }
      });
    }
  }

  Widget _textBuilder () {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: _children,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
        focusNode: focusNode,
        onKey: (RawKeyEvent key) => handleKey(key),
        child: Scaffold(
          body: this._textBuilder(),
        ));
  }
}
