import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/login_bloc.dart';
import 'package:we_chat_app/pages/login_screen.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';
import 'package:we_chat_app/utils/extensions.dart';

import '../widgets/primary_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginBloc(),
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(vertical: MARGIN_LEVEL_1_LAST),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 330),
                child: Center(
                  child: Consumer<LoginBloc>(
                    builder: (context, bloc, child) => InkWell(
                      onTap: () {
                        bloc
                            .onTapLogout()
                            .then(
                                (_) => navigateToScreen(context, LoginScreen()))
                            .catchError((onError) => showSnackBarWithMessage(
                                context, onError.toString()));
                      },
                      child: const PrimaryButton(
                        buttonName: 'Log Out',
                        borderColor: PRIMARY_COLOR,
                        buttonColor: PURE_WHITE_COLOR,
                        textColor: PRIMARY_COLOR,
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                            text: "Designed By ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: "PADC.com.mm",
                            style: TextStyle(
                                color: PRIMARY_COLOR,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: MARGIN_LEVEL_1_LAST,
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                            text: "Developed By ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: "Kyaw Lwin Soe",
                            style: TextStyle(
                                color: PRIMARY_COLOR,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
