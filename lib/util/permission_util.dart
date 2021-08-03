
import 'package:flutter_component/constant/permission_result_constant.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  static PermissionUtil? _instance;

  static PermissionUtil? getInstance() {
    if (_instance == null) {
      _instance = PermissionUtil();
    }
    return _instance;
  }

  Future<PermissionResultConstant> requestPermission(
      List<Permission> permissionList) async {
    Map<Permission, PermissionStatus> statuses = await permissionList.request();
    PermissionResultConstant res = PermissionResultConstant.ALLOW;
    statuses.forEach((key, value) {
      if (value.isRestricted || value.isPermanentlyDenied) {
        res = PermissionResultConstant.ALWAYS_DENY;
        return;
      } else if (value.isDenied) {
        res = PermissionResultConstant.DENY;
        return;
      }
    });
    return res;
  }
}
