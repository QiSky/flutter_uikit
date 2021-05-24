import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_component/components/common/place_holder.dart';
import 'package:flutter_component/components/common/protocol_description.dart';
import 'package:flutter_component/constant/image_constant.dart';

class LoginWithPhone extends StatefulWidget {
  late final String path;

  late final ImageType imageType;

  final double? imageHeight;

  final double? imageWidth;

  late final String labelText;

  late final TextStyle labelTextStyle;

  late final Color color;

  final Function(String phoneNumber)? onClickAction;

  final Function(String phoneNumber)? onPasswordClickAction;

  final Function? onHelpClickAction;

  late final String description;

  late final int descriptionMaxLength;

  late final TextStyle descriptionStyle;

  late final List<KeywordData>? keyWordList;

  LoginWithPhone(this.path, this.description,
      {this.labelText = "欢迎登录",
      this.color = const Color(0xFF4582FF),
      this.imageHeight = 108,
      this.imageWidth = 108,
      this.imageType = ImageType.LOCAL,
      this.labelTextStyle = const TextStyle(),
      this.onClickAction,
      this.onPasswordClickAction,
      this.descriptionMaxLength = 3,
      this.keyWordList = const [],
      this.descriptionStyle = const TextStyle(),
      this.onHelpClickAction});

  @override
  State<StatefulWidget> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  String? phoneNumber;

  TextEditingController _phoneTextController = TextEditingController();

  bool _isPhoneNumberClear = false;

  final GlobalKey _countryCodeKey = GlobalKey();

  double? _countryCodeWidth;

  bool _isPhoneButtonEnable = false;

  final int maxPhoneLength = 11;

  @override
  void initState() {
    super.initState();
    _phoneTextController.addListener(() {
      if (_phoneTextController.text.isNotEmpty && !_isPhoneNumberClear) {
        setState(() {
          _isPhoneNumberClear = !_isPhoneNumberClear;
        });
      }
      if (_phoneTextController.text.isNotEmpty &&
          _phoneTextController.text.length == maxPhoneLength) {
        setState(() {
          _isPhoneButtonEnable = true;
        });
      } else {
        setState(() {
          _isPhoneButtonEnable = false;
        });
      }
    });
    Future.delayed(Duration.zero, () {
      if (_countryCodeWidth == null) {
        setState(() {
          _countryCodeWidth = _countryCodeKey.currentContext!.size!.width;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(alignment: Alignment.center, child: generateImage()),
          PlaceHolder(axis: Axis.vertical, size: 10),
          Text(widget.labelText,
              style: widget.labelTextStyle, strutStyle: StrutStyle()),
          PlaceHolder(axis: Axis.vertical, size: 16),
          Row(
            children: [
              Row(
                key: _countryCodeKey,
                children: [
                  Text(
                    "+86",
                    style: TextStyle(color: widget.color),
                  ),
                  PlaceHolder(size: 5),
                  Icon(CupertinoIcons.right_chevron,
                      size: 12, color: Color(0xFFCCCCCC)),
                ],
              ),
              PlaceHolder(size: 5),
              Expanded(
                  child: TextField(
                      controller: _phoneTextController,
                      maxLength: maxPhoneLength,
                      toolbarOptions: ToolbarOptions(
                          copy: false,
                          cut: false,
                          paste: false,
                          selectAll: false),
                      decoration: InputDecoration(
                          counterText: '',
                          hintText: '请输入手机号',
                          hintStyle:
                              TextStyle(color: Color(0xFFCBCBCB), fontSize: 14),
                          suffixIcon: _isPhoneNumberClear
                              ? IconButton(
                                  padding: EdgeInsets.all(0),
                                  icon: Icon(
                                    _isPhoneNumberClear ? Icons.clear : null,
                                    size: 20,
                                    color: Color(0xFFCBCBCB),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _phoneTextController.text = "";
                                      _isPhoneNumberClear = false;
                                    });
                                  })
                              : null)))
            ],
          ),
          PlaceHolder(axis: Axis.vertical, size: 8),
          Row(
            children: [
              PlaceHolder(size: _countryCodeWidth ?? 0),
              Text(
                "* 未注册的手机号验证后自动创建账户",
                style: TextStyle(fontSize: 12, color: Color(0xFFA0ABC1)),
              )
            ],
          ),
          PlaceHolder(axis: Axis.vertical, size: 35),
          Container(
            height: 50,
            child: CupertinoButton(
                color: widget.color,
                disabledColor: Color(0xFFE1E5EF),
                minSize: double.infinity,
                child: Text(
                  "获取短信验证码",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _isPhoneButtonEnable
                    ? () => widget.onClickAction
                        ?.call(_phoneTextController.text.trim())
                    : null),
          ),
          PlaceHolder(axis: Axis.vertical, size: 14),
          Row(
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    Text(
                      "密码登录",
                      style: TextStyle(color: widget.color, fontSize: 14),
                    ),
                    PlaceHolder(size: 5),
                    Icon(CupertinoIcons.right_chevron,
                        size: 12, color: widget.color),
                  ],
                ),
                onTap: () => widget.onPasswordClickAction
                    ?.call(_phoneTextController.text.trim()),
              ),
              Spacer(),
              GestureDetector(
                child: Row(
                  children: [
                    Text("遇到问题",
                        style: TextStyle(color: widget.color, fontSize: 14)),
                    Icon(CupertinoIcons.question,
                        size: 12, color: widget.color),
                  ],
                ),
                onTap: () => widget.onHelpClickAction?.call(),
              )
            ],
          ),
          Spacer(),
          ProtocolDescription(
            widget.description,
            keywordList: widget.keyWordList,
            descriptionStyle: TextStyle(color: Color(0xFFA0ABC1)),
            maxLine: widget.descriptionMaxLength,
            innerColor: Color(0xFF4582FF),
            isEnableClick: true,
          ),
          PlaceHolder(axis: Axis.vertical, size: 10),
        ]));
  }

  Widget generateImage() {
    if (widget.imageType == ImageType.LOCAL) {
      return Image.asset(
        widget.path,
        fit: BoxFit.cover,
        width: widget.imageWidth,
        height: widget.imageHeight,
      );
    } else {
      return CachedNetworkImage(
          width: widget.imageWidth,
          height: widget.imageHeight,
          imageUrl: widget.path,
          fit: BoxFit.cover);
    }
  }
}
