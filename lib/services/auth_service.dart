import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;
  final prefs = SharedPreferences.getInstance();

  Future<bool> hasValidSession() async {
    // final session = supabase.auth.currentSession;
    final pref = await prefs;
    final storedToken = pref.getString('access_token');
    
    return storedToken != null;
        // return session != null && storedToken != null;

  }

  Future<void> signUp(String email, String password) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
    );
    
    if (response.user != null) {
      final pref = await prefs;
      await pref.setString('access_token', response.session!.accessToken);
    }
  }

  Future<void> signIn(String email, String password) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
    
    if (response.user != null) {
      final pref = await prefs;
      await pref.setString('access_token', response.session!.accessToken);
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
    final pref = await prefs;
    await pref.remove('access_token');
  }
}