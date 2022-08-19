import 'package:kittys_tavern/src/models/bar_item.dart';

class Drink extends BarItem {
  final String desc;
  final List<String> ingredients;

  const Drink({
    required int id,
    required String imgPath,
    required String name,
    required this.desc,
    required this.ingredients,
  }) : super(
          id: id,
          imgPath: imgPath,
          name: name,
        );

  factory Drink.fromJson(Map<String, dynamic> json) {
    Drink drink = Drink(
      id: json['id'],
      imgPath: json['imgPath'],
      name: json['name'],
      desc: json['desc'],
      ingredients: json['ingredients'],
    );

    return drink;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imgPath': imgPath,
      'name': name,
      'desc': desc,
      'ingredients': ingredients,
    };
  }
}
