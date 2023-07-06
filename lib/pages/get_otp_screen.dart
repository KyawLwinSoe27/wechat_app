import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/get_otp_bloc.dart';
import 'package:we_chat_app/pages/register_screen.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';
import 'package:we_chat_app/resources/images.dart';
import 'package:we_chat_app/utils/extensions.dart';
import 'package:we_chat_app/widgets/LoadingWidget.dart';
import 'package:we_chat_app/widgets/input_text_field.dart';
import 'package:we_chat_app/widgets/primary_button.dart';
import 'package:we_chat_app/widgets/sub_title_text.dart';
import 'package:we_chat_app/widgets/title_text.dart';

import '../resources/strings.dart';

class GetOTPScreen extends StatelessWidget {
  GetOTPScreen({Key? key}) : super(key: key);

  final TextEditingController textEditingControllerForOTP =
      TextEditingController();
  final TextEditingController textEditingControllerPhoneNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: BACKGROUND_COLOR,
        leading: const BackButton(
          color: PRIMARY_COLOR,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (BuildContext context) => GetOTPBloc(),
        child: Selector<GetOTPBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) => Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: MARGIN_LEVEL_2_MIDDLE,
                    ),
                    const TitleText(
                      titleText: "Hi !",
                    ),
                    const SizedBox(
                      height: MARGIN_LEVEL_1_MIDDLE,
                    ),
                    const SubTitleText(
                      subTitleText: "Create a new account",
                    ),
                    const SizedBox(
                      height: MARGIN_LEVEL_3_LAST,
                    ),
                    const Center(child: Image(image: AssetImage(OTP))),
                    const SizedBox(
                      height: MARGIN_LEVEL_2_MIDDLE,
                    ),
                    Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: InputTextField(
                              labelName: ENTER_YOUR_PHONE_NUMBER, onChanged: (String val) {  }, textEditingController: textEditingControllerPhoneNumber,
                            ),
                          ),
                          const SizedBox(
                            width: MARGIN_LEVEL_1_MIDDLE,
                          ),
                          const PrimaryButton1(
                            buttonName: 'Get OTP',
                            borderColor: TRANSPARENT_COLOR,
                            buttonColor: PRIMARY_COLOR,
                            textColor: PURE_WHITE_COLOR,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: MARGIN_LEVEL_2_LAST,
                    ),
                    Consumer<GetOTPBloc>(
                      builder: (context, bloc, child) => Center(
                        child: PinCodeTextField(
                          pinBoxOuterPadding: const EdgeInsets.symmetric(
                              horizontal: MARGIN_LEVEL_1_MIDDLE),
                          controller: textEditingControllerForOTP,
                          highlightAnimation: true,
                          autofocus: true,
                          highlight: false,
                          hideCharacter: false,
                          highlightColor: Colors.black,
                          defaultBorderColor: Colors.white,
                          hasTextBorderColor: Colors.white,
                          maxLength: 4,
                          pinBoxWidth: 45,
                          pinBoxHeight: 45,
                          maskCharacter: "😎",
                          onDone: (String otp) => bloc.onTapDone(otp),
                          pinTextStyle: const TextStyle(
                              fontSize: 18.0, color: PRIMARY_COLOR),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: MARGIN_LEVEL_1_LAST,
                    ),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "Don't receive the OTP?",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                color: GREY_COLOR),
                          ),
                          Text(
                            "Resend Code",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0,
                                color: PRIMARY_COLOR),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: MARGIN_LEVEL_2_LAST,
                    ),
                    Consumer<GetOTPBloc>(
                      builder: (context, bloc, child) => Center(
                        child: InkWell(
                          onTap: () async{
                           await bloc.onTapVerify();
                           bloc.isOTPCorrect! ? navigateToScreen(context, RegisterScreen()) : showSnackBarWithMessage(context, "false");
                          },
                          child: const PrimaryButton(
                              buttonName: "Verify",
                              borderColor: TRANSPARENT_COLOR,
                              buttonColor: PRIMARY_COLOR,
                              textColor: PURE_WHITE_COLOR),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isLoading,
                child: Container(
                  color: Colors.black12,
                  child: const Center(
                    child: LoadingWidget(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PrimaryButton1 extends StatelessWidget {
  final String buttonName;
  final Color borderColor;
  final Color buttonColor;
  final Color textColor;
  const PrimaryButton1({
    super.key,
    required this.buttonName,
    required this.borderColor,
    required this.buttonColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(5.0),
          color: buttonColor),
      child: Center(
          child: Text(
        buttonName,
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: FONT_SIZE_MEDIUM_6,
            color: textColor),
      )),
    );
  }
}
