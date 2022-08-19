import 'package:flutter/material.dart';
import 'package:kittys_tavern/src/menu/filter/filter_item.dart';

enum FilterType {
  drinks,
  shots,
}

class Filter extends StatefulWidget {
  final FilterType type;

  const Filter({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  _WidgetState createState() => _WidgetState();
}

class _WidgetState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (FilterType type in FilterType.values)
          FilterItem(
            type: type,
            isSelected: type == widget.type,
          ),
      ],
    );
  }
}
