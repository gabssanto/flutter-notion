import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Paragraph extends StatefulWidget {
  Paragraph({Key? key, required this.controller, required this.focus})
      : super(key: key);

  final TextEditingController controller;
  final FocusNode focus;

  @override
  _ParagraphState createState() => _ParagraphState();
}

class _ParagraphState extends State<Paragraph> {
  /* final FocusNode _focusNode = FocusNode(); */

  /* final myController = TextEditingController(); */

  _printLatestValue() {
    if (widget.controller.text.contains('\n')) {
      widget.controller.text = widget.controller.text.replaceAll('\n', '');
      /* widget.focus.unfocus(); */
      /* widget.focus.requestFocus();
      widget.focus.ne(); */

    }

    /* print("Second text field: ${widget.controller.text}"); */
  }

  @override
  void initState() {
    super.initState();
    /* widget.focus.requestFocus(); */
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.deny('\n'),
        ],
        controller: widget.controller,
        focusNode: widget.focus,
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
      ),
    );
  }
}
