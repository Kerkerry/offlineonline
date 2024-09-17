import 'package:hive/hive.dart';
import 'package:offlineapp/features/home/data/entities/product.dart';
import 'package:offlineapp/features/home/data/entities/products.dart';
import 'package:offlineapp/features/home/data/model/product_model.dart';
import 'package:offlineapp/features/home/hive_helper/hive_types/hive_types.dart';
part 'products_model.g.dart';

@HiveType(typeId: HiveTypes.productsModel)
class ProductsModel extends Products {
  ProductsModel(
      {required super.success,
      required super.totalProducts,
      required super.message,
      required super.offset,
      required super.limit,
      required super.products});

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
      success: json['success'],
      totalProducts: json['total_products'],
      message: json['message'],
      offset: json['offset'],
      limit: json['limit'],
      products: List<Product>.from(
          json['products'].map((x) => ProductModel.fromJson(x))));
}
