import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orgnz/widgets/Paragraph.dart';

class BlankPage extends StatefulWidget {
  final _children = [
    Paragraph(controller: new TextEditingController(), focus: new FocusNode())
  ];
  var removalIndex = 0;

  @override
  _BlankPageState createState() => new _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  FocusNode _textNode = new FocusNode();
  // TODO add a custom focus tag

  @override
  initState() {
    /* _textNode.addListener(() {
      print(FocusScope.of(context).focusedChild);
    }); */
    super.initState();
  }

  handleKey(key) {
    if (key.runtimeType == RawKeyDownEvent) {
      /* print(key.data.keyLabel); */

      if (key.data.keyLabel == 'ArrowUp') print('errou');
      if (key.data.keyLabel == 'Enter') {
        setState(() {
          for (var i = 0; i < widget._children.length; i++) {
            if (FocusScope.of(context).focusedChild ==
                widget._children[i].focus) {
              widget._children.insert(
                  i + 1,
                  Paragraph(
                      controller: new TextEditingController(),
                      focus: new FocusNode()));
              widget._children[i + 1].focus.requestFocus();
            }
          }
          /* _children.add(Paragraph(
              controller: new TextEditingController(), focus: new FocusNode())); */
        });
      }
    }
    if (key.runtimeType == RawKeyUpEvent) {
      if (key.data.keyLabel == 'Backspace' && widget._children.length > 1) {
        for (var i = 0; i < widget._children.length; i++) {
          if (FocusScope.of(context).focusedChild ==
              widget._children[i].focus) {
            /* print('focusScope: ${FocusScope.of(context).focusedChild}');
              print('child: ${widget._children[i].focus}'); */
            if (widget._children[i].controller.text.length == 0) {
              setState(() {
                widget._children.removeAt(i);
                widget.removalIndex = i;
              });
              /* _children[i - 1].focus.previousFocus(); */
              /* _children.removeAt(i); */
              /* _children[i - 1].focus.requestFocus(); */
              /* _children[i - 2].focus.requestFocus(); */
            }
          }
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
            children: widget._children.map((child) {
              /* if (_controller.text.length == 0) print('empty'); */
              return child;
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
