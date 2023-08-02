import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_item/tqc_data/item_data.dart';
import 'package:test_item/tqc_screens/item_grid_screen.dart';
// import 'model/model.dart';
// import 'sample_browser.dart';
import 'tqc_screens/data_grid_screen.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await updateControlItems();
//   runApp(const SampleBrowser());
// }

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
         debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ItemGridScreen(),
    );
  }
}


