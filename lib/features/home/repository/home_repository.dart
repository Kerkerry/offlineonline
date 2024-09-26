import 'package:dio/dio.dart';
import 'package:offlineapp/core/dependency_injection.dart/di.dart';
import 'package:offlineapp/core/helper/connection_helper.dart';
import 'package:offlineapp/core/helper/log_helper.dart';
import 'package:offlineapp/core/resources/data_state.dart';
import 'package:offlineapp/features/home/data/data_source/local/home_db_provider.dart';
import 'package:offlineapp/features/home/data/data_source/remote/home_api_provider.dart';
import 'package:offlineapp/features/home/data/model/products_model.dart';

class HomeRepository {
  // Remote source
  final HomeApiProvider _apiProvider;

  // Local source
  final HomeDbProvider _dbProvider;

  HomeRepository(
      {required HomeApiProvider apiProvider,
      required HomeDbProvider dbProvider})
      : _apiProvider = apiProvider,
        _dbProvider = dbProvider;

  // Get Products for Home
  Future<DataState<dynamic>> fetchProducts() async {
    // Check the connnection
    final bool isConnected =
        await di<InternetConnectionHelper>().checkInternetConnection();
    // logger.d("Internet connection is: $isConnected");
    // Is database empty or not
    final bool isDatabaseEmpty = await _dbProvider.isProductsAvaialble();
    if (isConnected) {
      try {
        final Response response = await _apiProvider.callHomeProductsEndpoint();
        logger.d(
            "Fetcth [Products] from the server and cache it in the local database");
        // Success connection is OKAY!
        if (response.statusCode == 200 &&
            response.data['success'] == true &&
            (response.data['products'] as List).isNotEmpty) {
          ProductsModel productsModel = ProductsModel.fromJson(response.data);
          _dbProvider.insertProducts(object: productsModel);
          final ProductsModel? cachedProducts = await _dbProvider.getProducts();
          // Send it to the state management class as success response
          return DataSuccess(cachedProducts);
        } else {
          // Failed connection results to an Error!
          if (isDatabaseEmpty) {
            logger.d("Load [Products] from local Database");
            final ProductsModel? localSourceResponse =
                await _dbProvider.getProducts();
            return DataSuccess(localSourceResponse);
          }
          // There is no data Cached!
          // Failed
          return DataFailed("Unkown Error Happened!");
        }
      } catch (e) {
        if (!isDatabaseEmpty) {
          logger.d("Load [Products] from local Database");
          final ProductsModel? localSourceResponse =
              await _dbProvider.getProducts();
          return DataSuccess(localSourceResponse);
        } else {
          return DataFailed("Unexpected error! occured");
        }
      }
    } else {
      // User internet connection s not stable- No internet connection
      if (!isDatabaseEmpty) {
        logger.d("Load [Products] from local Database");
        final ProductsModel? localSourceResponse =
            await _dbProvider.getProducts();
        return DataSuccess(localSourceResponse);
      } else {
        // Error
        return DataFailed("No Network Connection!");
      }
    }
  }
}
