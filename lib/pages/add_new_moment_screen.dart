import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_chat_app/blocs/add_new_moment_bloc.dart';
import 'package:we_chat_app/pages/home_screen.dart';
import 'package:we_chat_app/resources/colors.dart';
import 'package:we_chat_app/resources/dimensions.dart';
import 'package:we_chat_app/utils/extensions.dart';

class AddNewMomentScreen extends StatelessWidget {
  const AddNewMomentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (BuildContext context) => AddNewMomentBloc(),
        child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: BACKGROUND_COLOR,
              leading: InkWell(
                onTap: () => navigateToScreen(context, const HomeScreen()),
                child: const Icon(
                  Icons.close,
                  size: 30,
                  color: PRIMARY_COLOR,
                ),
              ),
              centerTitle: true,
              title: const Text(
                "New Moment",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    color: PRIMARY_COLOR),
              ),
              actions: [
                Consumer<AddNewMomentBloc>(
                  builder: (context, bloc, child) => InkWell(
                    onTap: () => bloc
                        .addNewPost()
                        .then((value) => Navigator.pop(context)),
                    child: Container(
                      margin: const EdgeInsets.all(MARGIN_LEVEL_1_MIDDLE),
                      width: 60,
                      height: 32,
                      decoration: BoxDecoration(
                        color: PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(MARGIN_LEVEL_1_5),
                      ),
                      child: const Center(
                          child: Text(
                        "Create",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )),
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: BACKGROUND_COLOR,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: MARGIN_LEVEL_1_LAST),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: MARGIN_LEVEL_1_MIDDLE),
                          child: Row(
                            children: [
                              const ProfilePicture(),
                              const SizedBox(
                                width: MARGIN_LEVEL_1_5,
                              ),
                              Consumer<AddNewMomentBloc>(
                                builder: (context, bloc, child) => Text(
                                  bloc.userVO?.name ?? "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: PRIMARY_COLOR),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Consumer<AddNewMomentBloc>(
                          builder: (context, bloc, child) => TextField(
                            maxLines: 30,
                            decoration: const InputDecoration(
                              hintText: "What's on your mind",
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (val) => bloc.onChangedContent(val),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    children: [
                      Consumer<AddNewMomentBloc>(
                        builder: (context, bloc, child) => InkWell(
                          onTap: () async {
                            FilePickerResult? result = await FilePicker.platform
                                .pickFiles(allowMultiple: true);
                            if (result != null) {
                              bloc.onImageChoose(result.paths.map((path) => File(path!)).toList());
                            }
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(MARGIN_LEVEL_1_LAST),
                                border: Border.all(color: PRIMARY_COLOR)),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: PRIMARY_COLOR,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Consumer<AddNewMomentBloc>(
                          builder: (context, bloc, child) => ListView.builder(
                            itemCount: bloc.medias?.length ?? 0,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, int index) => Container(
                              margin:
                                  const EdgeInsets.only(left: MARGIN_LEVEL_1_5),
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      MARGIN_LEVEL_1_LAST),
                                  border: Border.all(color: PRIMARY_COLOR)),
                              child: Center(
                                  child: bloc.medias != null
                                      ? Image.file(bloc.medias![index],fit: BoxFit.fill,)
                                      : Container(),),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewMomentBloc>(
      builder: (BuildContext context, bloc, Widget? child) => SizedBox(
        width: 40,
        height: 40,
        child: CircleAvatar(
          radius: 20, // Image radius
          backgroundImage: NetworkImage(
            bloc.userVO?.profilePicture ??
                'https://i.redd.it/dry65gj3b8a31.jpg',
          ),
        ),
      ),
    );
  }
}
