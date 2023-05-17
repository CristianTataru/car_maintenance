import 'package:car_maintenance/main.dart';
import 'package:car_maintenance/models/vehicle.dart';
import 'package:car_maintenance/theme/custom_colors.dart';
import 'package:flutter/material.dart';

class DeleteVehicleDialog extends StatelessWidget {
  final Function callback;
  final Vehicle vehicle;
  const DeleteVehicleDialog(this.callback, this.vehicle, {super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Delete vehicle",
        style: TextStyle(color: CustomColors.fontMainColor),
      ),
      content: const Text("Are you sure you want to delete the vehicle?",
          style: TextStyle(color: CustomColors.fontMainColor)),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            dataList.remove(vehicle);
            callback();
          },
          child: const Text(
            "Confirm",
            style: TextStyle(color: CustomColors.primaryColor),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: CustomColors.primaryColor),
          ),
        )
      ],
    );
  }
}
