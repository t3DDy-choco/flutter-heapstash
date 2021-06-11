import 'package:flutter/material.dart';

/// A custom [Category] widget.
///
/// The widget is composed on an [Icon] and [Text]. Tapping on the widget shows
/// a colored [InkWell] animation.
final _height = 100.0;
final _borderRadius = BorderRadius.circular(_height / 2);

class Category extends StatelessWidget {
  final String name;
  final IconData icon;
  final ColorSwatch color;

  const Category({
    Key key,
    @required this.name,
    @required this.icon,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _height,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: color,
          splashColor: color,
          onTap: () => print("I was tapped"),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    icon,
                    size: 60.0,
                    color: color,
                  ),
                ),
                Center(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
