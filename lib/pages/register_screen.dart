import 'package:datepicker_dropdown/datepicker_dropdown.dart';
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

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: MARGIN_LEVEL_1_LAST),
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: const InputTextField(
                    labelName: TEXT_FIELD_NAME,
                  ),
                ),
                const SizedBox(
                  height: MARGIN_LEVEL_1_MIDDLE,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: MARGIN_LEVEL_1_LAST),
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: const InputTextField(
                    labelName: TEXT_FIELD_EMAIL,
                  ),
                ),
                const SizedBox(
                  height: MARGIN_LEVEL_1_MIDDLE,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: MARGIN_LEVEL_1_LAST),
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: const InputTextField(
                    labelName: TEXT_FIELD_PHONENUMBER,
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
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: MARGIN_LEVEL_1_LAST),
                  width: MediaQuery.of(context).size.width,
                  child: const InputTextField(
                    labelName: TEXT_FIELD_PASSWORD,
                  ),
                ),
                const SizedBox(
                  height: MARGIN_LEVEL_1_LAST,
                ),
                const CheckBoxAndAgreeTextWidget(),
                const SizedBox(
                  height: MARGIN_LEVEL_1_LAST,
                ),
                Center(
                  child: InkWell(
                    onTap: () =>
                        navigateToScreen(context, const HomeScreen()),
                    child: const PrimaryButton(
                        buttonName: "Sign Up",
                        borderColor: TRANSPARENT_COLOR,
                        buttonColor: PRIMARY_COLOR,
                        textColor: PURE_WHITE_COLOR),
                  ),
                ),
              ],
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
        Checkbox(
          value: true,
          onChanged: null,
          activeColor: PURE_WHITE_COLOR,
          checkColor: PURE_WHITE_COLOR,
          fillColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.selected)) {
              return PRIMARY_COLOR;
            }
            return PRIMARY_COLOR; // Use the default fill color for other states
          }),
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
          Row(
            children: [
              Radio(
                value: 0,
                groupValue: 1,
                onChanged: (value) {},
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
                groupValue: 1,
                onChanged: (value) {},
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
                groupValue: 1,
                onChanged: (value) {},
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
          DropdownDatePicker(
            isDropdownHideUnderline: true, // optional
            // isFormValidator: true, // optional
            startYear: 1900, // optional
            endYear: 2020, // optional
            width: 10, // optional
            onChangedDay: (value) => print('onChangedDay: $value'),
            onChangedMonth: (value) => print('onChangedMonth: $value'),
            onChangedYear: (value) => print('onChangedYear: $value'),
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
            hintTextStyle: const TextStyle(color: HINT_TEXT_COLOR), // optional
          ),
        ],
      ),
    );
  }
}
