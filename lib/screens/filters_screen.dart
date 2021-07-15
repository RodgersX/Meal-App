import 'package:delimeals/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _lactoseFree = widget.currentFilters['lactose']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _vegan = widget.currentFilters['vegan']!;
    super.initState();
  }

  Widget _buildSwitchListTile(
      String title, String desc, bool currentVal, Function(bool) updateVal) {
    return SwitchListTile(
      title: Text(title),
      value: currentVal,
      subtitle: Text(desc),
      onChanged: updateVal,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
          actions: [
            IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian
                };
                widget.saveFilters(selectedFilters);
              },
              icon: Icon(Icons.save),
            ),
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust your meal election',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchListTile(
                    'Gluten-Free',
                    'Only includes Gluten-free meals',
                    _glutenFree,
                    (bool newValue) {
                      setState(() {
                        _glutenFree = newValue;
                      });
                    },
                  ),
                  _buildSwitchListTile(
                      'Lactose-Free',
                      'Only includes Lactose-free meals',
                      _lactoseFree, (bool newVal) {
                    setState(() {
                      _lactoseFree = newVal;
                    });
                  }),
                  _buildSwitchListTile(
                      'Vegetarian',
                      'Only includes Vegetarian meals',
                      _vegetarian, (bool newVal) {
                    setState(() {
                      _vegetarian = newVal;
                    });
                  }),
                  _buildSwitchListTile(
                      'Vegan', 'Only includes vegan meals', _vegan,
                      (bool newVal) {
                    setState(() {
                      _vegan = newVal;
                    });
                  }),
                ],
              ),
            )
          ],
        ));
  }
}
