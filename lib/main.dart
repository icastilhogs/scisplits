import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:scisplits/config/style.dart';
import 'package:scisplits/pages/routine_details_page.dart';

import 'pages/complete_page.dart';
import 'pages/home_page.dart';
import 'pages/player_page.dart';

void main() {
  runApp(const ProviderScope(
    child: SciSplits(),
  ));
}

class SciSplits extends StatelessWidget {
  const SciSplits({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SciSplits',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        primaryColor: CustomColors.primary,
        primarySwatch: generateMaterialColor(color: CustomColors.primary),
      ),
      onGenerateRoute: (settings) {
        final args = settings.arguments as String?;
        return MaterialPageRoute(builder: (context) {
          switch (settings.name) {
            case '/':
              return const HomePage();
            case '/routine':
              return RoutineDetailsPage(id: args!);
            case '/player':
              return const PlayerPage();
            case '/complete':
              return const CompletePage();
            default:
              return const HomePage();
          }
        });
      },
      //home: const HomePage(),
      initialRoute: '/',
      /* routes: {
        '/': (BuildContext context) => const HomePage(),
        '/routine$id': (BuildContext context) => const RoutineDetailsPage(),
        '/player': (BuildContext context) => const PlayerPage(),
        '/complete': (BuildContext context) => const CompletePage(),
      }, */
    );
  }
}
