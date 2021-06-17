import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'unit_converter.dart';
import 'category.dart';
import 'category_tile.dart';
import 'unit.dart';
import 'backdrop.dart';

/// Category Route (screen).
/// This is the 'home' screen of the Unit Converter. It shows a header and
/// a list of [Categories].
class CategoryScreen extends StatefulWidget {
  const CategoryScreen();

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Category defaultCategory;
  Category selectedCategory;
  Color color;

  final _categories = <Category>[];

  static const _baseColors = <ColorSwatch>[
    ColorSwatch(0xFF6AB7A8, {
      'highlight': Color(0xFF6AB7A8),
      'splash': Color(0xFF0ABC9B),
    }),
    ColorSwatch(0xFFFFD28E, {
      'highlight': Color(0xFFFFD28E),
      'splash': Color(0xFFFFA41C),
    }),
    ColorSwatch(0xFFFFB7DE, {
      'highlight': Color(0xFFFFB7DE),
      'splash': Color(0xFFF94CBF),
    }),
    ColorSwatch(0xFF8899A8, {
      'highlight': Color(0xFF8899A8),
      'splash': Color(0xFFA9CAE8),
    }),
    ColorSwatch(0xFFEAD37E, {
      'highlight': Color(0xFFEAD37E),
      'splash': Color(0xFFFFE070),
    }),
    ColorSwatch(0xFF81A56F, {
      'highlight': Color(0xFF81A56F),
      'splash': Color(0xFF7CC159),
    }),
    ColorSwatch(0xFFD7C0E2, {
      'highlight': Color(0xFFD7C0E2),
      'splash': Color(0xFFCA90E5),
    }),
    ColorSwatch(0xFFCE9A9A, {
      'highlight': Color(0xFFCE9A9A),
      'splash': Color(0xFFF94D56),
      'error': Color(0xFF912D2D),
    }),
  ];

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    // We have static unit conversions located in our
    // assets/data/regular_units.json
    if (_categories.isEmpty) {
      await _retrieveLocalCategories();
    }
  }

  /// Retrieves a list of [Categories] and their [Unit]s
  Future<void> _retrieveLocalCategories() async {
    // Consider omitting the types for local variables. For more details on Effective
    // Dart Usage, see https://www.dartlang.org/guides/language/effective-dart/usage
    final json = DefaultAssetBundle.of(context)
        .loadString('assets/data/regular_units.json');
    final data = JsonDecoder().convert(await json);
    if (data is! Map) {
      throw ('Data retrieved from API is not a Map');
    }

    var categoryIndex = 0;
    data.keys.forEach((key) {
      final List<Unit> units =
          data[key].map<Unit>((dynamic data) => Unit.fromJson(data)).toList();
      var category = Category(
        name: key,
        units: units,
        color: _baseColors[categoryIndex],
        iconLocation: Icons.cake,
      );
      setState(() {
        if (categoryIndex == 0) {
          defaultCategory = category;
          color = defaultCategory.color;
        }
        _categories.add(category);
      });
      categoryIndex += 1;
    });
  }

  void _onCategoryTap(Category category) {
    setState(() {
      selectedCategory = category;
    });
  }

  /// For portrait, we use a [ListView].
  Widget _buildCategoryWidgets(Orientation deviceOrientation) {
    if (deviceOrientation == Orientation.portrait) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return CategoryTile(
            category: _categories[index],
            onTap: _onCategoryTap,
          );
        },
        itemCount: _categories.length,
      );
    } else
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3.0,
        children: _categories.map((Category c) {
          return CategoryTile(
            category: c,
            onTap: _onCategoryTap,
          );
        }).toList(),
      );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMediaQuery(context));
    final listView = Container(
      color: color,
      padding: EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 48.0,
      ),
      child: _buildCategoryWidgets(MediaQuery.of(context).orientation),
    );

    return Backdrop(
        currentCategory:
            selectedCategory == null ? defaultCategory : selectedCategory,
        frontPanel: selectedCategory == null
            ? UnitConverter(category: defaultCategory)
            : UnitConverter(category: selectedCategory),
        backPanel: listView,
        frontTitle: Text("Unit Converter"),
        backTitle: Text("Select a Category"));
  }
}
