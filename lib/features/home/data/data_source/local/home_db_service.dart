import 'package:hive/hive.dart';
import 'package:offlineapp/config/constants/db_keys.dart';
import 'package:offlineapp/core/helper/log_helper.dart';
import 'package:offlineapp/core/repos/interface_repository.dart';
import 'package:offlineapp/features/home/data/model/product_model.dart';
import 'package:offlineapp/features/home/data/model/products_model.dart';

class HomeDbService implements InterfaceRepository<ProductsModel> {
  // Box key
  static const String _key = DbKeys.dbProducts;

  // Product Box
  late final Box<ProductsModel> _productBox;

  // init DB

  Future<void> initDataBase() async {
    try {
      Hive.registerAdapter(ProductsModelAdapter());
      Hive.registerAdapter(ProductModelAdapter());
      _productBox = await Hive.openBox(_key);
      logger.d("Success on inintializing database for *ProductsModel*");
    } catch (e) {
      // Haindle initialization errors
      logger.e("Error on inintializing database for *ProductsModel*: $e");
    }
  }

  @override
  Future<ProductsModel?> getAll() async {
    try {
      if (_productBox.isOpen && _productBox.isNotEmpty) {
        return _productBox.get(_key);
      } else {
        return null;
      }
    } catch (e) {
      // Handle errors encountered while fetching the data
      logger.e("Error getting all the products: $e");
    }
    return null;
  }

  @override
  Future<void> insertItem({required ProductsModel object}) async {
    try {
      await _productBox.put(_key, object);
    } catch (e) {
      // Handle insertion errors
      logger.e("Error inserting into the database: $e");
    }
  }

  @override
  Future<bool> isDataAvailable() async {
    try {
      return _productBox.isEmpty;
    } catch (e) {
      // Handle error checking box emptiness
      logger.e("Error checking if box is empty: $e");
      return true; //Returns true assuiming it's empty on error
    }
  }
}
