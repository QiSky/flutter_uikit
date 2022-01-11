import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_component/components/common/place_holder.dart';
import 'package:flutter_component/components/common/protocol_description.dart';
import 'package:flutter_component/constant/image_constant.dart';
import 'package:flutter_component/util/export_util.dart';

class LoginWithPhone extends StatefulWidget {
  final String path;

  final ImageType imageType;

  final double? imageHeight;

  final double? imageWidth;

  final String labelText;

  final TextStyle labelTextStyle;

  final Color color;

  final Color bgColor;

  final Function(String phoneNumber, String password)? onClickAction;

  final Function(String phoneNumber)? onPasswordClickAction;

  final Function(bool isChecked)? onCheckedAction;

  final VoidCallback? onHelpClickAction;

  final String description;

  final int descriptionMaxLength;

  final TextStyle descriptionStyle;

  final List<KeywordData>? keyWordList;

  final bool isShowImage;

  final EdgeInsets padding;

  final bool isShowAddedButton;

  final double checkPointSize;

  final double checkPointInnerSize;

  final Function(bool isPassword)? onLoginWayAction;

  const LoginWithPhone(this.path, this.description,
      {this.labelText = "欢迎登录",
      this.color = const Color(0xFF4582FF),
      this.imageHeight = 108,
      this.imageWidth = 108,
      this.imageType = ImageType.LOCAL,
      this.labelTextStyle = const TextStyle(),
      this.onClickAction,
      this.onPasswordClickAction,
      this.onCheckedAction,
      this.descriptionMaxLength = 3,
      this.keyWordList = const [],
      this.descriptionStyle = const TextStyle(),
      this.onHelpClickAction,
      this.isShowImage = true,
      this.padding = const EdgeInsets.symmetric(horizontal: 22),
      this.isShowAddedButton = true,
      this.bgColor = Colors.grey,
      this.checkPointSize = 14,
      this.checkPointInnerSize = 7,
      this.onLoginWayAction});

  @override
  State<StatefulWidget> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  String? phoneNumber;

  final TextEditingController _phoneTextController = TextEditingController();

  final TextEditingController _passwordTextController = TextEditingController();

  final GlobalKey _countryCodeKey = GlobalKey();

  double? _countryCodeWidth;

  bool _isPhoneButtonEnable = false;

  final int maxPhoneLength = 11;

  bool _isPasswordEnable = false;

  @override
  void initState() {
    super.initState();
    _phoneTextController.addListener(() {
      _listenButtonState();
    });
    _passwordTextController.addListener(() {
      _listenButtonState();
    });
    Future.delayed(Duration.zero, () {
      if (_countryCodeWidth == null) {
        setState(() {
          _countryCodeWidth = _countryCodeKey.currentContext!.size!.width;
        });
      }
    });
  }

