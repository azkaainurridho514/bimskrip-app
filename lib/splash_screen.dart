import 'package:bimskrip/features/dashboard/presentation/provider/dashboard_provider.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/mahasiswa_by_dosen_provider.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/name_provider.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/progres_provider.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/schedule_provider.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/user_provider.dart';
import 'package:bimskrip/utils/colors.dart';
import 'package:bimskrip/utils/constraint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/boarding/login.dart';
import 'features/dashboard/presentation/pages/layout.dart';
import 'features/dashboard/presentation/provider/dropdown_provider.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashboardProvider>(
        context,
        listen: false,
      ).eitherFailureOrDashboard();
      Provider.of<UserProvider>(
        context,
        listen: false,
      ).eitherFailureOrGetUserLocal(context);
      Provider.of<DropdownProvider>(
        context,
        listen: false,
      ).eitherFailureOrDosen();
      Provider.of<DropdownProvider>(
        context,
        listen: false,
      ).eitherFailureOrMahasiswa();
      Provider.of<NameProvider>(
        context,
        listen: false,
      ).eitherFailureOrProgressName();
      Provider.of<NameProvider>(
        context,
        listen: false,
      ).eitherFailureOrStatusName();
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) {
          if (Provider.of<UserProvider>(context, listen: false).users!.Id !=
              0) {
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
            if (roleId == kRoleDosen.toString()) {
              Provider.of<MahasiswaByDosenProvider>(
                context,
                listen: false,
              ).eitherFailureOrGetMahasiswaByDosen(id: int.parse(userId));
            }
            Provider.of<ProgresProvider>(
              context,
              listen: false,
            ).eitherFailureOrProgress(roleId: roleId, userId: userId);
            Provider.of<ScheduleProvider>(
              context,
              listen: false,
            ).eitherFailureOrSchedules(roleId: roleId, userId: userId);
            Provider.of<ScheduleProvider>(
              context,
              listen: false,
            ).eitherFailureOrTodaySchedules(roleId: roleId, userId: userId);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LayoutPage()),
              (Route<dynamic> route) => false,
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          }
        }
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller.drive(Tween(begin: 0.0, end: 1.0)),
      child: Scaffold(
        backgroundColor: MyColors.primaryColor,
        body: Center(
          child: CircularProgressIndicator(color: MyColors.forthColor),
        ),
      ),
    );
  }
}
