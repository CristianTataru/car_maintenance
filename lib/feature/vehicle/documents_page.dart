import 'package:car_maintenance/models/vehicle.dart';
import 'package:car_maintenance/theme/custom_colors.dart';
import 'package:car_maintenance/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DocumentsPage extends StatelessWidget {
  final Vehicle vehicle;
  const DocumentsPage({required this.vehicle, super.key});

  Icon checkDate(DateTime dateToCheck) {
    if (dateToCheck.isBefore(DateTime.now())) {
      return const Icon(
        Icons.close,
        color: Colors.red,
      );
    }
    if (dateToCheck.isAfter(DateTime.now()) && dateToCheck.isBefore(DateTime.now().add(const Duration(days: 30)))) {
      return const Icon(
        Icons.warning_amber,
        color: Colors.orange,
      );
    }
    return const Icon(
      Icons.check_circle_outline,
      color: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatter = DateFormat('dd.MM.yyyy');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Documents"),
        backgroundColor: CustomColors.primaryColor,
        leading: BackButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            verticalMargin48,
            Text(
              "${vehicle.brand} ${vehicle.model}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: CustomColors.fontMainColor,
              ),
            ),
            verticalMargin8,
            Text(
              "${vehicle.licensePlate} | Documents",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                color: CustomColors.fontSecondaryColor,
              ),
            ),
            verticalMargin40,
            Image.file(
              vehicle.image,
              height: 150,
            ),
            verticalMargin32,
            Padding(
              padding: horizontalPadding8,
              child: Column(
                children: [
                  divider,
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Insurance:",
                            style: TextStyle(
                              color: CustomColors.fontMainColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            dateFormatter.format(vehicle.insurance),
                            style: const TextStyle(color: CustomColors.fontSecondaryColor, fontSize: 20),
                          )
                        ],
                      ),
                      const Spacer(),
                      checkDate(vehicle.insurance)
                    ],
                  ),
                  divider,
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Periodic Inspection:",
                            style: TextStyle(
                              color: CustomColors.fontMainColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            dateFormatter.format(vehicle.inspection),
                            style: const TextStyle(color: CustomColors.fontSecondaryColor, fontSize: 20),
                          ),
                        ],
                      ),
                      const Spacer(),
                      checkDate(vehicle.inspection),
                    ],
                  ),
                  divider,
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Tax:",
                            style: TextStyle(
                              color: CustomColors.fontMainColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            vehicle.tax ? "Paid" : "Not Paid",
                            style: const TextStyle(color: CustomColors.fontSecondaryColor, fontSize: 20),
                          )
                        ],
                      ),
                      const Spacer(),
                      vehicle.tax
                          ? const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.close,
                              color: Colors.red,
                            )
                    ],
                  ),
                  divider,
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Vignette:",
                            style: TextStyle(
                              color: CustomColors.fontMainColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            dateFormatter.format(vehicle.vignette),
                            style: const TextStyle(color: CustomColors.fontSecondaryColor, fontSize: 20),
                          )
                        ],
                      ),
                      const Spacer(),
                      checkDate(vehicle.vignette)
                    ],
                  ),
                  divider
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
