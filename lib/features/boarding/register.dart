import 'package:bimskrip/features/dashboard/presentation/provider/dropdown_provider.dart';
import 'package:bimskrip/utils/colors.dart';
import 'package:bimskrip/utils/widgets.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../utils/constraint.dart';
import '../dashboard/data/models/dropdown_model.dart';
import '../dashboard/presentation/provider/login_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController photoController = TextEditingController();
  final TextEditingController pathController = TextEditingController();
  final TextEditingController registerSebagaiController =
      TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController dpaController = TextEditingController();
  int dpaID = 0;
  int roleID = 0;
  bool show = false;
  bool showDosen = false;
  @override
  void initState() {
    super.initState();
    photoController.text = "";
    pathController.text = "";
    if (Provider.of<DropdownProvider>(context, listen: false).dosen == null) {
      getDosen();
    } else if (Provider.of<DropdownProvider>(context, listen: false).dosen !=
        null) {
      Provider.of<DropdownProvider>(context, listen: false).dosen!.data.isEmpty;
      return getDosen();
    }
    if (Provider.of<DropdownProvider>(context, listen: false).mahasiswa ==
        null) {
      getMahasiswa();
    } else if (Provider.of<DropdownProvider>(
          context,
          listen: false,
        ).mahasiswa !=
        null) {
      Provider.of<DropdownProvider>(
        context,
        listen: false,
      ).mahasiswa!.data.isEmpty;
    }
  }

  void getDosen() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DropdownProvider>(
        context,
        listen: false,
      ).eitherFailureOrDosen();
    });
  }

  void getMahasiswa() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DropdownProvider>(
        context,
        listen: false,
      ).eitherFailureOrMahasiswa();
    });
  }

  bool showPass = true;
  bool showConfirmPass = true;

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    registerSebagaiController.dispose();
    super.dispose();
  }

  void pickImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        photoController.text = pickedFile.name;
        pathController.text = pickedFile.path;
      } else {
        photoController.text = "";
        pathController.text = "";
        WidgetsBinding.instance.addPostFrameCallback((_) {
          CherryToast.error(
            animationDuration: const Duration(milliseconds: 500),
            displayCloseButton: false,
            toastDuration: Duration(seconds: 2),
            animationType: AnimationType.fromTop,
            title: textRandom(
              text: "Tidak ada gambar yang dipilih",
              color: MyColors.blackColor,
              size: 11,
            ),
          ).show(context);
        });
      }
    });
  }

  void selectPickMethode() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Container(
            height: 150,
            decoration: BoxDecoration(
              color: MyColors.forthColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.secondColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            pickImage(source: ImageSource.camera);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 30,
                                color: MyColors.whiteColor,
                              ),
                              const SizedBox(height: 5),
                              textRandom(
                                text: "Camera",
                                size: 12,
                                color: MyColors.whiteColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.secondColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            pickImage(source: ImageSource.gallery);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.photo_library_outlined,
                                size: 30,
                                color: MyColors.whiteColor,
                              ),
                              const SizedBox(height: 5),
                              textRandom(
                                text: "Gallery",
                                size: 12,
                                color: MyColors.whiteColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  DropdownModel? mahasiswa;
  DropdownModel? dosen;
  @override
  Widget build(BuildContext context) {
    mahasiswa = Provider.of<DropdownProvider>(context).mahasiswa;
    dosen = Provider.of<DropdownProvider>(context).dosen;
    var load = Provider.of<LoginProvider>(context).isLoadingRegister;
    var log = Provider.of<LoginProvider>(context).register;
    if (load == kLoadStop) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (log != null) {
          if (log.statusCode == 200) {
            CherryToast.success(
              animationDuration: const Duration(milliseconds: 500),
              displayCloseButton: false,
              toastDuration: Duration(seconds: 2),
              animationType: AnimationType.fromTop,
              title: Text(log.message, style: TextStyle(color: Colors.black)),
            ).show(context);
            Navigator.of(context).pop();
          } else {
            CherryToast.error(
              animationDuration: const Duration(milliseconds: 500),
              displayCloseButton: false,
              toastDuration: Duration(seconds: 2),
              animationType: AnimationType.fromTop,
              title: Text(log.message, style: TextStyle(color: Colors.black)),
            ).show(context);
          }
        }
        Provider.of<LoginProvider>(context, listen: false).isLoadingRegister =
            kLoadNothing;
      });
    }
    return Scaffold(
      backgroundColor: MyColors.forthColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    textRandom(
                      text: "REGISTER",
                      size: 22,
                      color: MyColors.blackColor,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: usernameController,
                      cursorColor: MyColors.blackColor,
                      onChanged: (v) => setState(() {}),
                      cursorHeight: 20,
                      style: TextStyle(fontSize: 13.0),
                      decoration: inputDecoration(text: 'Username'),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: emailController,
                      cursorColor: MyColors.blackColor,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (v) => setState(() {}),
                      cursorHeight: 20,
                      style: TextStyle(fontSize: 13.0),
                      decoration: inputDecoration(text: 'Email'),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: phoneController,
                      cursorColor: MyColors.blackColor,
                      onChanged: (v) => setState(() {}),
                      cursorHeight: 20,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 13.0),
                      decoration: inputDecoration(text: 'Phone'),
                    ),
                    const SizedBox(height: 15),
                    show
                        ? GestureDetector(
                          onTap: () => setState(() => show = !show),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors.secondColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min, // Tambahan ini
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      registerSebagaiController.text =
                                          "Mahasiswa";
                                      roleID = 1;
                                      show = !show;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: textRandom(
                                      text: "Mahasiswa",
                                      size: 13,
                                      color: MyColors.whiteColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      registerSebagaiController.text = "Dosen";
                                      roleID = 2;
                                      dpaController.text = "";
                                      dpaID = 0;
                                      show = !show;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: textRandom(
                                      text: "Dosen",
                                      size: 13,
                                      color: MyColors.whiteColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      registerSebagaiController.text = "Staff";
                                      roleID = 3;
                                      dpaController.text = "";
                                      dpaID = 0;
                                      show = !show;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: textRandom(
                                      text: "Staff",
                                      size: 13,
                                      color: MyColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        : TextField(
                          controller: registerSebagaiController,
                          cursorColor: MyColors.blackColor,
                          onChanged: (v) => setState(() {}),
                          cursorHeight: 20,
                          readOnly: true,
                          onTap: () => setState(() => show = !show),
                          style: TextStyle(fontSize: 13.0),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          decoration: inputDecoration(
                            text: 'Register sebagai',
                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                          ),
                        ),
                    roleID.toString() == "1"
                        ? dosen == null
                            ? GestureDetector(
                              onTap:
                                  () => setState(() => showDosen = !showDosen),
                              child: Container(
                                margin: EdgeInsets.only(top: 15),
                                width: double.infinity,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: MyColors.secondColor,
                                ),
                                child: textRandom(
                                  text: "Dosen tidak di temukan",
                                  size: 14,
                                  color: MyColors.whiteColor,
                                ),
                              ),
                            )
                            : showDosen
                            ? Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 15),
                              child: GestureDetector(
                                onTap:
                                    () =>
                                        setState(() => showDosen = !showDosen),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColors.secondColor,
                                  ),
                                  child:
                                      dosen!.data.isEmpty
                                          ? GestureDetector(
                                            onTap:
                                                () => setState(
                                                  () => showDosen = !showDosen,
                                                ),
                                            child: Container(
                                              margin: EdgeInsets.only(top: 15),
                                              width: double.infinity,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: MyColors.secondColor,
                                              ),
                                              child: textRandom(
                                                text: "Dosen tidak di temukan",
                                                size: 14,
                                                color: MyColors.whiteColor,
                                              ),
                                            ),
                                          )
                                          : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                              dosen!.data.length,
                                              (index) => GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    dpaController.text =
                                                        dosen!.data[index].name
                                                            .toString();
                                                    dpaID =
                                                        dosen!.data[index].id;
                                                    showDosen = !showDosen;
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  child: textRandom(
                                                    text:
                                                        dosen!.data[index].name,
                                                    size: 13,
                                                    color: MyColors.whiteColor,
                                                  ),
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
                                controller: dpaController,
                                cursorColor: MyColors.blackColor,
                                onChanged: (v) => setState(() {}),
                                cursorHeight: 20,
                                readOnly: true,
                                onTap:
                                    () =>
                                        setState(() => showDosen = !showDosen),
                                style: TextStyle(fontSize: 13.0),
                                decoration: inputDecoration(
                                  text: 'Pilih Dosen',
                                  icon: Icon(Icons.keyboard_arrow_down_rounded),
                                ),
                              ),
                            )
                        : const SizedBox(),
                    const SizedBox(height: 15),
                    TextField(
                      controller: photoController,
                      cursorColor: MyColors.blackColor,
                      style: TextStyle(fontSize: 10.0),
                      onChanged: (v) => setState(() {}),
                      cursorHeight: 20,
                      readOnly: true,
                      onTap: () => selectPickMethode(),
                      decoration: inputDecoration(
                        text: 'Foto profil',
                        icon: Icon(Icons.add_a_photo_outlined),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                      cursorColor: MyColors.blackColor,
                      onChanged: (v) => setState(() {}),
                      cursorHeight: 20,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: showPass,
                      style: TextStyle(fontSize: 13.0),
                      decoration: InputDecoration(
                        labelText: "Password",
                        isDense: true,
                        suffixIcon: GestureDetector(
                          onTap: () => setState(() => showPass = !showPass),
                          child: Icon(
                            showPass
                                ? Icons.no_encryption_gmailerrorred_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: MyColors.blackColor,
                          fontSize: 12,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: MyColors.blackColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: MyColors.primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      textInputAction: TextInputAction.done,
                      controller: confirmPasswordController,
                      cursorColor: MyColors.blackColor,
                      onChanged: (v) => setState(() {}),

                      keyboardType: TextInputType.emailAddress,
                      cursorHeight: 20,
                      style: TextStyle(fontSize: 13.0),
                      obscureText: showConfirmPass,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        isDense: true,
                        suffixIcon: GestureDetector(
                          onTap:
                              () => setState(
                                () => showConfirmPass = !showConfirmPass,
                              ),
                          child: Icon(
                            showConfirmPass
                                ? Icons.no_encryption_gmailerrorred_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: MyColors.blackColor,
                          fontSize: 12,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: MyColors.blackColor,
                            width: 1,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: MyColors.primaryColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    buttonCustom(
                      text: load == kLoading ? "Loading..." : "Register",
                      onTap: () {
                        print(photoController.text);
                        print(pathController.text);
                        // Validasi password matching
                        if (passwordController.text !=
                            confirmPasswordController.text) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Password tidak cocok!")),
                          );
                          return;
                        }

                        Provider.of<LoginProvider>(
                          context,
                          listen: false,
                        ).eitherFailureOrRegister(
                          photo: pathController.text,
                          password: passwordController.text,
                          email: emailController.text,
                          dosenPaId: dpaID,
                          name: usernameController.text,
                          phone: phoneController.text,
                          roleId: roleID,
                        );
                      },
                      disable:
                          usernameController.text == "" ||
                                  emailController.text == "" ||
                                  phoneController.text == "" ||
                                  registerSebagaiController.text == "" ||
                                  passwordController.text == "" ||
                                  confirmPasswordController.text == ""
                              ? true
                              : false,
                    ),
                    const SizedBox(height: 15),
                    textRandom(
                      text: "Sudah punya akun?",
                      size: 11,
                      color: MyColors.blackColor,
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w300,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: textRandom(
                        text: "Login",
                        size: 11,
                        fontWeight: FontWeight.bold,
                        color: MyColors.blackColor,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
