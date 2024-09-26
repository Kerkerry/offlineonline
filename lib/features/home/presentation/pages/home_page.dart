import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offlineapp/core/dependency_injection.dart/di_ex.dart';
import 'package:offlineapp/features/home/presentation/bloc/home_status.dart';
import 'package:offlineapp/features/home/presentation/widgets/custom_loading_widget.dart';

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
              return Center(
                child: Text(
                  errMsg,
                ),
              );
            }

            // Completed state status
            if (state.homeProductsStatus is HomeProductsStatusComplete) {
              final HomeProductsStatusComplete emPost =
                  state.homeProductsStatus as HomeProductsStatusComplete;
              final productsModel = emPost.products;
              return Center(
                child: Text(
                  productsModel.message.toString(),
                ),
              );
            }

            return Container();
          },
          listener: (context, state) {},
        ),
      ),
    );
  }
}
