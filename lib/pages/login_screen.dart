import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/home_screen.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';
import 'package:we_chat_app/resources/images.dart';
import 'package:we_chat_app/resources/strings.dart';
import 'package:we_chat_app/utils/extensions.dart';
import 'package:we_chat_app/widgets/input_text_field.dart';
import 'package:we_chat_app/widgets/primary_button.dart';
import 'package:we_chat_app/widgets/sub_title_text.dart';
import 'package:we_chat_app/widgets/title_text.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController textEditingControllerEmail = TextEditingController();
  final TextEditingController textEditingControllerPhoneNumber = TextEditingController();
  final TextEditingController textEditingControllerPassword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: PURE_WHITE_COLOR,
        leading: const BackButton(
          color: PRIMARY_COLOR,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: MARGIN_LEVEL_2_MIDDLE,),
            const TitleText(titleText: "Welcome !",),
            const SizedBox(height: MARGIN_LEVEL_1_MIDDLE,),
            const SubTitleText(subTitleText: "Login to continue",),
            const SizedBox(height: MARGIN_LEVEL_3_LAST,),
            const Center(child: Image(image: AssetImage(LOGIN))),
            const SizedBox(height: MARGIN_LEVEL_2_MIDDLE,),
            Container(
              padding: const EdgeInsets.only(left:30,right: 30),
              child: InputTextField(
                labelName: ENTER_YOUR_PHONE_NUMBER, onChanged: (String val) {  }, textEditingController: textEditingControllerPhoneNumber,
              ),
            ),
            const SizedBox(height: MARGIN_LEVEL_1_MIDDLE,),
            Container(
              padding: const EdgeInsets.only(left:30,right: 30),
              child: InputTextField(
                labelName: ENTER_YOUR_EMAIL, onChanged: (String val) {  }, textEditingController: textEditingControllerEmail,
              ),
            ),
            const SizedBox(height: MARGIN_LEVEL_1_MIDDLE,),
            Container(
              padding: const EdgeInsets.only(left:30,right: 30),
              child: InputTextField(
                labelName: ENTER_YOUR_PASSWORD, onChanged: (String val) {  }, textEditingController: textEditingControllerPassword,
              ),
            ),
            const SizedBox(
              height: MARGIN_LEVEL_1_LAST,
            ),
            Row(
              children: const [
                Spacer(),
                Text(FORGOT_PASSWORD,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14.0),),
                SizedBox(
                  width: MARGIN_LEVEL_1_LAST,
                )
              ],
            ),
            const SizedBox(
              height: MARGIN_LEVEL_2_LAST,
            ),
            Center(
              child: InkWell(
                onTap: () => navigateToScreen(context,const HomeScreen()),
                child:const PrimaryButton(
                    buttonName: "Login",
                    borderColor: TRANSPARENT_COLOR,
                    buttonColor: PRIMARY_COLOR,
                    textColor: PURE_WHITE_COLOR),
              ),
            )
          ],
        ),
      ),
    );
  }
}
