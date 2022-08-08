import 'dart:math';

///
/// * @ProjectName: uikit
/// * @Author: qifanxin
/// * @CreateDate: 2022/8/7 16:20
/// * @Description: 文件说明
///

extension RandomHelper on int {
  String randomFileName() {
    final String alphabet =
        'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    String left = '';
    for (var i = 0; i < this; i++)
      left = left + alphabet[Random().nextInt(alphabet.length)];
    return left;
  }

  int randomInt() {
    return Random().nextInt(this);
  }
}
