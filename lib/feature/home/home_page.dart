import 'package:car_maintenance/feature/add_vehicle/add_vehicle_page.dart';
import 'package:car_maintenance/feature/home/delete_vehicle_dialog.dart';
import 'package:car_maintenance/main.dart';
import 'package:car_maintenance/models/vehicle.dart';
import 'package:car_maintenance/theme/custom_colors.dart';
import 'package:car_maintenance/feature/vehicle/vehicle_page.dart';
import 'package:car_maintenance/widgets/common.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Vehicles"),
        backgroundColor: CustomColors.primaryColor,
      ),
      body: Theme(
        data: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: CustomColors.primaryColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                verticalMargin16,
                const Text(
                  "Hello, Cristian!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, color: CustomColors.fontMainColor),
                ),
                verticalMargin16,
                const Text(
                  "My Vehicles",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: CustomColors.fontMainColor),
                ),
                verticalMargin8,
                Container(color: CustomColors.primaryColor, height: 1),
                Visibility(
                  visible: dataList.isEmpty,
                  child: const Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Your vehicles will appear here",
                        style: TextStyle(color: CustomColors.fontSecondaryColor, fontSize: 40),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: dataList.isNotEmpty,
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...dataList.map((e) => ShowVehicle(() {
                                setState(() {});
                              }, e))
                        ],
                      ),
                    ),
                  ),
                ),
                Container(color: CustomColors.primaryColor, height: 1),
                verticalMargin16,
                Padding(
                  padding: horizontalPadding104,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return const AddVehiclePage();
                      }));
                      setState(() {});
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(
                      "Add vehicle",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CustomColors.primaryColor,
                    ),
                  ),
                ),
                verticalMargin16
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowVehicle extends StatefulWidget {
  final Function callback;
  final Vehicle vehicle;
  const ShowVehicle(this.callback, this.vehicle, {super.key});

  @override
  State<ShowVehicle> createState() => _ShowVehicleState();
}

class _ShowVehicleState extends State<ShowVehicle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: verticalPadding24,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return VehiclePage(vehicle: widget.vehicle);
          }));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: CustomColors.fontSecondaryColor),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            boxShadow: [
              BoxShadow(
                color: CustomColors.fontSecondaryColor.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 7,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          height: 180,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.file(
                  widget.vehicle.image,
                  width: 180,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.vehicle.brand} ${widget.vehicle.model}",
                      style:
                          const TextStyle(color: CustomColors.fontMainColor, fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    verticalMargin8,
                    Text(
                      widget.vehicle.licensePlate,
                      style: const TextStyle(color: CustomColors.fontSecondaryColor, fontSize: 20),
                    ),
                    verticalMargin16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        statusIcon(widget.vehicle),
                        horizontalMargin8,
                        Expanded(child: statusText(widget.vehicle)),
                        IconButton(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return DeleteVehicleDialog(widget.callback, widget.vehicle);
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: CustomColors.primaryColor,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_right_outlined,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Icon statusIcon(Vehicle vehicle) {
  List<DateTime> documentsDates = [vehicle.inspection, vehicle.insurance, vehicle.vignette];
  if (vehicle.tax) {
    for (int i = 0; i < documentsDates.length; i++) {
      if (documentsDates[i].isBefore(DateTime.now())) {
        return const Icon(
          Icons.close,
          color: Colors.red,
        );
      }
    }
    for (int i = 0; i < documentsDates.length; i++) {
      if (documentsDates[i].isAfter(DateTime.now()) &&
          documentsDates[i].isBefore(DateTime.now().add(const Duration(days: 30)))) {
        return const Icon(
          Icons.warning_amber,
          color: Colors.orange,
        );
      }
    }
    return const Icon(
      Icons.check_circle_outline,
      color: Colors.green,
    );
  }
  return const Icon(
    Icons.close,
    color: Colors.red,
  );
}

Text statusText(Vehicle vehicle) {
  List<DateTime> documentsDates = [vehicle.inspection, vehicle.insurance, vehicle.vignette];
  if (vehicle.tax) {
    for (int i = 0; i < documentsDates.length; i++) {
      if (documentsDates[i].isBefore(DateTime.now())) {
        return const Text(
          "Urgent action required!",
          style: TextStyle(color: Colors.red, fontSize: 20),
        );
      }
    }
    for (int i = 0; i < documentsDates.length; i++) {
      if (documentsDates[i].isAfter(DateTime.now()) &&
          documentsDates[i].isBefore(DateTime.now().add(const Duration(days: 30)))) {
        return const Text(
          "Attention required!",
          style: TextStyle(
            color: Colors.orange,
            fontSize: 20,
          ),
          textAlign: TextAlign.justify,
        );
      }
    }
    return const Text(
      "Let's ride!",
      style: TextStyle(color: Colors.green, fontSize: 20),
    );
  }
  return const Text(
    "Urgent action required!",
    style: TextStyle(color: Colors.red, fontSize: 20),
  );
}
