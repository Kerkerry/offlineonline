import 'package:flutter/material.dart';
import 'package:offlineapp/features/home/data/model/products_model.dart';

@immutable
abstract class HomeProductsStatus {}

class HomeProductsStatusInit extends HomeProductsStatus {}

class HomeProductsStatusLoading extends HomeProductsStatus {}

class HomeProductsStatusError extends HomeProductsStatus {
  final String errorMsg;

  HomeProductsStatusError({required this.errorMsg});
}

class HomeProductsStatusComplete extends HomeProductsStatus {
  final ProductsModel products;

  HomeProductsStatusComplete({required this.products});
}
