class Category{
  int id;
  String name;
  String img;
  String description;

  Category({required this.id, required this.name, required this.img, required this.description});


  factory Category.fromJson(Map<String, dynamic> data) {
    return Category(
      id: int.parse(data['idCategory']),
      name: data['strCategory'],
      img: data['strCategoryThumb'],
      description: data['strCategoryDescription'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'img': img,
    'description': description,
  };
}