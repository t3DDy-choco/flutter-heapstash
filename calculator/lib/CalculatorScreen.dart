import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'MenuIcon.dart';

final Color _iconColorPrimary = Colors.white;

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen();

  static const _iconList = <IconData>[
    Icons.compare_arrows_rounded,
    Icons.grid_view_rounded,
    Icons.home_filled,
  ];

  static const _numpad = <String>[
    'C',
    'del',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    ' 6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '00',
    '0',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: topMenu(_iconList, _iconColorPrimary),
          ),
          Container(
            alignment: Alignment.bottomRight,
            padding: EdgeInsets.only(right: 40),
            height: 220,
            child: Text(
              'Bruh',
              textAlign: TextAlign.right,
              style: TextStyle(color: colorSelect(1), fontSize: 36.0),
            ),
          ),
          new Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: List.generate(20, (index) {
                return Center(
                  child: Text(
                    "${_numpad[index]}",
                    style: TextStyle(color: colorSelect(index), fontSize: 36.0),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> topMenu(List<IconData> iconsList, Color color) {
    List<Widget> menuBar = [];
    iconsList.forEach((icon) {
      menuBar.add(MenuIcon(icon, color));
    });
    return menuBar;
  }

  Color colorSelect(int n) {
    if (n < 4 || (n % 4 == 3) || n == 16)
      return Colors.orangeAccent.shade700;
    else
      return Colors.white;
  }
}
