import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Paragraph extends StatefulWidget {
  final TextEditingController controller = new TextEditingController();
  final FocusNode focus = new FocusNode();

  @override
  _ParagraphState createState() => _ParagraphState();
}

class _ParagraphState extends State<Paragraph> {
  String dropdownValue = 'One';

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    // widget.controller.addListener(_printLatestValue);
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
    return Row(
      children: [
        // PopupMenuButton<String>(
        //   icon: Icon(Icons.menu),
        //   offset: Offset(0, 50),
        //   onSelected: (value) {
        //     switch (value) {
        //       case 'H1':
        //         break;
        //       case 'p':
        //         break;
        //     }
        //   },
        //   itemBuilder: (BuildContext context) {
        //     return {'H1', 'p'}.map((String choice) {
        //       return PopupMenuItem<String>(
        //         value: choice,
        //         child: Text(choice),
        //       );
        //     }).toList();
        //   },
        // ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              cursorColor: Colors.black12,
              style: TextStyle(
                fontSize: 16,
                height: 1.5

              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.deny('\n'),
              ],
              controller: widget.controller,
              focusNode: widget.focus,
              autofocus: false,
              maxLines: null,
            ),
          ),
        ),

        // DropdownButton<String>(
          // value: dropdownValue,
          // iconSize: 24,
          // elevation: 16,
          // style: const TextStyle(color: Colors.deepPurple),
          // underline: Container(
          // height: 2,
          // color: Colors.deepPurpleAccent,
          // ),
          // onChanged: (String? newValue) {
          // setState(() {
          // dropdownValue = newValue!;
          // });
          // },
          // items: <String>['One', 'Two', 'Free', 'Four']
          //     .map<DropdownMenuItem<String>>((String value) {
          // return DropdownMenuItem<String>(
          // value: value,
          // child: Text(value),
          // );
          // }).toList(),
          // )
      ],
    );
  }
}
/*
Positioned(
          child: Padding(
            padding: const EdgeInsets.only(top: 60, left: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],

              ),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('hello world'),
              ),
            ),
          ),
        ),
 */