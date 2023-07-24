import 'dart:io';

import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/profile_bloc.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';
import 'package:we_chat_app/resources/images.dart';
import 'package:we_chat_app/resources/strings.dart';
import 'package:we_chat_app/widgets/input_text_field.dart';
import 'package:we_chat_app/widgets/primary_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProfileBloc(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: BACKGROUND_COLOR,
          automaticallyImplyLeading: false,
          title: const Text(
            "Me",
            style: TextStyle(
                color: PRIMARY_COLOR,
                fontSize: 34,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              InputTextField(
                                labelName: 'Name',
                                onChanged: (String val) {},
                                textEditingController: TextEditingController(),
                              ),
                              const SizedBox(
                                height: MARGIN_LEVEL_1_MIDDLE,
                              ),
                              InputTextField(
                                labelName: 'Email',
                                onChanged: (String val) {},
                                textEditingController: TextEditingController(),
                              ),
                              const SizedBox(
                                height: MARGIN_LEVEL_1_MIDDLE,
                              ),
                              InputTextField(
                                labelName: 'Phone Number',
                                onChanged: (String val) {},
                                textEditingController: TextEditingController(),
                              ),
                              const SizedBox(
                                height: MARGIN_LEVEL_1_LAST,
                              ),
                              const ChooseDOBWidget(),
                              const SizedBox(
                                height: MARGIN_LEVEL_1_LAST,
                              ),
                              const ChooseGenderRowWidget(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const PrimaryButton(
                                        buttonName: "Cancel",
                                        borderColor: PRIMARY_COLOR,
                                        buttonColor: PURE_WHITE_COLOR,
                                        textColor: PRIMARY_COLOR,
                                        width: 110,
                                        height: 40,
                                      )),
                                  InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const PrimaryButton(
                                        buttonName: "Save",
                                        borderColor: PURE_WHITE_COLOR,
                                        buttonColor: PRIMARY_COLOR,
                                        textColor: PURE_WHITE_COLOR,
                                        width: 110,
                                        height: 40,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Container(
                margin: const EdgeInsets.all(MARGIN_LEVEL_1_MIDDLE),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: PRIMARY_COLOR,
                  borderRadius: BorderRadius.circular(MARGIN_LEVEL_1_5),
                ),
                child: Center(child: Image.asset(EDIT_PENCIL_BUTTON)),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ProfilePhotoAndNameColumnWidget(),
              SizedBox(
                height: MARGIN_LEVEL_1_MIDDLE,
              ),
              BookMarkedTitleText(),
              SizedBox(
                height: MARGIN_LEVEL_1_MIDDLE,
              ),
              // BookMarkedMomentsListView()
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseGenderRowWidget extends StatelessWidget {
  const ChooseGenderRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class ChooseDOBWidget extends StatelessWidget {
  const ChooseDOBWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

// class BookMarkedMomentsListView extends StatelessWidget {
//   const BookMarkedMomentsListView({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 500,
//       child: ListView.builder(
//         itemCount: 100,
//         itemBuilder: (BuildContext context, int index) {
//           // Build and return the individual item widget
//           return const PostItem();
//         },
//       ),
//     );
//   }
// }

class ProfilePhotoAndNameColumnWidget extends StatelessWidget {
  const ProfilePhotoAndNameColumnWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: MARGIN_LEVEL_1_MIDDLE),
      padding: const EdgeInsets.symmetric(vertical: MARGIN_LEVEL_1_MIDDLE),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: PRIMARY_COLOR, borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          SizedBox(
            width: MARGIN_LEVEL_2_MIDDLE,
          ),
          ProfilePhotoWidget(),
          SizedBox(
            width: MARGIN_LEVEL_2_25,
          ),
          NameAndTextColumnWidget(),
        ],
      ),
    );
  }
}

class BookMarkedTitleText extends StatelessWidget {
  const BookMarkedTitleText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: MARGIN_LEVEL_1_MIDDLE),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            BOOKMARKED_MOMENTS,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: PRIMARY_COLOR),
          ),
          SizedBox(
              width: 200,
              child: Divider(
                height: 3.0,
                thickness: 3,
                color: PRIMARY_COLOR,
              ))
        ],
      ),
    );
  }
}

class NameAndTextColumnWidget extends StatelessWidget {
  const NameAndTextColumnWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileBloc>(
      builder: (context, bloc, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bloc.userName,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 20.0,
                color: PURE_WHITE_COLOR),
          ),
          const SizedBox(
            height: MARGIN_LEVEL_1_MIDDLE,
          ),
          IconAndTextWidget(
            text: bloc.phoneNumber,
            iconData: Icons.phone_android,
          ),
          const SizedBox(
            height: MARGIN_LEVEL_1_MIDDLE,
          ),
          IconAndTextWidget(
            text: bloc.dateOfBirth.toString().substring(0, 10),
            iconData: Icons.calendar_month,
          ),
          const SizedBox(
            height: MARGIN_LEVEL_1_MIDDLE,
          ),
          IconAndTextWidget(
            text: bloc.chooseGender == 0
                ? "Male"
                : (bloc.chooseGender == 1 ? "Female" : "Other"),
            iconData: Icons.male,
          ),
        ],
      ),
    );
  }
}

class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileBloc>(
      builder: (context, bloc, child) => Stack(
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: CircleAvatar(
              radius: 20, // Image radius
              backgroundImage: NetworkImage(
                bloc.profilePicture != null ? bloc.profilePicture! : 'https://i.redd.it/dry65gj3b8a31.jpg' ,
              ),
            ),
          ),
          bloc.loggedInUser?.id != null
              ? Positioned(
                  bottom: -10,
                  right: 0,
                  child: SizedBox(
                    width: 60,
                    height: 60,
                    child: InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Scan Me To Make Friend'),
                              content: Container(
                                margin:
                                    const EdgeInsets.only(left: 15.0, top: 5.0),
                                width: 200,
                                height: 200,
                                child: QrImage(
                                  data: bloc.loggedInUser!.id!,
                                  foregroundColor: Colors.black,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: QrImage(
                        data: bloc.loggedInUser!.id!,
                        foregroundColor: PURE_WHITE_COLOR,
                      ),
                    ),
                  ),
                )
              : Container(),
          Positioned(
            bottom: 0,
            left: 0,
            child: Consumer<ProfileBloc>(
              builder: (context, bloc, child) => InkWell(
                onTap: () async{
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(
                      source: ImageSource.gallery);
                  if(image != null) {
                    bloc.onImageChoose(File(image.path));
                  }
                },
                child: const Icon(
                  Icons.image_outlined,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IconAndTextWidget extends StatelessWidget {
  final String text;
  final IconData iconData;
  const IconAndTextWidget(
      {super.key, required this.text, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: PURE_WHITE_COLOR,
        ),
        const SizedBox(
          width: MARGIN_LEVEL_1_5,
        ),
        Text(
          text,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: PURE_WHITE_COLOR),
        ),
      ],
    );
  }
}
