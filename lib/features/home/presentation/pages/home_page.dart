import 'package:flutter/material.dart';

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
      ),
    );
  }
}
