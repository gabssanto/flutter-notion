import 'package:flutter/material.dart';

class Popup extends StatefulWidget {
  const Popup({Key? key}) : super(key: key);

  @override
  _PopupState createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  GlobalKey containerKey = GlobalKey();
  Offset childOffset = Offset(0, 0);
  Size? childSize;
  bool _isOpen = false;

  getOffset() {
    RenderBox renderBox =
    containerKey.currentContext!.findRenderObject() as RenderBox;
    Size size = renderBox.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    setState(() {
      this.childOffset = Offset(offset.dx, offset.dy);
      childSize = size;
    });
  }


  openMenu(BuildContext context) {
    getOffset();
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 100),
            pageBuilder: (context, animation, secondaryAnimation) {
              animation = Tween(begin: 0.0, end: 1.0).animate(animation);
              return FadeTransition(
                  opacity: animation,
                  child: Container(
                    child: Column(
                      children: [
                        Text('asdfas'),
                        Text('asdfas'),
                        Text('asdfas'),
                        Text('asdfas'),
                      ],
                    )
                  ));
            },
            fullscreenDialog: true,
            opaque: false));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: IconButton(icon: Icon(Icons.menu, color: Colors.black38), onPressed: () {
            setState(() {
              _isOpen = true;
            });
          },),
        ),
        _isOpen ? openMenu(context) : Container(),
      ],
    );
  }
}
