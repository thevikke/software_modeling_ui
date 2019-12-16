import 'package:flutter/material.dart';

class TranslateOnHover extends StatefulWidget {
  TranslateOnHover({Key key, this.child}) : super(key: key);
  final Widget child;
  @override
  _TranslateOnHoverState createState() => _TranslateOnHoverState();
}

class _TranslateOnHoverState extends State<TranslateOnHover> {
  final nonHoverTransform = Matrix4.identity();
  final hoverTransform = Matrix4.identity()..translate(0, -10, 0);

  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MouseRegion(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          child: widget.child,
          transform: _hovering ? hoverTransform : nonHoverTransform,
        ),
        onEnter: (e) => _mouseEnter(true),
        onExit: (e) => _mouseEnter(false),
      ),
    );
  }

  void _mouseEnter(bool hovering) {
    setState(() {
      _hovering = hovering;
    });
  }
}
