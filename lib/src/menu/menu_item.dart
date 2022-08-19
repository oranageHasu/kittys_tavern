import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kittys_tavern/main.dart';
import 'package:kittys_tavern/src/models/bar_item.dart';
import 'package:kittys_tavern/src/models/drink.dart';
import 'package:kittys_tavern/src/models/shot.dart';

class MenuItem extends StatefulWidget {
  final BarItem item;
  static const routeName = '/menu_item';

  const MenuItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WidgetState();
  }
}

class _WidgetState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Drink Info',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 26.0,
                color: Colors.white,
              ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: height / 3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage(widget.item.imgPath),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0,
                sigmaY: 10.0,
              ),
              child: Center(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Image.asset(
                    widget.item.imgPath,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.item.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  (widget.item is Drink)
                      ? (widget.item as Drink).desc
                      : (widget.item as Shot).type.name,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: (settingsController.isDarkTheme())
                            ? const Color.fromARGB(255, 169, 169, 169)
                            : const Color.fromARGB(255, 64, 64, 64),
                      ),
                  overflow: TextOverflow.visible,
                  maxLines: 10,
                ),
                const SizedBox(height: 25.0),
                if (widget.item is Drink) _buildIngredients(context),
              ],
            ),
          ),
          const Expanded(child: SizedBox.shrink()),
          Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    print('order pressed');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(12.5),
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 0.0,
                    ),
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.attach_money,
                          color: Colors.white,
                          size: 35.0,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          'order drink',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(width: 15.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredients(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'ingredients:',
          style: Theme.of(context).textTheme.labelSmall,
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 5.0),
        SizedBox(
          height: 90.0,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (String ingredient in (widget.item as Drink).ingredients)
                  Text(
                    '     • $ingredient',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: (settingsController.isDarkTheme())
                              ? const Color.fromARGB(255, 169, 169, 169)
                              : const Color.fromARGB(255, 64, 64, 64),
                        ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
