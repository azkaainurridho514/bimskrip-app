import 'package:bimskrip/features/dashboard/bussines/entities/progres_name.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/name_provider.dart';
import 'package:bimskrip/utils/widgets.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/constraint.dart';
import '../../data/models/name_model.dart';
import '../../data/models/progres_model.dart';
import '../provider/progres_provider.dart';
import '../provider/user_provider.dart';

class AddProgressPage extends StatefulWidget {
  const AddProgressPage({super.key});

  @override
  State<AddProgressPage> createState() => _AddProgressPageState();
}

class _AddProgressPageState extends State<AddProgressPage> {
  final TextEditingController progressController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController file = TextEditingController();
  bool show = false;
  int nameID = 0;
  String filePath = "";

  @override
  void dispose() {
    progressController.dispose();
    contentController.dispose();
    file.dispose();
    super.dispose();
  }

  NameModel? progressName;
  ProgresCreateModel? progress;
  Future<void> pickDoc() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null) {
      filePath = result.files.single.path!;
      file.text = result.files.single.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    var load = Provider.of<ProgresProvider>(context).isLoadingCreate;
    progressName = Provider.of<NameProvider>(context).progressName;
    progress = Provider.of<ProgresProvider>(context).createProgress;
    if (load != kLoadNothing) {
      if (load == kLoadStop) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Provider.of<ProgresProvider>(context, listen: false).isLoadingCreate =
              kLoadNothing;
          if (progress != null) {
            if (progress!.statusCode == 200) {
              CherryToast.success(
                animationDuration: const Duration(milliseconds: 500),
                displayCloseButton: false,
                toastDuration: Duration(seconds: 2),
                animationType: AnimationType.fromTop,
                title: Text(
                  progress!.message,
                  style: TextStyle(color: Colors.black),
                ),
              ).show(context);
              String userId =
                  Provider.of<UserProvider>(
                    context,
                    listen: false,
                  ).users!.Id.toString();
              String roleId =
                  Provider.of<UserProvider>(
                    context,
                    listen: false,
                  ).users!.roleId.toString();
              Provider.of<ProgresProvider>(
                context,
                listen: false,
              ).eitherFailureOrProgress(roleId: roleId, userId: userId);
              Navigator.of(context).pop();
            } else {
              CherryToast.error(
                animationDuration: const Duration(milliseconds: 500),
                displayCloseButton: false,
                toastDuration: Duration(seconds: 2),
                animationType: AnimationType.fromTop,
                title: Text(
                  progress!.message,
                  style: TextStyle(color: Colors.black),
                ),
              ).show(context);
            }
          }
        });
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: textRandom(
          text: "Add your Progress",
          size: 14,
          color: MyColors.blackColor,
        ),
        backgroundColor: MyColors.forthColor,
      ),
      backgroundColor: MyColors.forthColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ListView(
                children: [
                  const SizedBox(height: 80),
                  progressName == null
                      ? textRandom(
                        text: "Tidak di temukan",
                        size: 14,
                        color: MyColors.blackColor,
                      )
                      : show
                      ? Container(
                        margin: EdgeInsets.only(top: 15),
                        child: GestureDetector(
                          onTap: () => setState(() => show = !show),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors.secondColor,
                            ),
                            child:
                                progressName!.data.isEmpty
                                    ? textRandom(
                                      textAlign: TextAlign.center,
                                      text: "Not found",
                                      size: 13,
                                      color: MyColors.whiteColor,
                                    )
                                    : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: progressName!.data.length,
                                      itemBuilder:
                                          (context, index) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                progressController.text =
                                                    progressName!
                                                        .data[index]
                                                        .name
                                                        .toString();
                                                nameID =
                                                    progressName!
                                                        .data[index]
                                                        .id;
                                                show = !show;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              child: textRandom(
                                                text:
                                                    progressName!
                                                        .data[index]
                                                        .name,
                                                size: 13,
                                                color: MyColors.whiteColor,
                                              ),
                                            ),
                                          ),
                                    ),
                          ),
                        ),
                      )
                      : Container(
                        margin: EdgeInsets.only(top: 15),
                        child: TextField(
                          controller: progressController,
                          cursorColor: MyColors.blackColor,
                          onChanged: (v) => setState(() {}),
                          cursorHeight: 20,
                          readOnly: true,
                          onTap: () => setState(() => show = !show),
                          decoration: inputDecoration(
                            text: 'Pilih Proses',
                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                        ),
                      ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: contentController,
                    cursorColor: MyColors.blackColor,
                    onChanged: (v) => setState(() {}),
                    cursorHeight: 20,
                    decoration: inputDecoration(text: 'Content'),
                    keyboardType: TextInputType.multiline,
                    minLines: 4,
                    maxLines: null,
                  ),
                  const SizedBox(height: 15),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: TextField(
                      controller: file,
                      cursorColor: MyColors.blackColor,
                      onChanged: (v) => setState(() {}),
                      cursorHeight: 20,
                      readOnly: true,
                      onTap: () => pickDoc(),
                      style: TextStyle(fontSize: 13.0),
                      decoration: inputDecoration(
                        text: 'Pilih Dokumen',
                        icon: Icon(Icons.keyboard_arrow_down_rounded),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  buttonCustom(
                    text: load == kLoading ? "Loading..." : "Create Progress",
                    onTap: () {
                      String userId =
                          Provider.of<UserProvider>(
                            context,
                            listen: false,
                          ).users!.Id.toString();
                      String dpaId =
                          Provider.of<UserProvider>(
                            context,
                            listen: false,
                          ).users!.DosenPAID.toString();
                      Provider.of<ProgresProvider>(
                        context,
                        listen: false,
                      ).eitherFailureOrCreateProgress(
                        roleId: "",
                        dpaId: dpaId,
                        userId: userId,
                        nameId: nameID.toString(),
                        content: contentController.text,
                        file: filePath,
                      );
                      // Provider.of<ProgresProvider>(
                      //   context,
                      //   listen: false,
                      // ).eitherFailureOrProgress(roleId: roleId, userId: userId);
                    },
                    disable:
                        progressController.text == "" ||
                                contentController.text == ""
                            ? true
                            : false,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
