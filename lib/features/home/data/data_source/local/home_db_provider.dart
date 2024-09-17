import 'package:offlineapp/core/helper/log_helper.dart';
import 'package:offlineapp/features/home/data/data_source/local/home_db_service.dart';
import 'package:offlineapp/features/home/data/model/products_model.dart';

class HomeDbProvider {
  final HomeDbService _homeDbService;

  HomeDbProvider({required HomeDbService homeDbService})
      : _homeDbService = homeDbService;

// Reading from db
  Future<ProductsModel?> getProducts() async {
    try {
      return await _homeDbService.getAll();
    } catch (e) {
      // Log or handle error appropriately
      logger.e("Error retrieving categories: $e");
      return null;
    }
  }

  // Insert into db
  Future<void> insertProducts({required ProductsModel object}) async {
    try {
      await _homeDbService.insertItem(object: object);
    } catch (e) {
      // Handle insertion errors
      logger.e("Error inserting Products: $e");
    }
  }

  Future<bool> isProductsAvaialble() async {
    return _homeDbService.isDataAvailable();
  }
}
