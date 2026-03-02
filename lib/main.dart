import 'package:flutter/material.dart';
import 'package:flutter_application_1/Pages/Splash_Screen.dart';
import 'package:flutter_application_1/Provider/Addres_Provider.dart';
import 'package:flutter_application_1/Provider/App_State_Provider.dart';
import 'package:flutter_application_1/Provider/AuthProvider.dart';
import 'package:flutter_application_1/Provider/Cart_Provider.dart';
import 'package:flutter_application_1/Provider/Provider_Layanan.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppStateProvider()..loadAppState(),
        ),
        ChangeNotifierProvider(create: (_) => AuthProvider()..loadAuth()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProviderLayanan()),
        ChangeNotifierProvider(create: (_) => AddressProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: Color(0xffffffff),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xffffffff),
            surfaceTintColor: Color(0xffffffff),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
