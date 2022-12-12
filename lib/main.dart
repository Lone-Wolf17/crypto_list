import 'package:crypto_list/utils/router/app_router.dart';
import 'package:crypto_list/utils/router/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/app-colors.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Price List',
      theme: ThemeData(
        backgroundColor: AppColors.backgroundColor,
        primarySwatch: AppColors.generateMaterialColor(AppColors.primaryColor),
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: AppColors.primaryColor),
      ),
      navigatorKey: ref.read(navigationServiceProvider).navigationKey,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
