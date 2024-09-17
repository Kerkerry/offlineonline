import 'package:hive/hive.dart';
import 'package:offlineapp/features/home/data/entities/product.dart';
import 'package:offlineapp/features/home/hive_helper/hive_types/hive_types.dart';

part 'product_model.g.dart';

@HiveType(typeId: HiveTypes.productModel)
class ProductModel extends Product {
  ProductModel(
      {required super.id,
      required super.price,
      required super.category,
      required super.updatedAt,
      required super.photoUrl,
      required super.name,
      required super.description,
      required super.createdAt});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      price: json['price']?.toDouble(),
      category: json['category'],
      updatedAt: DateTime.parse(json['updated_at']),
      photoUrl: json['photo_url'],
      name: json['name'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']));
}
