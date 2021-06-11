import 'package:flutter/material.dart';

class MenuIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const MenuIcon(this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(50.0),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}
