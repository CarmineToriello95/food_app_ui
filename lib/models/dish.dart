class Dish {
  String name;
  String shortDescription;
  String imagePath;
  String price;
  String description;

  Dish(
      {this.name,
      this.shortDescription,
      this.imagePath,
      this.price,
      this.description});
}

class DishesGenerator {
  static List<Dish> dishes = [
    Dish(
        name: 'Grilled beef',
        shortDescription: 'Peruvian food',
        imagePath: 'assets/images/peruvian_grilled_beef.jpg',
        price: '\$ 10.00',
        description: 'Grilled beaf steak and potatoes on plate isolated'),
    Dish(
        name: 'Caesar salad',
        shortDescription: '',
        imagePath: 'assets/images/chicken_caesar_salad.jpg',
        price: '\$ 8.00',
        description: 'Green salad of romaine lettuce and croutons with chicken'),
  ];
}
