import 'package:flutter/material.dart';

class Paragraph extends StatefulWidget {
  Paragraph({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  _ParagraphState createState() => _ParagraphState();
}

class _ParagraphState extends State<Paragraph> {
  final FocusNode _focusNode = FocusNode();

  /* final myController = TextEditingController(); */

  _printLatestValue() {
    if (widget.controller.text.endsWith('\n')) {
      widget.controller.text = widget.controller.text.replaceAll('\n', '');
      _focusNode.unfocus();
    }

    print("Second text field: ${widget.controller.text}");
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    widget.controller.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      autofocus: false,
      maxLines: null,
      /* onSubmitted: (value) {
        print('cu');
        _focusNode.unfocus();
      },
      onEditingComplete: () {
        print("edit");
        _focusNode.unfocus();
      }, */
    );
  }
}
