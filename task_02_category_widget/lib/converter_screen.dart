import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'unit.dart';

const _padding = EdgeInsets.all(16.0);

class ConverterScreen extends StatefulWidget {
  final List<Unit> units;
  final Color color;

  const ConverterScreen({
    @required this.units,
    @required this.color,
  })  : assert(units != null),
        assert(color != null);

  @override
  State<StatefulWidget> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  // TODO: Set some variables, such as for keeping track of the user's input value and units
  Unit _inputUnit;
  bool validationCheck = false;
  double inputValue;

  // TODO: Add other helper functions. We've given you one, _format()

  /// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  @override
  void initState() {
    super.initState();
    _returnDropDownItems();
    _setDefaults();
  }

  void _setDefaults() {
    setState(() {
      _inputUnit = widget.units[0];
    });
  }

  List<DropdownMenuItem> _returnDropDownItems() {
    var unitString = <DropdownMenuItem>[];
    for (var unit in widget.units) {
      unitString.add(
        DropdownMenuItem(
          value: unit.name,
          child: Container(
            child: Text(
              unit.name,
              softWrap: true,
            ),
          ),
        ),
      );
    }
    return unitString;
  }

  Unit _updateValue(String name) {
    for (var unit in widget.units) {
      if (unit.name == name) {
        return unit;
      }
    }
    return null;
  }

  void _inputValidation(String value) {
    setState(() {
      try {
        inputValue = double.parse(value);
        validationCheck = false;
      } on Exception catch (e) {
        validationCheck = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Create the 'input' group of widgets. This is a Column that
    // includes the input value, and 'from' unit [Dropdown].
    final Column input = Column(
      children: [
        TextField(
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.headline6,
          decoration: InputDecoration(
            labelStyle: Theme.of(context).textTheme.headline4,
            labelText: 'Input',
            errorText: validationCheck ? "Enter numbers only!" : null,
            errorStyle: TextStyle(color: Colors.red, fontSize: 18.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
          onChanged: _inputValidation,
        ),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border.all(
            color: Colors.grey[400],
            width: 1.0,
          )),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              value: _inputUnit.name,
              style: Theme.of(context).textTheme.headline6,
              onChanged: (newValue) {
                setState(() {
                  _inputUnit = _updateValue(newValue);
                });
              },
              items: _returnDropDownItems(),
            ),
          ),
        ),
      ],
    );

    // TODO: Create a compare arrows icon.

    // TODO: Create the 'output' group of widgets. This is a Column that
    // includes the output value, and 'to' unit [Dropdown].

    // TODO: Return the input, arrows, and output widgets, wrapped in a Column.

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: ListView(
        children: [input],
      ),
    );
  }
}
