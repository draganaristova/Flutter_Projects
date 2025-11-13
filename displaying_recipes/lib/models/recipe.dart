class Recipe{
  int id;
  String img;
  String name;
  String instructions;
  List<String> ingredients;
  String youtube;

  Recipe({
    required this.id,
    required this.img,
    required this.name,
    required this.instructions,
    required this.ingredients,
    required this.youtube,
  });

 factory Recipe.fromJson(Map<String, dynamic> data){
   final id = int.parse(data['idMeal']);
   final img = data['strMealThumb'];
   final name = data['strMeal'];
   final instructions = data['strInstructions'];
   final youtube = data['strYoutube'];


   final List<String> ingredients = [];
   for (var i=1; i<=20; i++){
     final ing = data['strIngredient$i'];
     if (ing != null && ing.toString().trim().isNotEmpty) {
       ingredients.add(ing.toString().trim());
     }
   }

   return Recipe(
     id: id,
     img: img,
     name: name,
     instructions: instructions,
     ingredients: ingredients,
     youtube: youtube,
   );
 }



  Map<String, dynamic> toJson() => {
    'id':id,
    'name':name,
    'img':img,
    'instructions':instructions,
    'ingredients': ingredients,
    'youtube': youtube,
  };
}