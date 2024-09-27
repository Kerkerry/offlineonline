import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offlineapp/core/dependency_injection.dart/di.dart';
import 'package:offlineapp/core/dependency_injection.dart/di_ex.dart';
import 'package:offlineapp/core/pages/error_page.dart';
import 'package:offlineapp/features/home/data/entities/product.dart';
import 'package:offlineapp/features/home/data/model/products_model.dart';
import 'package:offlineapp/features/home/presentation/bloc/home_status.dart';
import 'package:offlineapp/features/home/presentation/widgets/bnb.dart';
import 'package:offlineapp/core/utils/custom_alert.dart';
import 'package:offlineapp/core/utils/custom_loading_widget.dart';
import 'package:offlineapp/features/home/presentation/widgets/home_single_list_item.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size;
    double height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text("Catching Data with Bloc & Hive"),
            Text(
              "Programming with Gurus",
              style: theme.textTheme.labelMedium!.copyWith(color: Colors.grey),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: BlocConsumer<HomeBloc, HomeState>(
          buildWhen: (previous, current) =>
              previous.homeProductsStatus != current.homeProductsStatus,
          listenWhen: (previous, current) =>
              previous.homeProductsStatus != current.homeProductsStatus,
          builder: (context, HomeState state) {
            // Init state status
            if (state.homeProductsStatus is HomeProductsStatusInit) {
              return Container();
            }
            // Loading state status
            if (state.homeProductsStatus is HomeProductsStatusLoading) {
              return CustomLoading.show(context);
            }
            // Error state status
            if (state.homeProductsStatus is HomeProductsStatusError) {
              final HomeProductsStatusError emPost =
                  state.homeProductsStatus as HomeProductsStatusError;
              final String errMsg = emPost.errorMsg;
              return CommonErrorPage(
                isForNetwork: true,
                description: errMsg,
                onRetry: () {
                  context.read<HomeBloc>().add(const HomeCallProductsEvent());
                },
              );
            }

            // Completed state status
            if (state.homeProductsStatus is HomeProductsStatusComplete) {
              final HomeProductsStatusComplete emPost =
                  state.homeProductsStatus as HomeProductsStatusComplete;
              final ProductsModel productsModel = emPost.products;
              return LiquidPullToRefresh(
                backgroundColor: theme.scaffoldBackgroundColor,
                color: theme.primaryColor,
                showChildOpacityTransition: true,
                onRefresh: () async {
                  // Without extension
                  BlocProvider.of<HomeBloc>(context)
                      .add(const HomeCallProductsEvent());
                  // With extension
                  // context.read<HomeBloc>().add(const HomeCallProductsEvent());
                },
                child: ListView.builder(
                    itemCount: emPost.products.products.length,
                    itemBuilder: (context, index) {
                      final Product product = productsModel.products[index];
                      return HomeSingleListItem(current: product);
                    }),
              );
            }

            return Container();
          },
          listener: (BuildContext context, HomeState state) async {
            if (state.homeProductsStatus is HomeProductsStatusComplete) {
              final HomeProductsStatusComplete cmProducts =
                  state.homeProductsStatus as HomeProductsStatusComplete;

              final ProductsModel productsModel = cmProducts.products;

              final bool isConnected = await di<InternetConnectionHelper>()
                  .checkInternetConnection();

              final String msg =
                  isConnected ? "From server 🌐" : "From local source 📄";
              // ignore: use_build_context_synchronously
              context.mounted
                  ? CustomAlert.show(context, productsModel.message + msg)
                  : null;
            }
          },
        ),
      ),
      bottomNavigationBar: const BNB(),
    );
  }
}