  void _listenButtonState() {
    if (_phoneTextController.text.isNotEmpty &&
        _phoneTextController.text.length == maxPhoneLength) {
      if(_isPasswordEnable) {
        if(_passwordTextController.text.isNotEmpty) {
          setState(() {
            _isPhoneButtonEnable = true;
          });
        } else {
          setState(() {
            _isPhoneButtonEnable = false;
          });
        }
      } else {
        setState(() {
          _isPhoneButtonEnable = true;
        });
      }
    } else {
      setState(() {
        _isPhoneButtonEnable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.bgColor,
        padding: widget.padding,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.isShowImage
                  ? Container(
                      alignment: Alignment.center, child: generateImage())
                  : Container(),
              const PlaceHolder(axis: Axis.vertical, size: 20),
              Text(widget.labelText,
                  style: widget.labelTextStyle, strutStyle: StrutStyle()),
              const PlaceHolder(axis: Axis.vertical, size: 16),
              Row(
                children: [
                  Row(
                    key: _countryCodeKey,
                    children: [
                      Text(
                        "+86",
                        style: TextStyle(color: widget.color),
                      ),
                      const PlaceHolder(size: 5),
                      const Icon(CupertinoIcons.right_chevron,
                          size: 12, color: Color(0xFFCCCCCC)),
                    ],
                  ),
                  const PlaceHolder(size: 5),
                  Expanded(
                      child: CupertinoTextField(
                          controller: _phoneTextController,
                          maxLength: maxPhoneLength,
                          keyboardType: TextInputType.numberWithOptions(),
                          toolbarOptions: ToolbarOptions(
                              copy: false,
                              cut: false,
                              paste: false,
                              selectAll: false),
                          placeholder: '请输入手机号',
                          style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.white
                                  : Colors.black),
                          clearButtonMode: OverlayVisibilityMode.editing,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 0.5)))))
                ],
              ),
              const PlaceHolder(axis: Axis.vertical, size: 8),
              Offstage(
                offstage: _isPasswordEnable,
                child: Row(
                  children: [
                    PlaceHolder(size: _countryCodeWidth ?? 0),
                    Text(
                      "* 未注册的手机号验证后自动创建账户",
                      style: TextStyle(fontSize: 12, color: Color(0xFFA0ABC1)),
                    )
                  ],
                ),
              ),
              Visibility(
                  visible: _isPasswordEnable,
                  child: Row(
                    children: [
                      Expanded(
                          child: CupertinoTextField(
                              controller: _passwordTextController,
                              keyboardType: TextInputType.visiblePassword,
                              toolbarOptions: ToolbarOptions(
                                  copy: false,
                                  cut: false,
                                  paste: false,
                                  selectAll: false),
                              obscureText: true,
                              placeholder: '请输入密码',
                              style: TextStyle(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black),
                              clearButtonMode: OverlayVisibilityMode.editing,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey, width: 0.5)))))
                    ],
                  )),
              const PlaceHolder(axis: Axis.vertical, size: 35),
              Container(
                height: 50,
                child: RepaintBoundary(
                  child: CupertinoButton(
                      color: widget.color,
                      disabledColor: const Color(0xFFE1E5EF),
                      minSize: double.infinity,
                      child: Text(
                        _isPasswordEnable ? "登录账号" : "获取短信验证码",
                        style: const TextStyle(color: Colors.white),
                      ),
                      onPressed: _isPhoneButtonEnable
                          ? () => widget.onClickAction?.call(
                          _phoneTextController.text.trim(),
                          _passwordTextController.text.trim())
                          : null)
                ),
              ),
              const PlaceHolder(axis: Axis.vertical, size: 14),
              widget.isShowAddedButton
                  ? Row(
                      children: [
                        GestureDetector(
                          child: Row(
                            children: [
                              RepaintBoundary(
                                  child: Text(
                                _isPasswordEnable ? "号码登录" : "密码登录",
                                style: TextStyle(
                                    color: widget.color, fontSize: 14),
                              )),
                              const PlaceHolder(size: 5),
                              Icon(CupertinoIcons.right_chevron,
                                  size: 12, color: widget.color),
                            ],
                          ),
                          onTap: () => throttle(() {
                            setState(() {
                              _isPasswordEnable = !_isPasswordEnable;
                            });
                            _listenButtonState();
                            widget.onLoginWayAction?.call(_isPasswordEnable);
                            widget.onPasswordClickAction
                                ?.call(_phoneTextController.text.trim());
                          }),
                        ),
                        const Spacer(),
                        GestureDetector(
                          child: Row(
                            children: [
                              Text("遇到问题",
                                  style: TextStyle(
                                      color: widget.color, fontSize: 14)),
                              Icon(CupertinoIcons.question,
                                  size: 12, color: widget.color),
                            ],
                          ),
                          onTap: () =>
                              throttle(() => widget.onHelpClickAction?.call()),
                        )
                      ],
                    )
                  : Container(),
              const Spacer(),
              ProtocolDescription(
                widget.description,
                size: widget.checkPointSize,
                innerSize: widget.checkPointInnerSize,
                keywordList: widget.keyWordList,
                descriptionStyle: const TextStyle(color: Color(0xFFA0ABC1)),
                onClickAction: widget.onCheckedAction,
                maxLine: widget.descriptionMaxLength,
                innerColor: const Color(0xFF4582FF),
                isEnableClick: true,
                isShowPoint: true,
              ),
              const PlaceHolder(axis: Axis.vertical, size: 10),
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
