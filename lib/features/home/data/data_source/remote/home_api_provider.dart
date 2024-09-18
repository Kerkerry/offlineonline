import 'package:dio/dio.dart';
import 'package:offlineapp/config/constants/api_constants.dart';
import 'package:offlineapp/core/helper/log_helper.dart';

class HomeApiProvider {
  final Dio dio;
  HomeApiProvider(this.dio);

  // Call home page products data
  dynamic callHomeProductsEndpoint() async {
    // request url
    final requestUrl = EnvironmentVariables.getProduct;

    final response = await dio
        .request(
      requestUrl,
      options: Options(method: "GET"),
    )
        .onError(
      (DioException error, stackTrace) {
        logger.e(error);
        throw error;
      },
    );
    // response after the call is successful
    return response;
  }
}
