import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:offlineapp/features/home/data/entities/product.dart';
import 'package:offlineapp/core/utils/custom_image_viewer.dart';

class HomeSingleListItem extends StatelessWidget {
  const HomeSingleListItem({super.key, required this.current});

  final Product current;

  @override
  Widget build(BuildContext context) {
    String createdAt = formatDateString(current.createdAt.toString());
    String updatedAt = formatDateString(current.updatedAt.toString());

    Size size;
    double height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final ThemeData theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: height * 0.007,
        horizontal: height * 0.01,
      ),
      height: height * 0.2,
      decoration: BoxDecoration(
        color: theme.dialogBackgroundColor,
        borderRadius: BorderRadius.circular(height * 0.02),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(height * 0.02),
        elevation: 1,
        child: Row(
          children: [
            Container(
              width: width * 0.42,
              decoration: BoxDecoration(
                  color: theme.dialogBackgroundColor,
                  borderRadius: BorderRadius.circular(12)),
              child: CustomImageViewer.show(
                  context: context, url: current.photoUrl),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      current.name,
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      current.description,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.unselectedWidgetColor,
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Created ",
                            style: theme.textTheme.labelMedium,
                          ),
                          Text(
                            createdAt,
                            style: theme.textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: width * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Last update ",
                            style: theme.textTheme.labelMedium,
                          ),
                          Text(
                            updatedAt,
                            style: theme.textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 10),
                          child: Text(
                            current.category.toUpperCase(),
                            style: theme.textTheme.labelLarge!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "\$${current.price}",
                        style: theme.textTheme.labelLarge,
                      ),
                    ],
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  String formatDateString(String dateString) {
    // Parse the string into a DateTime object
    DateTime dateTime = DateTime.parse(dateString);
    // Format the DateTime object as desired
    String formatedDateTime = DateFormat('MMMMM d, y').format(dateTime);
    return formatedDateTime;
  }
}
