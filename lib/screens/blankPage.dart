import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orgnz/widgets/TextBlock.dart';

class BlankPage extends StatefulWidget {
  @override
  _BlankPageState createState() => new _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  final focusNode = new FocusNode();
  final _children = [
    TextBlock(),
  ];
  var canDelete = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    this.focusNode.dispose();
    super.dispose();
  }

  handleKey(key) {
    if (key.runtimeType == RawKeyDownEvent) {
      // print(key.data.keyLabel);
      // TODO: BUG textEditingController being used after disposed
      if (key.data.keyLabel == 'ArrowUp' || key.logicalKey.keyLabel == 'ArrowUp') setState(() {
        for (var i = 0; i < _children.length; i++) {
          if (i != 0 && FocusScope.of(context).focusedChild == _children[i].focus) {
            _children[i-1].focus.requestFocus();
          }
        }
      });
      if (key.data.keyLabel == 'ArrowDown' || key.logicalKey.keyLabel == 'ArrowDown') setState(() {
        final reversedChildren = _children.reversed.toList();
        for (var i = 0; i < reversedChildren.length; i++) {
          if (i != 0 && FocusScope.of(context).focusedChild == reversedChildren[i].focus) {
            reversedChildren[i-1].focus.requestFocus();
          }
        }
      });
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
            _children.insert(i + 1, new TextBlock());
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
              setState(() {
                _children[i-1].focus.requestFocus();
                _children.removeAt(i);
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
        padding: const EdgeInsets.all(16.0),
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
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {},
          ),
        ));
  }
}
