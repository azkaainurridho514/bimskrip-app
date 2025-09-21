import 'package:bimskrip/features/dashboard/presentation/provider/progres_provider.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/user_provider.dart';
import 'package:bimskrip/utils/constraint.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../main.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/widgets.dart';
import '../../data/models/progres_model.dart';

class DetailProgress extends StatefulWidget {
  final String text;
  final String progress;
  final String statusID;
  final String file;
  final String comment;
  final String id;
  const DetailProgress({
    super.key,
    required this.text,
    required this.progress,
    required this.statusID,
    required this.id,
    required this.file,
    required this.comment,
  });

  @override
  State<DetailProgress> createState() => _DetailProgressState();
}

class _DetailProgressState extends State<DetailProgress> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    super.initState();
  }

  ProgresCreateModel? progress;

  @override
  Widget build(BuildContext context) {
    var load = Provider.of<ProgresProvider>(context).isLoadingCreate;
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
              Navigator.of(context).pop();
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
        title: textRandom(text: "Detail", size: 14, color: MyColors.blackColor),
        backgroundColor: MyColors.forthColor,
      ),
      backgroundColor: MyColors.forthColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            textRandom(
              text: widget.progress,
              size: 18,
              color: MyColors.blackColor,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10),
            textRandom(
              text: widget.text,
              size: 14,
              color: MyColors.blackColor,
              fontWeight: FontWeight.w400,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 500,
              child: SfPdfViewer.network(
                widget.file,
                key: _pdfViewerKey,
                controller: _pdfViewerController,
                onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                  print(
                    'Document loaded: ${details.document.pages.count} pages',
                  );
                },
                onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                  CherryToast.error(
                    description: textRandom(
                      text: "Can't load PDF",
                      size: 12,
                      color: MyColors.blackColor,
                      fontWeight: FontWeight.w400,
                    ),
                  );
                },
                onPageChanged: (PdfPageChangedDetails details) {
                  print('Page changed: ${details.newPageNumber}');
                },
              ),
            ),
            const SizedBox(height: 10),
            widget.comment != ""
                ? textRandom(
                  text: widget.comment,
                  size: 14,
                  color: MyColors.blackColor,
                  fontWeight: FontWeight.w400,
                )
                : const SizedBox(),
          ],
        ),
      ),
      floatingActionButton:
          Provider.of<UserProvider>(context, listen: false).users!.RoleId ==
                  kRoleMahasiswa
              ? const SizedBox()
              : GestureDetector(
                onTap: () {
                  showEditStatusBottomSheet(
                    context: context,
                    currentStatusId: int.parse(widget.statusID),
                    onSubmit: (selectedStatusId) {
                      showCommentBottomSheet(
                        context: context,
                        currentStatusId: selectedStatusId,
                        onSubmit: (selectedStatusId, comment) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            Provider.of<ProgresProvider>(
                              context,
                              listen: false,
                            ).eitherFailureOrUpdateProgress(
                              id: widget.id.toString(),
                              comment: comment,
                              statusId: selectedStatusId.toString(),
                            );
                          });
                        },
                      );
                    },
                  );
                },
                child: Container(
                  width: 50,
                  height: 50,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: MyColors.primaryColor,
                  ),
                  child: Icon(Icons.edit, color: MyColors.whiteColor),
                ),
              ),
    );
  }

  void showEditStatusBottomSheet({
    required BuildContext context,
    required int currentStatusId,
    required Function(int selectedStatusId) onSubmit,
  }) {
    final List<Map<String, dynamic>> statusList = [
      {"id": 2, "label": "Diterima"},
      {"id": 3, "label": "Ditolak"},
    ];

    int selectedId = currentStatusId;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: MyColors.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 24,
                bottom: 32,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Ubah Status",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ...statusList.map((status) {
                    return RadioListTile<int>(
                      value: status['id'],
                      groupValue: selectedId,
                      title: Text(status['label']),
                      onChanged: (value) {
                        setState(() {
                          selectedId = value!;
                        });
                      },
                    );
                  }),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedId != 2 || selectedId != 3
                                ? Colors.grey[300]
                                : MyColors.primaryColor,
                        foregroundColor:
                            selectedId != 2 || selectedId != 3
                                ? Colors.grey[600]
                                : Colors.white,
                      ),
                      onPressed: () {
                        if (selectedId == 2 || selectedId == 3) {
                          onSubmit(selectedId);
                        }
                      },
                      child: const Text("Lanjutkan"),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showCommentBottomSheet({
    required BuildContext context,
    required int currentStatusId,
    required Function(int selectedStatusId, String comment) onSubmit,
  }) {
    int selectedId = currentStatusId;
    final TextEditingController comment = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: MyColors.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              constraints: BoxConstraints(
                maxHeight:
                    MediaQuery.of(context).size.height *
                    0.9, // ✅ Max tinggi 90%
              ),
              child: SingleChildScrollView(
                // ✅ Bisa di-scroll
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 24,
                    bottom: 32 + MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Komentar",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: comment,
                        cursorColor: MyColors.blackColor,
                        onChanged: (v) => setState(() {}),
                        cursorHeight: 20,
                        maxLines: 3,
                        decoration: inputDecoration(text: 'Komentar'),
                        autofocus: true,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                comment.text.trim().isEmpty
                                    ? Colors.grey[300]
                                    : MyColors.primaryColor,
                            foregroundColor:
                                comment.text.trim().isEmpty
                                    ? Colors.grey[600]
                                    : Colors.white,
                          ),
                          onPressed:
                              comment.text.trim().isEmpty
                                  ? null
                                  : () {
                                    onSubmit(selectedId, comment.text);
                                  },
                          child: const Text("Simpan"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // void showCommentBottomSheet({
  //   required BuildContext context,
  //   required int currentStatusId,
  //   required Function(int selectedStatusId, String comment) onSubmit,
  // }) {
  //   int selectedId = currentStatusId;
  //   final TextEditingController comment = TextEditingController();
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     backgroundColor: MyColors.whiteColor,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //     ),
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return Padding(
  //             padding: const EdgeInsets.only(
  //               left: 16,
  //               right: 16,
  //               top: 24,
  //               bottom: 32,
  //             ),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 const Text(
  //                   "Komentar",
  //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //                 ),
  //                 TextField(
  //                   controller: comment,
  //                   keyboardType: TextInputType.emailAddress,
  //                   cursorColor: MyColors.blackColor,
  //                   onChanged: (v) => setState(() {}),
  //                   cursorHeight: 20,
  //                   decoration: inputDecoration(text: 'Komentar'),
  //                 ),
  //                 const SizedBox(height: 16),
  //                 SizedBox(
  //                   width: double.infinity,
  //                   child: ElevatedButton(
  //                     onPressed: () {
  //                       onSubmit(selectedId, comment.text);
  //                     },
  //                     child: const Text("Simpan"),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
}
