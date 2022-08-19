import 'package:flutter/material.dart';
import 'package:kittys_tavern/main.dart';
import 'package:kittys_tavern/src/menu/filter/filter.dart';
import 'package:kittys_tavern/src/menu/menu_view.dart';
import 'package:themed/themed.dart';

class FilterItem extends StatefulWidget {
  final FilterType type;
  final bool isSelected;

  const FilterItem({
    Key? key,
    required this.type,
    required this.isSelected,
  }) : super(key: key);

  @override
  _WidgetState createState() => _WidgetState();
}

class _WidgetState extends State<FilterItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MenuView.of(context).setMenuType(widget.type);
      },
      child: Container(
        width: 150.0,
        margin: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
          color: (widget.isSelected)
              ? (settingsController.isDarkTheme())
                  ? const Color.fromARGB(15, 255, 255, 255)
                  : const Color.fromARGB(5, 0, 0, 0)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
          border: (widget.isSelected)
              ? Border.all(
                  color: const Color.fromARGB(55, 255, 12, 235),
                  width: 1.5,
                )
              : null,
        ),
        child: ChangeColors(
          saturation: (!widget.isSelected) ? -0.8 : 0.0,
          child: Image.asset(
            _imagePath(),
            height: 75.0,
          ),
        ),
      ),
    );
  }

  String _imagePath() {
    String retval;

    switch (widget.type) {
      case FilterType.drinks:
        retval = 'assets/images/drink_menu.png';
        break;

      case FilterType.shots:
        retval = 'assets/images/shots_menu.png';
        break;
    }

    return retval;
  }
}
