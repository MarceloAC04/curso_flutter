enum Complexity {
  Simple,
  Medium,
  Difficult,
}

enum Cost {
  Cheap,
  Fair,
  Expensive,
}

class Meal {

  final String? id;
  final List<String>? categories;
  final String? title;
  final String? imageUrl;
  final List<String>? ingredients;
  final List<String>? steps;
  final int? duration;
  final bool? isGlutenFree;
  final bool? isLactoseFree;
  final bool? isVegan;
  final bool? isVegetarian;
  final Complexity? complexity;
  final Cost? cost;

  const Meal({
    this.id,
    this.categories,
    this.title,
    this.imageUrl,
    this.ingredients,
    this.steps,
    this.duration,
    this.isGlutenFree,
    this.isLactoseFree,
    this.isVegan,
    this.isVegetarian,
    this.complexity,
    this.cost
  });
}