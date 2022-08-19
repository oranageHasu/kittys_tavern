import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kittys_tavern/main.dart';
import 'package:kittys_tavern/src/menu/filter/filter.dart';
import 'package:kittys_tavern/src/menu/menu_item.dart';
import 'package:kittys_tavern/src/models/bar_item.dart';
import 'package:kittys_tavern/src/models/drink.dart';
import 'package:kittys_tavern/src/models/shot.dart';
import '../settings/settings_view.dart';

class MenuView extends StatefulWidget {
  static const routeName = '/menu';

  const MenuView({
    Key? key,
  }) : super(key: key);

  static _WidgetState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MenuWidget>()!.data;
  }

  @override
  State<StatefulWidget> createState() {
    return _WidgetState();
  }
}

class _WidgetState extends State<MenuView> {
  FilterType _type = FilterType.drinks;
  final List<BarItem> _barItems = const [
    Drink(
      id: 1,
      name: 'Classic Martini',
      desc: 'The classic gin & vermouth based drink',
      imgPath: 'assets/images/drinks/martini.jpeg',
      ingredients: [
        '2 oz Gin',
        '1 oz Vermmouth',
      ],
    ),
    Drink(
      id: 2,
      name: 'Bozo Baggins',
      desc: 'This one will make you frank',
      imgPath: 'assets/images/drinks/green_thing.jpeg',
      ingredients: [
        '2 oz Rum',
        '1 oz Vodka',
      ],
    ),
    Drink(
      id: 3,
      name: 'Tequila Sunrise',
      desc: 'Tasty tropical flavours mixed in with white tequila',
      imgPath: 'assets/images/drinks/tequila_sunrise.jpeg',
      ingredients: [
        '2 oz White Tequila',
        '3 oz Orange Juice',
        '0.5 oz Red Stuff',
      ],
    ),
    Drink(
      id: 4,
      name: 'Classic Mojito',
      desc: 'The classic white rum, soda water, lime & mint drink',
      imgPath: 'assets/images/drinks/mojito.jpeg',
      ingredients: [
        '2 oz White Rum',
        '3 oz Soda Water',
        '0.25 oz Lime Juice',
        '4 crushed Mint Leafs',
      ],
    ),
    Drink(
      id: 5,
      name: 'Old Fashioned',
      desc: 'The drink of boomers and hipsters alike',
      imgPath: 'assets/images/drinks/old_fashioned.jpeg',
      ingredients: [
        '2 oz White Rum',
        '3 oz Soda Water',
        '0.25 oz Lime Juice',
        '4 crushed Mint Leafs',
      ],
    ),
    Drink(
      id: 6,
      name: 'Jame\'s Red Sangria',
      desc:
          'Jame\'s home made red sangria.  Made in the back of the short bus.',
      imgPath: 'assets/images/drinks/red_sangria.jpeg',
      ingredients: [
        '2 oz White Rum',
        '3 oz Soda Water',
        '0.25 oz Lime Juice',
        '4 crushed Mint Leafs',
        '1 slice of cheese',
        '3 cooked sausages',
      ],
    ),
    Shot(
      id: 1,
      name: 'Bacardi 151',
      imgPath: '',
      type: AlcoholType.vodka,
    ),
    Shot(
      id: 2,
      name: 'The Rock\'s Tequila',
      imgPath: '',
      type: AlcoholType.tequila,
    ),
    Shot(
      id: 3,
      name: 'White Owl',
      imgPath: '',
      type: AlcoholType.whisky,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    List<BarItem> items = _barItems
        .where(
          (element) =>
              (_type == FilterType.drinks) ? element is Drink : element is Shot,
        )
        .toList();

    return MenuWidget(
      data: this,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Kitty\'s Tavern',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontSize: 26.0,
                  color: Colors.white,
                ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  SettingsView.routeName,
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Filter(
              type: _type,
            ),
            const Divider(
              height: 3.0,
              thickness: 2.5,
              indent: 10.0,
              endIndent: 10.0,
            ),
            Container(
              height: (kIsWeb) ? height - 167.0 : height - 214.0,
              padding: const EdgeInsets.only(top: 5.0),
              child: ListView.builder(
                restorationId: 'drinkListView',
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final BarItem barItem = items[index];

                  return _buildListViewItem(barItem, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setMenuType(FilterType type) {
    setState(() {
      _type = type;
    });
  }
}

Widget _buildListViewItem(
  BarItem barItem,
  BuildContext context,
) {
  double width = MediaQuery.of(context).size.width;

  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(
        context,
        MenuItem.routeName,
        arguments: barItem.toJson(),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: (settingsController.isDarkTheme())
            ? const Color.fromARGB(255, 250, 188, 250).withOpacity(0.11)
            : Theme.of(context).primaryColor.withOpacity(0.18),
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(
        vertical: 2.0,
        horizontal: 5.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(3.0),
                bottomRight: Radius.circular(3.0),
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: Image.asset(
              (barItem.imgPath.isNotEmpty)
                  ? barItem.imgPath
                  : 'assets/images/flutter_logo.png',
              height: 80.0,
              width: 70.0,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15.0),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  barItem.name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  width: width - 105.0,
                  child: Text(
                    (barItem is Drink)
                        ? barItem.desc
                        : (barItem as Shot).type.name,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: (settingsController.isDarkTheme())
                              ? const Color.fromARGB(255, 169, 169, 169)
                              : const Color.fromARGB(255, 64, 64, 64),
                        ),
                    overflow: TextOverflow.visible,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class MenuWidget extends InheritedWidget {
  final _WidgetState data;

  const MenuWidget({
    Key? key,
    required Widget child,
    required this.data,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(MenuWidget oldWidget) {
    return true;
  }
}
