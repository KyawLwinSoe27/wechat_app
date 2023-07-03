import 'package:flutter/material.dart';
import 'package:we_chat_app/pages/login_screen.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';
import 'package:we_chat_app/resources/images.dart';
import 'package:we_chat_app/resources/strings.dart';
import 'package:we_chat_app/utils/extensions.dart';
import 'package:we_chat_app/widgets/primary_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Spacer(),
            Image(image: AssetImage(LOGO)),
            Spacer(),
            TextColumn(),
            SizedBox(
              height: MARGIN_LEVEL_3_MIDDLE,
            ),
            RowButton(),
            SizedBox(
              height: MARGIN_LEVEL_4_LAST,
            ),
          ],
        ),
      ),
    );
  }
}

class TextColumn extends StatelessWidget {
  const TextColumn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(TEXT_YOUR_FRIENDS_SHARE_MOMENTS,style: TextStyle(fontWeight: FontWeight.w600,fontSize: FONT_SIZE_MEDIUM_8,color: PRIMARY_COLOR),),
        SizedBox(height: MARGIN_LEVEL_1_MIDDLE),
        Text(END_TO_END_SECURE_MESSAGE,style: TextStyle(fontWeight: FontWeight.w400,fontSize: FONT_SIZE_MEDIUM_2,color: PRIMARY_COLOR),),
      ],
    );
  }
}

class RowButton extends StatelessWidget {
  const RowButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const PrimaryButton(
          buttonName: 'Sign Up',
          borderColor: BUTTON_COLOR,
          buttonColor: TRANSPARENT_COLOR,
          textColor: BUTTON_COLOR,
        ),
        const SizedBox(width: MARGIN_LEVEL_1_MIDDLE,),
        InkWell(
          onTap: () => navigateToScreen(context,const LoginScreen()),
          child: const PrimaryButton(
            buttonName: 'Login',
            borderColor: TRANSPARENT_COLOR,
            buttonColor: BUTTON_COLOR,
            textColor: PURE_WHITE_COLOR,
          ),
        ),
      ],
    );
  }
}
