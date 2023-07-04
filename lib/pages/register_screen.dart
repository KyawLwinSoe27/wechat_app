import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/register_bloc.dart';
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

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController textEditingControllerName = TextEditingController();
  final TextEditingController textEditingControllerEmail = TextEditingController();
  final TextEditingController textEditingControllerPhoneNumber = TextEditingController();
  final TextEditingController textEditingControllerPassword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ChangeNotifierProvider(
          create: (BuildContext context) => RegisterBloc(),
          child: Scaffold(
            backgroundColor: BACKGROUND_COLOR,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: BACKGROUND_COLOR,
              leading: const BackButton(
                color: PRIMARY_COLOR,
              ),
            ),
            body: SingleChildScrollView(
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
                    height: MARGIN_LEVEL_4_MIDDLE,
                  ),
                  Consumer<RegisterBloc>(
                    builder: (context, bloc, child) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: MARGIN_LEVEL_1_LAST),
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: InputTextField(
                        labelName: TEXT_FIELD_NAME,
                        onChanged: (String val) => bloc.onChangedName(val), textEditingController: textEditingControllerName,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: MARGIN_LEVEL_1_MIDDLE,
                  ),
                  Consumer<RegisterBloc>(
                    builder: (context, bloc, child) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: MARGIN_LEVEL_1_LAST),
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: InputTextField(
                        labelName: TEXT_FIELD_EMAIL,
                        onChanged: (String val) => bloc.onChangedEmail(val), textEditingController: textEditingControllerEmail,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: MARGIN_LEVEL_1_MIDDLE,
                  ),
                  Consumer<RegisterBloc>(
                    builder: (context, bloc, child) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: MARGIN_LEVEL_1_LAST),
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: InputTextField(
                        labelName: TEXT_FIELD_PHONENUMBER,
                        onChanged: (String val) =>
                            bloc.onChangedPhoneNumber(val), textEditingController: textEditingControllerPhoneNumber,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: MARGIN_LEVEL_2_LAST,
                  ),
                  const ChooseDOBWidget(),
                  const SizedBox(
                    height: MARGIN_LEVEL_2_LAST,
                  ),
                  const ChooseGenderWidget(),
                  Consumer<RegisterBloc>(
                    builder: (context, bloc, child) => Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: MARGIN_LEVEL_1_LAST),
                      width: MediaQuery.of(context).size.width,
                      child: InputTextField(
                        labelName: TEXT_FIELD_PASSWORD,
                        onChanged: (String val) => bloc.onChangedPassword(val), textEditingController: textEditingControllerPassword,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: MARGIN_LEVEL_1_LAST,
                  ),
                  const CheckBoxAndAgreeTextWidget(),
                  const SizedBox(
                    height: MARGIN_LEVEL_1_LAST,
                  ),
                  Consumer<RegisterBloc>(
                    builder: (context, bloc, child) => Center(
                      child: InkWell(
                        onTap: () => bloc.isChecked ? bloc.onTapSignUp() : null,
                        child: PrimaryButton(
                            buttonName: "Sign Up",
                            borderColor: TRANSPARENT_COLOR,
                            buttonColor: bloc.isChecked ? PRIMARY_COLOR : GREY_COLOR,
                            textColor: PURE_WHITE_COLOR),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Positioned(
            top: 40, right: 0, child: Image(image: AssetImage(REGISTER)))
      ],
    );
  }
}

class CheckBoxAndAgreeTextWidget extends StatelessWidget {
  const CheckBoxAndAgreeTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer<RegisterBloc>(
  builder: (context, bloc, child) => Checkbox(
    value: bloc.isChecked,
    onChanged: (bool) => bloc.onCheckChange(),
    activeColor: PURE_WHITE_COLOR,
    checkColor: PURE_WHITE_COLOR,
    fillColor: MaterialStateProperty.resolveWith<Color>((states) {
      if (states.contains(MaterialState.selected)) {
        return PRIMARY_COLOR;
      }
      return PRIMARY_COLOR; // Use the default fill color for other states
    }),
  ),
),
        RichText(
            text: const TextSpan(children: [
          TextSpan(
            text: "Agree To",
            style: TextStyle(
              color: GREY_COLOR,
            ),
          ),
          TextSpan(
            text: "Term And Service",
            style: TextStyle(
              color: PRIMARY_COLOR,
            ),
          )
        ]))
      ],
    );
  }
}

class ChooseGenderWidget extends StatelessWidget {
  const ChooseGenderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Gender",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Consumer<RegisterBloc>(
            builder: (context, bloc, child) => Row(
              children: [
                Radio(
                  value: 0,
                  groupValue: bloc.chooseGender,
                  onChanged: (value) => bloc.onChooseGender(value!),
                ),
                const Text(
                  'Male',
                  style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0),
                ),
                Radio(
                  value: 1,
                  groupValue: bloc.chooseGender,
                  onChanged: (value) => bloc.onChooseGender(value!),
                ),
                const Text(
                  'Female',
                  style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0),
                ),
                Radio(
                  value: 2,
                  groupValue: bloc.chooseGender,
                  onChanged: (value) => bloc.onChooseGender(value!),
                ),
                const Text(
                  'Other',
                  style: TextStyle(
                      color: PRIMARY_COLOR,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChooseDOBWidget extends StatelessWidget {
  const ChooseDOBWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Date of Birth"),
          const SizedBox(
            height: MARGIN_LEVEL_1_MIDDLE,
          ),
          Consumer<RegisterBloc>(
            builder: (context, bloc, child) => DropdownDatePicker(
              isDropdownHideUnderline: true, // optional
              // isFormValidator: true, // optional
              startYear: 1900, // optional
              endYear: 2020, // optional
              width: 10, // optional
              onChangedDay: (value) => bloc.onChangeDateOfBirthDay(value ?? ""),
              onChangedMonth: (value) =>
                  bloc.onChangeDateOfBirthMonth(value ?? ""),
              onChangedYear: (value) =>
                  bloc.onChangeDateOfBirthYear(value ?? ""),
              boxDecoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(
                        0.5), // Set the color and opacity of the shadow
                    blurRadius: 5, // Set the blur radius of the shadow
                    offset: const Offset(0, 3),
                    blurStyle:
                        BlurStyle.outer // Set the vertical offset of the shadow
                    ),
                const BoxShadow(
                    color: Colors
                        .transparent, // Set the color to transparent for the other sides
                    blurRadius: 5, // Set the blur radius of the shadow
                    offset: Offset(0, 0), // No offset for the other sides
                    blurStyle:
                        BlurStyle.outer // Set the vertical offset of the shadow

                    ),
              ]), // optional
              showDay: true, // optional
              dayFlex: 1, //// optional
              monthFlex: 2,
              yearFlex: 1,
              locale: "en", // optional
              hintDay: 'Day', // optional
              hintMonth: 'Month', // optional
              hintYear: 'Year', // optional
              hintTextStyle:
                  const TextStyle(color: HINT_TEXT_COLOR), // optional
            ),
          ),
        ],
      ),
    );
  }
}
