import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
//import 'package:meals/screens/tabs.dart';
//import 'package:meals/widgets/main_drawer.dart';

  enum Filters{
    glutenFree,
    lactoseFree,
    vegetarian,
    vegan,
  }


class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _veganFilterSet = false;
  var _vegetarianFilterSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: MainDrawer(onSelecetedScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == 'meals') {
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (ctx) => const TabsScreen(),
      //       ),
      //     );
      //   }
      // }),
      appBar: AppBar(
        title: const Text('Your Filter'),
      ),
      body: WillPopScope(
        onWillPop: ()async{
          Navigator.of(context).pop({
            Filters.glutenFree: _glutenFreeFilterSet,
            Filters.lactoseFree: _lactoseFreeFilterSet,
            Filters.vegan: _veganFilterSet,
            Filters.vegetarian: _vegetarianFilterSet,


          });
          return false;
        },
        child: Column(children: [
          SwitchListTile(
            value: _glutenFreeFilterSet,
            onChanged: (ischecked) {
              setState(() {
                _glutenFreeFilterSet = ischecked;
              });
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include gluten-free meals',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Colors.white,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
      
          SwitchListTile(
            value: _lactoseFreeFilterSet,
            onChanged: (ischecked) {
              setState(() {
                _lactoseFreeFilterSet = ischecked;
              });
            },
            title: Text(
              'Lactose-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include Lacose-free meals',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Colors.white,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
      
      
          SwitchListTile(
            value: _veganFilterSet,
            onChanged: (ischecked) {
              setState(() {
                _veganFilterSet = ischecked;
              });
            },
            title: Text(
              'Vegan-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include Vegan meals',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor:Colors.white,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
      
      
          SwitchListTile(
            value: _vegetarianFilterSet,
            onChanged: (ischecked) {
              setState(() {
                _vegetarianFilterSet = ischecked;
              });
            },
            title: Text(
              'Vegetarian-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              'Only include Vegetarian meals',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            activeColor: Colors.white,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
            
          ),
        ]),
      ),
    );
  }
}
