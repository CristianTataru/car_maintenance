import 'dart:io';
import 'package:car_maintenance/feature/add_vehicle/state_service.dart';
import 'package:car_maintenance/main.dart';
import 'package:car_maintenance/models/vehicle.dart';
import 'package:car_maintenance/theme/custom_colors.dart';
import 'package:car_maintenance/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();
  TextEditingController controller6 = TextEditingController();
  TextEditingController controller7 = TextEditingController();
  DateTime? insurance;
  DateTime? inspection;
  DateTime? vignette;
  DateTime? lastService;
  bool? tax;
  File? _image;
  XFile? image;
  String? fuelChoice;
  String? taxChoice;
  int? manufactureYear;
  int? milage;
  double? cc;
  int? hp;
  List<String> fuelChoices = ["Gasoline", "Diesel", "LPG", "Hybrid", "Electric", "Gasoline + LPG", "Diesel + LPG"];
  List<String> taxChoices = ["Yes", "No"];
  static final DateFormat dateFormatter = DateFormat('dd.MM.yyyy');

  @override
  void initState() {
    super.initState();
    controller1.addListener(() {
      setState(() {});
    });
    controller2.addListener(() {});
    controller3.addListener(() {});
    controller4.addListener(() {
      setState(() {});
    });
    controller5.addListener(() {});
    controller6.addListener(() {});
    controller7.addListener(() {});
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();
    controller6.dispose();
    controller7.dispose();
    super.dispose();
  }

  Future getImage(bool isCamera) async {
    if (isCamera) {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    }
    if (image == null) {
      return;
    } else {
      setState(() {
        _image = File(image!.path);
      });
    }
  }

  void selectInsuranceDate() async {
    insurance = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022, 01, 01),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: CustomColors.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      FocusManager.instance.primaryFocus?.unfocus();
      if (insurance == null) {
        return;
      }
      insurance = DateTime(insurance!.year, insurance!.month, insurance!.day);
    });
  }

  void selectInspectionDate() async {
    inspection = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 01, 01),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: CustomColors.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      FocusManager.instance.primaryFocus?.unfocus();
      if (inspection == null) {
        return;
      }
      inspection = DateTime(inspection!.year, inspection!.month, inspection!.day);
    });
  }

  void selectVignetteDate() async {
    vignette = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022, 01, 01),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: CustomColors.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      FocusManager.instance.primaryFocus?.unfocus();
      if (vignette == null) {
        return;
      }
      vignette = DateTime(vignette!.year, vignette!.month, vignette!.day);
    });
  }

  void selectLastServiceDate() async {
    lastService = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 01, 01),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: CustomColors.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      FocusManager.instance.primaryFocus?.unfocus();
      if (lastService == null) {
        return;
      }
      lastService = DateTime(lastService!.year, lastService!.month, lastService!.day);
    });
  }

  bool canPress() {
    if (controller1.text.isEmpty ||
        controller2.text.isEmpty ||
        controller3.text.isEmpty ||
        controller4.text.isEmpty ||
        milage == null ||
        controller5.text.isEmpty ||
        cc == null ||
        controller6.text.isEmpty ||
        hp == null ||
        controller7.text.isEmpty ||
        insurance == null ||
        inspection == null ||
        vignette == null ||
        lastService == null ||
        fuelChoice == null ||
        tax == null ||
        _image == null) {
      return false;
    }
    if (!(manufactureYear != null &&
        (manufactureYear.toString().length == 4 &&
            manufactureYear! > 1990 &&
            manufactureYear! < DateTime.now().year))) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add vehicle"),
          backgroundColor: CustomColors.primaryColor,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                verticalMargin24,
                if (_image == null) ...[
                  Image.asset(
                    "assets/addImage.png",
                    height: 160,
                  ),
                ],
                if (_image != null) ...[
                  Image.file(
                    _image!,
                    height: 160,
                  )
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        getImage(true);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: CustomColors.primaryColor),
                      child: const Text("Take picture"),
                    ),
                    horizontalMargin24,
                    ElevatedButton(
                      onPressed: () {
                        getImage(false);
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: CustomColors.primaryColor),
                      child: const Text("Select image"),
                    ),
                  ],
                ),
                verticalMargin8,
                Visibility(
                    visible: _image == null,
                    child: const Text(
                      "Please take a picture or select an image",
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    )),
                verticalMargin16,
                divider,
                Padding(
                  padding: const EdgeInsets.only(right: 56),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Brand:",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: CustomColors.fontMainColor,
                            ),
                          ),
                          horizontalMargin8,
                          Expanded(
                            child: TypeAheadField(
                              textFieldConfiguration: TextFieldConfiguration(
                                style: const TextStyle(fontSize: 20, color: CustomColors.fontSecondaryColor),
                                cursorColor: CustomColors.primaryColor,
                                controller: controller1,
                                decoration: const InputDecoration(
                                  fillColor: CustomColors.fontSecondaryColor,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: CustomColors.primaryColor),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: CustomColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              noItemsFoundBuilder: (context) => const SizedBox(
                                height: 40,
                                child: Text("No Items Found"),
                              ),
                              suggestionsCallback: (value) {
                                return StateService.getSuggestions(value);
                              },
                              itemBuilder: (context, String suggestion) {
                                return Row(
                                  children: [
                                    verticalMargin8,
                                    const Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: CustomColors.primaryColor,
                                    ),
                                    horizontalMargin8,
                                    Flexible(
                                      child: Text(
                                        suggestion,
                                        maxLines: 1,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    )
                                  ],
                                );
                              },
                              onSuggestionSelected: (String suggestion) {
                                controller1.text = suggestion;
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                            ),
                          )
                        ],
                      ),
                      verticalMargin8,
                      Row(
                        children: [
                          const Text(
                            "Model:",
                            style:
                                TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: CustomColors.fontMainColor),
                          ),
                          horizontalMargin8,
                          Expanded(
                            child: TextField(
                              controller: controller2,
                              cursorColor: CustomColors.primaryColor,
                              decoration: const InputDecoration(
                                fillColor: CustomColors.fontSecondaryColor,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors.primaryColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors.primaryColor),
                                ),
                              ),
                              style: const TextStyle(fontSize: 20, color: CustomColors.fontSecondaryColor),
                            ),
                          )
                        ],
                      ),
                      verticalMargin8,
                      Row(
                        children: [
                          const Text(
                            "License Plate:",
                            style:
                                TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: CustomColors.fontMainColor),
                          ),
                          horizontalMargin8,
                          Expanded(
                            child: TextField(
                              controller: controller3,
                              cursorColor: CustomColors.primaryColor,
                              decoration: const InputDecoration(
                                fillColor: CustomColors.fontSecondaryColor,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors.primaryColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors.primaryColor),
                                ),
                              ),
                              style: const TextStyle(fontSize: 20, color: CustomColors.fontSecondaryColor),
                            ),
                          )
                        ],
                      ),
                      verticalMargin8,
                      Row(
                        children: [
                          const Text(
                            "Manufacture year:",
                            style:
                                TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: CustomColors.fontMainColor),
                          ),
                          horizontalMargin8,
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                manufactureYear = int.tryParse(value);
                                setState(() {});
                              },
                              controller: controller4,
                              cursorColor: CustomColors.primaryColor,
                              decoration: const InputDecoration(
                                fillColor: CustomColors.fontSecondaryColor,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors.primaryColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors.primaryColor),
                                ),
                              ),
                              style: TextStyle(
                                  fontSize: 20,
                                  color: manufactureYear != null &&
                                          (manufactureYear.toString().length == 4 &&
                                              manufactureYear! > 1990 &&
                                              manufactureYear! < DateTime.now().year)
                                      ? CustomColors.fontSecondaryColor
                                      : Colors.red),
                            ),
                          )
                        ],
                      ),
                      verticalMargin8,
                      Row(
                        children: [
                          const Text(
                            "Milage:",
                            style:
                                TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: CustomColors.fontMainColor),
                          ),
                          horizontalMargin8,
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                milage = int.tryParse(value);
                                setState(() {});
                              },
                              controller: controller5,
                              cursorColor: CustomColors.primaryColor,
                              decoration: const InputDecoration(
                                fillColor: CustomColors.fontSecondaryColor,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors.primaryColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors.primaryColor),
                                ),
                              ),
                              style: TextStyle(
                                  fontSize: 20, color: milage != null ? CustomColors.fontSecondaryColor : Colors.red),
                            ),
                          )
                        ],
                      ),
                      verticalMargin8,
                      Row(
                        children: [
                          const Text(
                            "Cylinder capacity:",
                            style:
                                TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: CustomColors.fontMainColor),
                          ),
                          horizontalMargin8,
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                cc = double.tryParse(value);
                                setState(() {});
                              },
                              controller: controller6,
                              cursorColor: CustomColors.primaryColor,
                              decoration: const InputDecoration(
                                fillColor: CustomColors.fontSecondaryColor,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors.primaryColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors.primaryColor),
                                ),
                              ),
                              style: TextStyle(
                                  fontSize: 20, color: cc != null ? CustomColors.fontSecondaryColor : Colors.red),
                            ),
                          )
                        ],
                      ),
                      verticalMargin8,
                      Row(
                        children: [
                          const Text(
                            "Horse power:",
                            style:
                                TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: CustomColors.fontMainColor),
                          ),
                          horizontalMargin8,
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                hp = int.tryParse(value);
                                setState(() {});
                              },
                              controller: controller7,
                              cursorColor: CustomColors.primaryColor,
                              decoration: const InputDecoration(
                                fillColor: CustomColors.fontSecondaryColor,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors.primaryColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: CustomColors.primaryColor),
                                ),
                              ),
                              style: TextStyle(
                                  fontSize: 20, color: hp != null ? CustomColors.fontSecondaryColor : Colors.red),
                            ),
                          )
                        ],
                      ),
                      verticalMargin8,
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Insurance expiry:",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold, color: CustomColors.fontMainColor),
                            ),
                          ),
                          horizontalMargin8,
                          TextButton.icon(
                            icon: const Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: Colors.white,
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: CustomColors.primaryColor,
                            ),
                            onPressed: selectInsuranceDate,
                            label: Text(
                              insurance == null ? "Select Date" : dateFormatter.format(insurance!),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalMargin8,
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Last inspection:",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold, color: CustomColors.fontMainColor),
                            ),
                          ),
                          horizontalMargin8,
                          TextButton.icon(
                            icon: const Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: Colors.white,
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: CustomColors.primaryColor,
                            ),
                            onPressed: selectInspectionDate,
                            label: Text(
                              inspection == null ? "Select Date" : dateFormatter.format(inspection!),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalMargin8,
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Vignette expiry:",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold, color: CustomColors.fontMainColor),
                            ),
                          ),
                          horizontalMargin8,
                          TextButton.icon(
                            icon: const Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: Colors.white,
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: CustomColors.primaryColor,
                            ),
                            onPressed: selectVignetteDate,
                            label: Text(
                              vignette == null ? "Select Date" : dateFormatter.format(vignette!),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalMargin8,
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              "Last service:",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold, color: CustomColors.fontMainColor),
                            ),
                          ),
                          horizontalMargin8,
                          TextButton.icon(
                            icon: const Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: Colors.white,
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: CustomColors.primaryColor,
                            ),
                            onPressed: selectLastServiceDate,
                            label: Text(
                              lastService == null ? "Select Date" : dateFormatter.format(lastService!),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalMargin8,
                      Row(
                        children: [
                          const Text(
                            "Fuel:",
                            style:
                                TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: CustomColors.fontMainColor),
                          ),
                          horizontalMargin8,
                          Expanded(
                              child: DropdownButton<String>(
                            hint: const Text(
                              "Select option",
                              style: TextStyle(color: CustomColors.fontSecondaryColor),
                            ),
                            isExpanded: true,
                            underline: Container(
                              color: CustomColors.primaryColor,
                              height: 1,
                            ),
                            onChanged: (newFuelChoice) {
                              fuelChoice = newFuelChoice;
                              setState(() {});
                            },
                            value: fuelChoice,
                            items: fuelChoices
                                .map((e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Padding(padding: const EdgeInsets.only(left: 8), child: Text(e)),
                                    ))
                                .toList(),
                          ))
                        ],
                      ),
                      verticalMargin8,
                      Row(
                        children: [
                          const Text(
                            "Yearly tax paid:",
                            style:
                                TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: CustomColors.fontMainColor),
                          ),
                          horizontalMargin8,
                          Expanded(
                              child: DropdownButton<String>(
                            hint: const Text(
                              "Select option",
                              style: TextStyle(color: CustomColors.fontSecondaryColor),
                            ),
                            isExpanded: true,
                            underline: Container(
                              color: CustomColors.primaryColor,
                              height: 1,
                            ),
                            onChanged: (newTaxChoice) {
                              taxChoice = newTaxChoice;
                              tax = taxChoice == "Yes" ? true : false;
                              setState(() {});
                            },
                            value: taxChoice,
                            items: taxChoices
                                .map((e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Padding(padding: const EdgeInsets.only(left: 8), child: Text(e)),
                                    ))
                                .toList(),
                          ))
                        ],
                      ),
                      verticalMargin8,
                    ],
                  ),
                ),
                divider,
                verticalMargin16,
                Padding(
                  padding: horizontalPadding104,
                  child: ElevatedButton.icon(
                    onPressed: canPress()
                        ? () {
                            Navigator.of(context).pop();
                            dataList.add(Vehicle(
                                controller3.text,
                                controller1.text,
                                controller2.text,
                                milage!,
                                manufactureYear!,
                                _image!,
                                fuelChoice!,
                                cc!,
                                hp!,
                                insurance!,
                                inspection!,
                                tax!,
                                vignette!,
                                lastService!));
                          }
                        : null,
                    icon: const Icon(Icons.done),
                    label: const Text(
                      "Save vehicle",
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
        )),
      ),
    );
  }
}
