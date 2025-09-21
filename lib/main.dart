import 'package:bimskrip/features/dashboard/presentation/provider/dashboard_provider.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/dropdown_provider.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/login_provider.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/mahasiswa_by_dosen_provider.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/name_provider.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/progres_provider.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/schedule_provider.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/selected_page_provider.dart';
import 'package:bimskrip/features/dashboard/presentation/provider/user_provider.dart';
import 'package:bimskrip/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SelectedPageProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => DropdownProvider()),
        ChangeNotifierProvider(create: (context) => ProgresProvider()),
        ChangeNotifierProvider(create: (context) => NameProvider()),
        ChangeNotifierProvider(create: (context) => MahasiswaByDosenProvider()),
        ChangeNotifierProvider(create: (context) => ScheduleProvider()),
        ChangeNotifierProvider(create: (context) => DashboardProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BimSkrip',
        home: SplashScreenPage(),
      ),
    );
  }
}
