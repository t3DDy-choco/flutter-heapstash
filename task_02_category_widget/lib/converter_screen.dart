import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'unit.dart';

/// Converter screen where users can input amounts to convert.
///
/// Currently, it just displays a list of mock units.
///
/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.
class ConverterScreen extends StatelessWidget {
  /// Units for this [Category].
  final String name;
  final List<Unit> units;
  final ColorSwatch color;

  /// This [ConverterScreen] requires the color and units to not be null.
  const ConverterScreen({
    @required this.name,
    @required this.units,
    @required this.color,
  })  : assert(units != null),
        assert(color != null),
        assert(name != null);

  @override
  Widget build(BuildContext context) {
    // Here is just a placeholder for a list of mock units
    final unitWidgets = units.map((Unit unit) {
      return Container(
        color: color,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(
              unit.name,
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
              'Conversion: ${unit.conversion}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      );
    }).toList();

    return ListView(
      children: unitWidgets,
    );
  }
}
