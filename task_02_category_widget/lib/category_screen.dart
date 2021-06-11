import 'package:flutter/material.dart';
import 'package:task_02_category_widget/category.dart';

const _listSize = 8;
const _fontSize = 30.0;
const _elevation = 0.0;
const _themeColor = Colors.lightBlueAccent;

class CategoryScreen extends StatelessWidget {
  const CategoryScreen();

  static const _categoryNames = <String>[
    "Length",
    "Area",
    "Volume",
    "Mass",
    "Time",
    "Digital Storage",
    "Energy",
    "Currency",
  ];

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];

  static const _icons = <IconData>[
    Icons.linear_scale,
    Icons.aspect_ratio_rounded,
    Icons.check_box_outline_blank_rounded,
    Icons.rice_bowl,
    Icons.timelapse,
    Icons.storage_rounded,
    Icons.lightbulb_outline_rounded,
    Icons.attach_money_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final listView = Container(
      color: _themeColor,
      child: ListView.builder(
        itemCount: _listSize,
        itemBuilder: (BuildContext context, int index) {
          return Category(
            name: _categoryNames[index],
            icon: _icons[index],
            color: _baseColors[index],
          );
        },
      ),
    );

    final appBar = AppBar(
      elevation: _elevation,
      backgroundColor: _themeColor,
      centerTitle: true,
      title: Text(
        "Unit Converter",
        style: TextStyle(
          fontSize: _fontSize,
          color: Colors.black,
        ),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: listView,
    );
  }
}
