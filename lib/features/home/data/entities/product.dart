import 'package:hive/hive.dart';
import 'package:offlineapp/features/home/hive_helper/fields/product_model_fields.dart';

class Product extends HiveObject {
  @HiveField(ProductModelFields.id)
  final int id;
  @HiveField(ProductModelFields.price)
  final double price;
  @HiveField(ProductModelFields.category)
  final String category;
  @HiveField(ProductModelFields.updatedAt)
  final DateTime updatedAt;
  @HiveField(ProductModelFields.photoUrl)
  final String photoUrl;
  @HiveField(ProductModelFields.name)
  final String name;
  @HiveField(ProductModelFields.description)
  final String description;
  @HiveField(ProductModelFields.createdAt)
  final DateTime createdAt;

  Product(
      {required this.id,
      required this.price,
      required this.category,
      required this.updatedAt,
      required this.photoUrl,
      required this.name,
      required this.description,
      required this.createdAt});
}
