import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orgnz/widgets/PopupMenuHolder.dart';

class Paragraph extends StatefulWidget {
  Paragraph({Key? key}) : super(key: key);

  final TextEditingController controller = new TextEditingController();
  final FocusNode focus = new FocusNode();
  final FocusNode rawKeyboardFocus = new FocusNode();

  @override
  _ParagraphState createState() => _ParagraphState();
}

class _ParagraphState extends State<Paragraph> {
  String dropdownValue = 'One';
  Color backgroundColor = Colors.transparent;
  double opacity = 0;
  bool renderBlockChange = false;

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
    // print('disposed');
    // widget.focus.dispose();
    // widget.RawKeyboardFocus.dispose();
    // widget.controller.dispose();
    super.dispose();
  }

  _onEnter(e) {
    setState(() {
      backgroundColor = Colors.black12;
      opacity = 1;
    });
  }

  _onExit(e) {
    setState(() {
      backgroundColor = Colors.transparent;
      opacity = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => _onEnter(e),
      onExit: (e) => _onExit(e),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            AnimatedOpacity(
                opacity: opacity,
                duration: Duration(milliseconds: 200),
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  child: PopupMenuHolder(
                    menuWidth: MediaQuery.of(context).size.width * 0.50,
                    blurSize: 5.0,
                    menuItemExtent: 45,
                    menuBoxDecoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    duration: Duration(milliseconds: 200),
                    animateMenuItems: true,
                    blurBackgroundColor: Colors.transparent,
                    openWithTap:
                        true, // Open Focused-Menu on Tap rather than Long Press
                    menuOffset:
                        10.0, // Offset value to show menuItem from the selected item
                    bottomOffsetHeight:
                        80.0, // Offset height to consider, for showing the menu item ( for example bottom navigation bar), so that the popup menu will be shown on top of selected item.
                    onPressed: () {
                      setState(() {
                        renderBlockChange = !renderBlockChange;
                      });
                    },
                    menuItems: <FocusedMenuItem>[
                      FocusedMenuItem(
                          title: Text("Open"),
                          trailingIcon: Icon(Icons.open_in_new),
                          onPressed: () {}),
                      FocusedMenuItem(
                          title: Text("Share"),
                          trailingIcon: Icon(Icons.share),
                          onPressed: () {}),
                      FocusedMenuItem(
                          title: Text("Favorite"),
                          trailingIcon: Icon(Icons.favorite_border),
                          onPressed: () {}),
                      FocusedMenuItem(
                          title: Text(
                            "Delete",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          trailingIcon: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {}),
                    ],
                    child: Icon(Icons.menu, color: Colors.black38),
                  ),
                )),
            Flexible(
              child: TextField(
                cursorColor: Colors.black12,
                style: TextStyle(fontSize: 16, height: 1.5),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.deny('\n'),
                ],
                controller: widget.controller,
                focusNode: widget.focus,
                autofocus: false,
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
