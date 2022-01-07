import 'package:flutter_component/constant/permission_result_constant.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtil {
  static PermissionUtil? _instance;

  static PermissionUtil? getInstance() {
    _instance ??= PermissionUtil();
    return _instance;
  }

  Future<PermissionResultConstant> requestPermission(
      List<Permission> permissionList) async {
    Map<Permission, PermissionStatus> statuses = await permissionList.request();
    PermissionResultConstant res = PermissionResultConstant.ALLOW;
    for (var i = 0; i < statuses.length; i++) {
      if (statuses[i]?.isRestricted == true ||
          statuses[i]?.isPermanentlyDenied == true) {
        res = PermissionResultConstant.ALWAYS_DENY;
        return res;
      } else if (statuses[i]?.isDenied == true) {
        res = PermissionResultConstant.DENY;
        return res;
      }
    }
    return res;
  }
}
