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
  Unit _inputUnit;
  Unit _outputUnit;
  bool validationCheck = false;
  double inputValue;
  double outputValue;
  String converted = '';

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
      _outputUnit = widget.units[1];
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

  void _update(String value) {
    setState(() {
      if (value == null || value.isEmpty) {
        converted = '';
      } else {
        try {
          inputValue = double.parse(value);
          validationCheck = false;
          convert();
        } on Exception catch (e) {
          validationCheck = true;
          print(e);
        }
      }
    });
  }

  void convert() {
    setState(() {
      outputValue =
          inputValue * (_outputUnit.conversion / _inputUnit.conversion);
      converted = _format(outputValue);
    });
  }

  void _inputChanged(dynamic unit) {
    setState(() {
      _inputUnit = _updateValue(unit);
    });
    if (inputValue != null) {
      convert();
    }
  }

  void _outputChanged(dynamic unit) {
    setState(() {
      _outputUnit = _updateValue(unit);
    });
    if (inputValue != null) {
      convert();
    }
  }

  Container _buildDropDown(Unit unit, var changed) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[400],
          width: 1.0,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          value: unit.name,
          style: Theme.of(context).textTheme.headline6,
          onChanged: changed,
          items: _returnDropDownItems(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Column inputCol = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.headline4,
          decoration: InputDecoration(
            labelStyle: Theme.of(context).textTheme.headline4,
            labelText: 'Input',
            errorText: validationCheck ? "Enter numbers only!" : null,
            errorStyle: TextStyle(color: Colors.red, fontSize: 18.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
          onChanged: _update,
        ),
        _buildDropDown(_inputUnit, _inputChanged),
      ],
    );

    final Padding inputSection = Padding(
      padding: EdgeInsets.all(16.0),
      child: inputCol,
    );

    final RotatedBox icon = RotatedBox(
      quarterTurns: 1,
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
    );

    final Column outputCol = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InputDecorator(
          child: Text(
            converted,
            style: Theme.of(context).textTheme.headline4,
          ),
          decoration: InputDecoration(
            labelStyle: Theme.of(context).textTheme.headline4,
            labelText: 'Output',
            enabled: false,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
          ),
        ),
        _buildDropDown(_outputUnit, _outputChanged),
      ],
    );

    final Padding outputSection = Padding(
      padding: _padding,
      child: outputCol,
    );

    return Column(
      children: [inputSection, icon, outputSection],
    );
  }
}
