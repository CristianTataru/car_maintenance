import 'dart:io';

class Vehicle {
  final String licensePlate;
  final String brand;
  final String model;
  int milage;
  final int fabricationYear;
  File image;
  final String fuel;
  final double cc;
  final int horsePower;
  DateTime insurance;
  DateTime inspection;
  bool tax;
  DateTime vignette;
  DateTime lastService;

  Vehicle(this.licensePlate, this.brand, this.model, this.milage, this.fabricationYear, this.image, this.fuel, this.cc,
      this.horsePower, this.insurance, this.inspection, this.tax, this.vignette, this.lastService);

  Vehicle.fromJson(Map<String, dynamic> json)
      : licensePlate = json['licensePlate'],
        brand = json['brand'],
        model = json['model'],
        milage = json['milage'],
        fabricationYear = json['fabricationYear'],
        image = json['image'],
        fuel = json['fuel'],
        cc = json['cc'],
        horsePower = json['horsePower'],
        insurance = DateTime.parse(json['insurance']),
        inspection = DateTime.parse(json['inspection']),
        tax = json['tax'],
        vignette = DateTime.parse(json['vignette']),
        lastService = DateTime.parse(json['lastService']);

  Map<String, dynamic> toJson() => {
        'licensePlate': licensePlate,
        'brand': brand,
        'model': model,
        'milage': milage,
        'fabricationYear': fabricationYear,
        'image': image,
        'fuel': fuel,
        'cc': cc,
        'horsePower': horsePower,
        'insurance': insurance.toString(),
        'inspection': inspection.toString(),
        'tax': tax,
        'vignette': vignette.toString(),
        'lastService': lastService.toString()
      };
}
