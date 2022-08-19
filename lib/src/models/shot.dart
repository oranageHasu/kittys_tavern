import 'package:kittys_tavern/src/models/bar_item.dart';

enum AlcoholType {
  whisky,
  vodka,
  gin,
  rum,
  tequila,
}

class Shot extends BarItem {
  final AlcoholType type;

  const Shot({
    required int id,
    required String imgPath,
    required String name,
    required this.type,
  }) : super(
          id: id,
          imgPath: imgPath,
          name: name,
        );

  factory Shot.fromJson(Map<String, dynamic> json) {
    Shot shot = Shot(
      id: json['id'],
      imgPath: json['imgPath'],
      name: json['name'],
      type: AlcoholType.values[json['type']],
    );

    return shot;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imgPath': imgPath,
      'name': name,
      'type': type.index,
    };
  }
}
