import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_component/components/button/login_way_button.dart';
import 'package:flutter_component/components/common/circle_image.dart';
import 'package:flutter_component/components/common/business_lost.dart';
import 'package:flutter_component/components/common/protocol_description.dart';
import 'package:flutter_component/components/dialog/business_alert_dialog.dart';
import 'package:flutter_component/flutter_component.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
          appBar: AppBar(
            leading: BackButton(
              color: Colors.black,
            ),
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: showNumberCell(),
      )
    );
  }

  Widget showNumberCell() {
    return NumberCell(
        label: '数量',
        labelTextStyle: TextStyle(color: Color(0xFFB4C0D1), fontSize: 16),
        defaultValue: 0,
        valueCallBack: (value) {

        }
    );
  }

  Widget showParamsCell() {
    return ParamsCell(label: "123", labelTextStyle: TextStyle(color: Color(0xFFB4C0D1), fontSize: 16),
      defaultValue: "321", valueTextStyle: TextStyle(color: Color(0xFF18191A), fontSize: 16, fontWeight: FontWeight.w600),
      numberTextStyle: TextStyle(fontSize: 14, color: Color(0xFF4582FF)),
    );
  }

  Widget showCountStep() {
    return Container(
      child: NumberStep(),
    );
  }

  Widget showListItem() {
    return ListItem(leftText: "123", rightText: "321");
  }


  void showOptionBottomSheet() {
    List<OptionEntry> dataSourceList = [];
    dataSourceList.add(OptionEntry("1"));
    dataSourceList.add(OptionEntry("2"));
    dataSourceList.add(OptionEntry("3"));
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
        elevation: 10,
        builder: (BuildContext context) {
          return OptionBottomSheet(
            "类型",
            dataSourceList,
            Theme.of(context).primaryColor,
          );
        });
  }

  Widget getMenuOptionButton() {
    return MenuOptionButton(
      "待付款",
      "asset/wallet.png",
      textStyle: TextStyle(fontSize: 14, color: Color(0xFF000000)),
    );
  }

  Widget getCircleImage() {
    return CircleImage("asset/test1.png", imageType: ImageType.LOCAL, border: Border.all(color: Colors.white, width: 2));
  }

  Widget getAlertDialog() {
    return BusinessAlertDialog(
      context,
      '我是男性',
      "性别选择后无法更改，若选择的性别和您的生理性别不一致，我们会修改您的性别",
      "确定",
      "取消",
          () => {},
          () => {},
      titleKeywordList: [
        KeywordData("男性", () => {}, TextStyle(color: Color(0xFF643AE5)))
      ],
      titleStyle: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.w600),
      contentStyle: TextStyle(fontSize: 14, color: Colors.black),
      positiveBgColor: Color(0xFF643AE5),
      negativeBgColor: Color(0xFFE3E4E6),
      negativeTextStyle: TextStyle(color: Colors.black, fontSize: 14),
      positiveTextStyle: TextStyle(color: Colors.white, fontSize: 14),
    );
  }

  Widget getNetworkList() {
    return BusinessLost("无网络连接", "重新载入", "asset/test1.png",
        textStyle: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
        reloadTextStyle: TextStyle(fontSize: 14, color: Colors.white));
  }

  Widget getLoginWayButton() {
    return LoginWayButton(
      Icon(
        CupertinoIcons.device_phone_portrait,
        color: Colors.white,
      ),
      "使用手机号码登录",
      textStyle: TextStyle(
          color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
    );
  }

  Widget getLoginPage() {
    List<KeywordData>? list = [];
    list.add(KeywordData('《隐私服务协议》', () {
      print("点击隐私");
    }, TextStyle(color: Color(0xFF4582FF))));
    list.add(KeywordData('《用户服务协议》', () {
      print("点击用户");
    }, TextStyle(color: Color(0xFF4582FF))));
    return LoginWithPhone("asset/test1.png",
        "点击登录或注册表示您已阅读并同意了《隐私服务协议》《用户服务协议》。如果您不同意上述协议的任何条款，您应立刻停止登录及使用本软件服务。",
        labelTextStyle: TextStyle(
            fontSize: 25,
            color: Color(0xFF18191A),
            fontWeight: FontWeight.bold),
        keyWordList: list);
  }

  Widget getMessageCell() {
    return MessageCell(
        "asset/test1.png", "系统消息", "你有一笔¥10.00退款", "22:13", Colors.white,
        imageType: ImageType.LOCAL,
        timeStyle: TextStyle(color: Color(0xFF767A7D), fontSize: 13),
        titleStyle: TextStyle(color: Color(0xFF18191A), fontSize: 13),
        subTitleStyle: TextStyle(color: Color(0xFF767A7D), fontSize: 13));
  }

  Widget getDividingLine() {
    return DividingLine(Colors.grey);
  }

  Widget getLabelProductCard() {
    return Row(
      children: [
        PlaceHolder(
          size: 10,
        ),
        Expanded(
            child: LabelProductCard(
          Color(0xFF4582FF),
          "数码打印",
          "asset/test1.png",
          labelStyle: TextStyle(color: Colors.white, fontSize: 15),
          imageWidth: 80,
          imageHeight: 80,
        )),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: LabelProductCard(
          Color(0xFF4582FF),
          "数码打印",
          "asset/test1.png",
          labelStyle: TextStyle(color: Colors.white, fontSize: 15),
          imageWidth: 80,
          imageHeight: 80,
        )),
        PlaceHolder(
          size: 10,
        )
      ],
    );
  }
}
