import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/item_model.dart';
import 'controllers/item_controller.dart';
import 'controllers/theme_controller.dart';
import 'pages/home_page.dart';
import 'services/notification_service.dart';

late Box<ItemModel> itemBox;

/// 🔥 CONTROLADORES GLOBAIS
final itemController = ItemController();
final themeController = ThemeController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🔥 Inicializa Hive
  await Hive.initFlutter();
  Hive.registerAdapter(ItemModelAdapter());
  itemBox = await Hive.openBox<ItemModel>('items');

  /// 🔔 Inicializa Notificações
  await NotificationService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeController,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Stocks',
          themeMode: themeController.themeMode,

          /// 🌞 TEMA CLARO
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorSchemeSeed: const Color(0xFF0D47A1),
            scaffoldBackgroundColor: const Color(0xFFF4F6F8),

            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF0D47A1),
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
                color: Colors.white,
              ),
            ),

            floatingActionButtonTheme:
                const FloatingActionButtonThemeData(
              backgroundColor: Color(0xFF0D47A1),
              foregroundColor: Colors.white,
            ),

            tabBarTheme: const TabBarThemeData(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.white,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),

          /// 🌙 TEMA ESCURO
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.blue,
            scaffoldBackgroundColor: const Color(0xFF121212),

            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF0A1F44),
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
                color: Colors.white,
              ),
            ),

            floatingActionButtonTheme:
                const FloatingActionButtonThemeData(
              backgroundColor: Color(0xFF0D47A1),
              foregroundColor: Colors.white,
            ),

            tabBarTheme: const TabBarThemeData(
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.white,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),

          home: const HomePage(),
        );
      },
    );
  }
}
