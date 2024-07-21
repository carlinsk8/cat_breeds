import '../../domain/entities/info_device.dart';

class InfoDeviceModel extends InfoDevice {
  const InfoDeviceModel({
    required super.appName, 
    required super.appId, 
    required super.versionName, 
    required super.brand, 
    required super.model, 
    required super.android, 
    required super.locale
  });

  factory InfoDeviceModel.fromJson(Map<dynamic, dynamic> json) {
    return InfoDeviceModel(
      appName: json['appName'],
      appId: json['appId'],
      versionName: json['versionName'],
      brand: json['brand'],
      model: json['model'],
      android: json['android'],
      locale: json['locale'],
    );
  }

}