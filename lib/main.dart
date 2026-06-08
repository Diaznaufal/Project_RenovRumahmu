import 'package:flutter/material.dart';
import 'package:flutter_application_1/Features/Renovasi/Pages/Renovasi_Page.dart';
import 'package:flutter_application_1/Features/Auth/Pages/Splash_Screen.dart';
import 'package:flutter_application_1/Features/Address/Provider/Addres_Provider.dart';
import 'package:flutter_application_1/Core/service/App_State_Provider.dart';
import 'package:flutter_application_1/Features/Auth/Provider/AuthProvider.dart';
import 'package:flutter_application_1/Features/Keranjang/Provider/Cart_Provider.dart';
import 'package:flutter_application_1/Features/Checkout/Providers/Order_Provider.dart';
import 'package:flutter_application_1/Features/Material/Provider/Product_provider.dart';
import 'package:flutter_application_1/Features/Home/Provider/Provider_Layanan.dart';
import 'package:flutter_application_1/Features/Renovasi/Providers/Renovasi_Provider.dart';
import 'package:flutter_application_1/Features/RiwayatPesanan/Provider/Riwayat_Provider.dart';
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
        ChangeNotifierProvider(create: (_) => RiwayatProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(
          create: (_) => RenovasiProvider(),
          child: RenovasiPage(),
        ),
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
