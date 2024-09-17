import 'package:hive/hive.dart';
import 'package:offlineapp/features/home/data/entities/product.dart';
import 'package:offlineapp/features/home/hive_helper/fields/products_model_fields.dart';

class Products extends HiveObject {
  @HiveField(ProductsModelFields.success)
  final bool success;
  @HiveField(ProductsModelFields.totalProducts)
  final int totalProducts;
  @HiveField(ProductsModelFields.message)
  final String message;
  @HiveField(ProductsModelFields.offset)
  final int offset;
  @HiveField(ProductsModelFields.limit)
  final int limit;
  @HiveField(ProductsModelFields.products)
  final List<Product> products;

  Products(
      {required this.success,
      required this.totalProducts,
      required this.message,
      required this.offset,
      required this.limit,
      required this.products});
}
