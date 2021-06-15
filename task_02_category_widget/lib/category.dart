import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'converter_screen.dart';
import 'unit.dart';

final _height = 100.0;
final _borderRadius = BorderRadius.circular(_height / 2);

class Category extends StatelessWidget {
  final String name;
  final IconData icon;
  final ColorSwatch color;
  final List<Unit> units;

  const Category({
    Key key,
    @required this.name,
    @required this.icon,
    @required this.color,
    @required this.units,
  })  : assert(name != null),
        assert(color != null),
        assert(icon != null),
        assert(units != null),
        super(key: key);

  void _navigateToConverter(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          elevation: 1.0,
          title: Text(
            name,
            style: Theme.of(context).textTheme.headline4,
          ),
          centerTitle: true,
          backgroundColor: color,
        ),
        body: ConverterScreen(
          units: units,
          color: color,
        ),
      );
    }));
  }

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
          onTap: () => _navigateToConverter(context),
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
                    style: Theme.of(context).textTheme.headline5,
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
