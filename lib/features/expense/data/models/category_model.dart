import '../../../../utils/index.dart';

final List<CategoryModel> categoriesList = [
  CategoryModel(
    name: 'Groceries',
    icons: Icons.shopping_cart,
    color: Colors.blue,
  ),
  CategoryModel(
    name: 'Entertainment',
    icons: Icons.movie,
    color: Colors.orange,
  ),
  CategoryModel(name: 'Gas', icons: Icons.local_gas_station, color: Colors.red),
  CategoryModel(
    name: 'Shopping',
    icons: Icons.shopping_bag,
    color: Colors.pink,
  ),

  CategoryModel(
    name: 'News Paper',
    icons: Icons.newspaper,
    color: Colors.brown,
  ),
  CategoryModel(
    name: 'Transport',
    icons: Icons.directions_car,
    color: Colors.purple,
  ),

  CategoryModel(name: 'Rent', icons: Icons.home, color: Colors.green),
];

class CategoryModel {
  String name;
  IconData icons;
  Color color;

  CategoryModel({required this.name, required this.color, required this.icons});
}
