abstract class BarItem {
  final int id;
  final String imgPath;
  final String name;

  const BarItem({
    required this.id,
    required this.imgPath,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imgPath': imgPath,
      'name': name,
    };
  }
}
