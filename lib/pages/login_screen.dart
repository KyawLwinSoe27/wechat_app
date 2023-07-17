import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/login_bloc.dart';
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

import '../widgets/LoadingWidget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController textEditingControllerEmail =
      TextEditingController();
  final TextEditingController textEditingControllerPhoneNumber =
      TextEditingController();
  final TextEditingController textEditingControllerPassword =
      TextEditingController();

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
      body: ChangeNotifierProvider(
        create: (BuildContext context) => LoginBloc(),
        child: Selector<LoginBloc, bool>(
          selector: (context, bloc) => bloc.isLoading,
          builder: (context, isLoading, child) {
            return Stack(
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
                        titleText: "Welcome !",
                      ),
                      const SizedBox(
                        height: MARGIN_LEVEL_1_MIDDLE,
                      ),
                      const SubTitleText(
                        subTitleText: "Login to continue",
                      ),
                      const SizedBox(
                        height: MARGIN_LEVEL_3_LAST,
                      ),
                      const Center(child: Image(image: AssetImage(LOGIN))),
                      const SizedBox(
                        height: MARGIN_LEVEL_2_MIDDLE,
                      ),
                      Consumer<LoginBloc>(
                        builder: (context, bloc, child) => Container(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: InputTextField(
                            labelName: ENTER_YOUR_PHONE_NUMBER,
                            onChanged: (String val) =>
                                bloc.onChangePhoneNumber(val),
                            textEditingController:
                                textEditingControllerPhoneNumber,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: MARGIN_LEVEL_1_MIDDLE,
                      ),
                      Consumer<LoginBloc>(
                        builder: (context, bloc, child) => Container(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: InputTextField(
                            labelName: ENTER_YOUR_EMAIL,
                            onChanged: (String val) => bloc.onChangeEmail(val),
                            textEditingController: textEditingControllerEmail,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: MARGIN_LEVEL_1_MIDDLE,
                      ),
                      Consumer<LoginBloc>(
                        builder: (context, bloc, child) => Container(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Stack(
                            children: [
                              TextField(
                                decoration: const InputDecoration(
                                  focusedBorder:UnderlineInputBorder(
                                    borderSide: BorderSide(color: PRIMARY_COLOR),
                                  ),
                                  enabledBorder:UnderlineInputBorder(
                                    borderSide: BorderSide(color: PRIMARY_COLOR),
                                  ),
                                  labelText: "Password",
                                  labelStyle:TextStyle(color: Colors.grey),
                                ),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                onChanged: (val) => bloc.onChangePassword(val),
                                obscureText: bloc.isShowPassword,
                              ),
                              Positioned(
                                  top: 20,
                                  right: 10,
                                  child: InkWell(
                                      onTap: () => bloc.toggleShowHidePassword(),
                                      child: Icon(bloc.isShowPassword ? Icons.remove_red_eye :  Icons.security )))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: MARGIN_LEVEL_1_LAST,
                      ),
                      Row(
                        children: const [
                          Spacer(),
                          Text(
                            FORGOT_PASSWORD,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14.0),
                          ),
                          SizedBox(
                            width: MARGIN_LEVEL_1_LAST,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: MARGIN_LEVEL_2_LAST,
                      ),
                      Consumer<LoginBloc>(
                        builder: (context, bloc, child) => Center(
                          child: InkWell(
                            onTap: () => bloc
                                .onTapLogin()
                                .then((_) => navigateToScreen(
                                    context, const HomeScreen()))
                                .catchError((onError) =>
                                    showSnackBarWithMessage(
                                        context, onError.toString())),
                            child: const PrimaryButton(
                                buttonName: "Login",
                                borderColor: TRANSPARENT_COLOR,
                                buttonColor: PRIMARY_COLOR,
                                textColor: PURE_WHITE_COLOR),
                          ),
                        ),
                      )
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
            );
          },
        ),
      ),
    );
  }
}
