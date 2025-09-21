import 'package:bimskrip/features/dashboard/bussines/entities/progres_name.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/name_provider.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/schedule_provider.dart';
import 'package:bimskrip/utils/widgets.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/constraint.dart';
import '../../data/models/mahasiswa_by_dosen_model.dart';
import '../../data/models/progres_model.dart';
import '../../data/models/schedule_model.dart';
import '../provider/mahasiswa_by_dosen_provider.dart';
import '../provider/progres_provider.dart';
import '../provider/user_provider.dart';

class AddSchedulePage extends StatefulWidget {
  const AddSchedulePage({super.key});

  @override
  State<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends State<AddSchedulePage> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController mahasiswaController = TextEditingController();
  final TextEditingController tempatController = TextEditingController();

  @override
  void dispose() {
    tempatController.dispose();
    dateController.dispose();
    mahasiswaController.dispose();
    super.dispose();
  }

  bool show = false;
  int mahasiswaID = 0;
  MahasiswaByDosenModel? mahasiswa;
  ScheduleModel? schedule;
  String date = "";

  DateTime? selectedDate;
  final dateBE = DateFormat('yyyy-MM-dd');
  final dateFE = DateFormat('d MMMM yyyy');

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: MyColors.primaryColor, // Warna header & tanggal dipilih
              onPrimary: Colors.black, // Warna teks di header
              onSurface: MyColors.blackColor, // Warna teks hari biasa
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: MyColors.blackColor, // Tombol CANCEL & OK
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        date = dateBE.format(picked);
        dateController.text = dateFE.format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var load = Provider.of<ScheduleProvider>(context).isLoadingCreate;
    mahasiswa = Provider.of<MahasiswaByDosenProvider>(context).mahasiswa;
    schedule = Provider.of<ScheduleProvider>(context).schedules;
    if (load != kLoadNothing) {
      if (load == kLoadStop) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Provider.of<ScheduleProvider>(context, listen: false)
              .isLoadingCreate = kLoadNothing;
          if (schedule != null) {
            if (schedule!.statusCode == 200) {
              CherryToast.success(
                animationDuration: const Duration(milliseconds: 500),
                displayCloseButton: false,
                toastDuration: Duration(seconds: 2),
                animationType: AnimationType.fromTop,
                title: Text(
                  schedule!.message,
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
              Provider.of<ScheduleProvider>(
                context,
                listen: false,
              ).eitherFailureOrSchedules(roleId: roleId, userId: userId);
              Provider.of<ScheduleProvider>(
                context,
                listen: false,
              ).eitherFailureOrTodaySchedules(roleId: roleId, userId: userId);
              Navigator.of(context).pop();
            } else {
              CherryToast.error(
                animationDuration: const Duration(milliseconds: 500),
                displayCloseButton: false,
                toastDuration: Duration(seconds: 2),
                animationType: AnimationType.fromTop,
                title: Text(
                  schedule!.message,
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
          text: "Add your Schedule",
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
                  const SizedBox(height: 120),
                  TextField(
                    controller: dateController,
                    cursorColor: MyColors.blackColor,
                    readOnly: true,
                    onTap: _pickDate,
                    onChanged: (v) => setState(() {}),
                    cursorHeight: 20,
                    decoration: inputDecoration(text: 'Tanggal'),
                  ),
                  mahasiswa == null
                      ? Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: textRandom(
                          text: "Tidak di temukan",
                          size: 14,
                          color: MyColors.blackColor,
                        ),
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
                                mahasiswa!.data.isEmpty
                                    ? textRandom(
                                      textAlign: TextAlign.center,
                                      text: "Not found",
                                      size: 13,
                                      color: MyColors.whiteColor,
                                    )
                                    : ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: mahasiswa!.data.length,
                                      itemBuilder:
                                          (context, index) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                mahasiswaController.text =
                                                    mahasiswa!.data[index].name
                                                        .toString();
                                                mahasiswaID =
                                                    mahasiswa!.data[index].id;
                                                show = !show;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              child: textRandom(
                                                text:
                                                    mahasiswa!.data[index].name,
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
                          controller: mahasiswaController,
                          cursorColor: MyColors.blackColor,
                          onChanged: (v) => setState(() {}),
                          cursorHeight: 20,
                          readOnly: true,
                          onTap: () => setState(() => show = !show),
                          decoration: inputDecoration(
                            text: 'Pilih Mahasiswa',
                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                        ),
                      ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: tempatController,
                    cursorColor: MyColors.blackColor,
                    onChanged: (v) => setState(() {}),
                    cursorHeight: 20,
                    decoration: inputDecoration(text: 'Tempat'),
                  ),
                  const SizedBox(height: 25),
                  buttonCustom(
                    text: load == kLoading ? "Loading..." : "Create Schedule",
                    onTap: () {
                      String userId =
                          Provider.of<UserProvider>(
                            context,
                            listen: false,
                          ).users!.Id.toString();
                      Provider.of<ScheduleProvider>(
                        context,
                        listen: false,
                      ).eitherFailureOrCreateSchedules(
                        date: date,
                        mahasiswaId: mahasiswaID.toString(),
                        tempat: tempatController.text,
                        userId: userId,
                      );
                    },
                    disable:
                        tempatController.text == "" ||
                                dateController.text == "" ||
                                mahasiswaController.text == ""
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
