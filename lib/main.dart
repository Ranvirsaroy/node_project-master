import 'package:flutter/material.dart';
import 'package:myapp/screens/Home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:myapp/provider/task_provider.dart';
void main() async{
    WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => TaskProvider(),
        child: MaterialApp(
        home: HomePage(),
        
      )
    );
  }
}