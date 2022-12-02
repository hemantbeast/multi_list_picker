class ItemModel {
  ItemModel({
    required this.index,
    this.name,
  });

  int index;
  String? name;

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'name': name,
    };
  }
}
