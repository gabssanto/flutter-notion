import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const h1 = TextStyle(
  fontSize: 37,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const h2 = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const h3 = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

const text = TextStyle(
  fontSize: 16,
  height: 1.5,
  color: Colors.black,
);



class TextBlock extends StatefulWidget {
  TextBlock({Key? key}) : super(key: key);

  final TextEditingController controller = new TextEditingController();
  final FocusNode focus = new FocusNode();
  final FocusNode rawKeyboardFocus = new FocusNode();

  @override
  _TextBlockState createState() => _TextBlockState();
}

class _TextBlockState extends State<TextBlock> {
  String dropdownValue = 'One';
  Color backgroundColor = Colors.transparent;
  double opacity = 0;
  bool renderBlockChange = false;
  TextStyle activeStyle = text;

  List<FocusNode> styleNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    super.initState();
    widget.focus.addListener(() {
      if (!widget.focus.hasFocus
          && !styleNodes[0].hasFocus
          && !styleNodes[1].hasFocus
          && !styleNodes[2].hasFocus
          && !styleNodes[3].hasFocus)
      setState(() {
        renderBlockChange = false;
        backgroundColor = Colors.transparent;
        opacity = 0;
      });
    });
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
      if (!renderBlockChange) {
        backgroundColor = Colors.transparent;
        opacity = 0;
      }
    });
  }

  handleKey(key) {
    if (key.runtimeType == RawKeyDownEvent) {
      if (key.data.keyLabel == 'ArrowRight' || key.logicalKey.keyLabel == 'ArrowRight') setState(() {
        if (styleNodes[0].hasFocus || styleNodes[1].hasFocus || styleNodes[2].hasFocus) {
          FocusScope.of(context).focusedChild!.nextFocus();
        }
      });
      if (key.data.keyLabel == 'ArrowLeft' || key.logicalKey.keyLabel == 'ArrowLeft') setState(() {
        if (styleNodes[1].hasFocus || styleNodes[2].hasFocus || styleNodes[3].hasFocus) {
          FocusScope.of(context).focusedChild!.previousFocus();
        }
      });
      if (key.data.keyLabel == 'ArrowUp' || key.logicalKey.keyLabel == 'ArrowUp') {
        setState(() {
          if (widget.focus.hasFocus && renderBlockChange) widget.focus.requestFocus();
          if (renderBlockChange
              && (styleNodes[0].hasFocus || styleNodes[1].hasFocus || styleNodes[2].hasFocus || styleNodes[3].hasFocus))
            widget.focus.requestFocus();
        });
      }
      if (key.data.keyLabel == 'ArrowDown' || key.logicalKey.keyLabel == 'ArrowDown') {
        setState(() {
          if (renderBlockChange && widget.focus.hasFocus) styleNodes[0].requestFocus();
        });
      }
      if (key.data.keyLabel == 'Escape' || key.logicalKey.keyLabel == 'Escape') {
        setState(() {
          renderBlockChange = !renderBlockChange;
          if (renderBlockChange) {
            backgroundColor = Colors.black12;
            opacity = 1;
          }
          else {
            backgroundColor = Colors.transparent;
            opacity = 0;
            widget.focus.requestFocus();
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: widget.rawKeyboardFocus,
      onKey: (RawKeyEvent key) => handleKey(key),
      child: MouseRegion(
        onEnter: (e) => _onEnter(e),
        onExit: (e) => _onExit(e),
        child: AnimatedContainer(
          margin: EdgeInsets.only(bottom: 20),
          height: renderBlockChange ? 170 : 100,
          duration: Duration(milliseconds: 200),
          decoration: BoxDecoration(
              color: backgroundColor, borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  AnimatedOpacity(
                      opacity: opacity,
                      duration: Duration(milliseconds: 200),
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        child: IconButton(icon: Icon(Icons.menu, color: Colors.black38), onPressed: () {
                          setState(() {
                            renderBlockChange = !renderBlockChange;
                          });
                        }),
                      )),
                  Flexible(
                    child: TextField(
                      cursorColor: Colors.black12,
                      style: activeStyle,
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
              Expanded(
                child: AnimatedContainer(
                  margin: EdgeInsets.only(top: 12, left: 60),
                  duration: Duration(milliseconds: 200),
                  height: renderBlockChange ?  70 : 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        focusNode: styleNodes[0],
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                              'Heading 1',
                              style: h1
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            activeStyle = h1;
                            renderBlockChange = false;
                            opacity = 0;
                            backgroundColor = Colors.transparent;
                            widget.focus.requestFocus();
                          });
                        },
                      ),
                      Padding(padding: EdgeInsets.only(left: 20)),
                      TextButton(
                        focusNode: styleNodes[1],
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Heading 2',
                            style: h2,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            activeStyle = h2;
                            renderBlockChange = false;
                            opacity = 0;
                            backgroundColor = Colors.transparent;
                            widget.focus.requestFocus();
                          });
                        },
                      ),
                      Padding(padding: EdgeInsets.only(left: 20)),
                      TextButton(
                        focusNode: styleNodes[2],
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                              'Heading 3',
                              style: h3
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            activeStyle = h3;
                            renderBlockChange = false;
                            opacity = 0;
                            backgroundColor = Colors.transparent;
                            widget.focus.requestFocus();
                          });
                        },
                      ),
                      Padding(padding: EdgeInsets.only(left: 20)),
                      TextButton(
                        focusNode: styleNodes[3],
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Text',
                            style: text,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            activeStyle = text;
                            renderBlockChange = false;
                            opacity = 0;
                            backgroundColor = Colors.transparent;
                            widget.focus.requestFocus();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
