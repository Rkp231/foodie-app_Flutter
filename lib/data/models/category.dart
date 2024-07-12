class Category {
  int id;
  String name;
  String photo;
  String colour;

  Category({
    this.id,
    this.name,
    this.photo,
    this.colour,
  });

  factory Category.fromJSON(dynamic jsonObject) {
    final category = Category(
      id: jsonObject['id'],
      name: jsonObject['name'],
      photo: jsonObject['image'] ?? "",
      colour: "${jsonObject['colour'].toString()}",
    );
    return category;
  }
}
