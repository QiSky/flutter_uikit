import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoUtil {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  static const String PACKAGE_NAME = "packageName";

  static const String PACKAGE_VERSION = "packageVersion";

  static const String DEVICE_INFO = "deviceInfo";

  Future<Map?> readDeviceInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final Completer<Map?> completer = Completer();
    Map<String, dynamic> data = Map();
    data[PACKAGE_NAME] = packageInfo.packageName;
    data[PACKAGE_VERSION] = packageInfo.version;
    try {
      if (Platform.isAndroid) {
        data[DEVICE_INFO] =
            _readAndroidBuildData(await _deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        data[DEVICE_INFO] = _readIosDeviceInfo(await _deviceInfoPlugin.iosInfo);
      }
    } finally {
      completer.complete(data);
    }
    return completer.future;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return {
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return {
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}
