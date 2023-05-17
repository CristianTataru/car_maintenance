import 'package:car_maintenance/feature/vehicle/documents_page.dart';
import 'package:car_maintenance/models/vehicle.dart';
import 'package:car_maintenance/theme/custom_colors.dart';

import 'package:car_maintenance/widgets/common.dart';
import 'package:car_maintenance/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VehiclePage extends StatelessWidget {
  final Vehicle vehicle;
  const VehiclePage({required this.vehicle, super.key});

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatter = DateFormat('dd.MM.yyyy');
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: CustomBackButton(),
            ),
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
              vehicle.licensePlate,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                color: CustomColors.fontSecondaryColor,
              ),
            ),
            verticalMargin48,
            Image.file(
              vehicle.image,
              height: 150,
            ),
            verticalMargin32,
            Padding(
              padding: horizontalPadding16,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return DocumentsPage(vehicle: vehicle);
                          },
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: documentsColor(vehicle),
                        border: Border.all(
                          color: CustomColors.fontSecondaryColor,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      height: 100,
                      width: 160,
                      child: Row(
                        children: [
                          horizontalMargin8,
                          Image.asset(
                            'assets/documents.png',
                            width: 60,
                            color: CustomColors.primaryColor,
                          ),
                          horizontalMargin8,
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "Docs",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: CustomColors.fontMainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                verticalMargin16,
                                Text(
                                  "Documents",
                                  style: TextStyle(
                                    color: CustomColors.fontSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_right_outlined)
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: CustomColors.fontSecondaryColor,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    height: 100,
                    width: 160,
                    child: Row(
                      children: [
                        horizontalMargin8,
                        Image.asset(
                          'assets/calendar.png',
                          width: 60,
                          color: CustomColors.primaryColor,
                        ),
                        horizontalMargin8,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Fab. year",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: CustomColors.fontMainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              verticalMargin16,
                              Text(
                                "${vehicle.fabricationYear}",
                                style: const TextStyle(
                                  color: CustomColors.fontSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            verticalMargin16,
            Padding(
              padding: horizontalPadding16,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: CustomColors.fontSecondaryColor,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    height: 100,
                    width: 160,
                    child: Row(
                      children: [
                        horizontalMargin8,
                        Image.asset(
                          'assets/fuel.png',
                          width: 60,
                          color: CustomColors.primaryColor,
                        ),
                        horizontalMargin8,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Fuel",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: CustomColors.fontMainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              verticalMargin16,
                              Text(
                                vehicle.fuel,
                                style: const TextStyle(
                                  color: CustomColors.fontSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: CustomColors.fontSecondaryColor,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    height: 100,
                    width: 160,
                    child: Row(
                      children: [
                        horizontalMargin8,
                        Image.asset(
                          'assets/engine.png',
                          width: 60,
                          color: CustomColors.primaryColor,
                        ),
                        horizontalMargin8,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Engine",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: CustomColors.fontMainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              verticalMargin16,
                              Text(
                                "${vehicle.cc} c.c.",
                                style: const TextStyle(
                                  color: CustomColors.fontSecondaryColor,
                                ),
                              ),
                              Text(
                                "${vehicle.horsePower} h.p.",
                                style: const TextStyle(
                                  color: CustomColors.fontSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            verticalMargin16,
            Padding(
              padding: horizontalPadding16,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: nextServiceColor(vehicle.lastService.add(const Duration(days: 365))),
                      border: Border.all(
                        color: CustomColors.fontSecondaryColor,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    height: 100,
                    width: 160,
                    child: Row(
                      children: [
                        horizontalMargin8,
                        Image.asset(
                          'assets/maintenance.png',
                          width: 60,
                          color: CustomColors.primaryColor,
                        ),
                        horizontalMargin8,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Next",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: CustomColors.fontMainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                "service",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: CustomColors.fontMainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              verticalMargin16,
                              Text(
                                dateFormatter.format(vehicle.lastService.add(const Duration(days: 365))),
                                style: const TextStyle(
                                  color: CustomColors.fontSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: CustomColors.fontSecondaryColor,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    height: 100,
                    width: 160,
                    child: Row(
                      children: [
                        horizontalMargin8,
                        Image.asset(
                          'assets/milage.png',
                          width: 60,
                          color: CustomColors.primaryColor,
                        ),
                        horizontalMargin8,
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Milage",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: CustomColors.fontMainColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              verticalMargin16,
                              Text(
                                "${vehicle.milage}",
                                style: const TextStyle(
                                  color: CustomColors.fontSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            verticalMargin24,
            Padding(
              padding: horizontalPadding104,
              child: TextButton.icon(
                style: TextButton.styleFrom(backgroundColor: CustomColors.primaryColor),
                onPressed: () {},
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                label: const Text(
                  "Edit info",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Color nextServiceColor(DateTime dateToCheck) {
  if (dateToCheck.isAfter(DateTime.now())) {
    return Colors.white;
  }
  return Colors.orange[200]!;
}

Color documentsColor(Vehicle vehicle) {
  List<DateTime> documentsDates = [vehicle.inspection, vehicle.insurance, vehicle.vignette];
  if (vehicle.tax) {
    for (int i = 0; i < documentsDates.length; i++) {
      if (documentsDates[i].isBefore(DateTime.now())) {
        return Colors.red[200]!;
      }
    }
    for (int i = 0; i < documentsDates.length; i++) {
      if (documentsDates[i].isAfter(DateTime.now()) &&
          documentsDates[i].isBefore(DateTime.now().add(const Duration(days: 30)))) {
        return Colors.orange[200]!;
      }
    }
    return Colors.white;
  }
  return Colors.red[200]!;
}
