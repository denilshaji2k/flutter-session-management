import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://qtnmglbptruyumgjswpx.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF0bm1nbGJwdHJ1eXVtZ2pzd3B4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzc0NDI3OTksImV4cCI6MjA1MzAxODc5OX0.sF9E7sC0dpRStE7ME6GAoav-4hGhXlxn3DDx9mam98k',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<bool>(
        future: AuthService().hasValidSession(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return snapshot.data == true
              ? const HomeScreen()
              : const AuthScreen();
        },
      ),
    );
  }
}
