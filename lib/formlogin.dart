import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  late FToast fToast;
  bool isLoading = false;
  
  @override
  void initState() {
    super.initState();
    fToast = FToast()..init(context);
  }
  
  Future<void> loginUser(String username, String password) async {
    setState(() => isLoading = true);
    final url = Uri.parse("https://e-commerce-store.glitch.me/login");
    
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );
      
      final statusCode = response.statusCode;
      final body = jsonDecode(response.body);
      
      if (statusCode == 200 && body['status'] == true) {
        final user = body['data']['user'];
        final token = body['data']['token'];
        
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', user['username']);
        await prefs.setString('token', token);
        
        showToast("Login berhasil", isSuccess: true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MyApp(initialPage: 0)),
        );
      } else {
        showToast(
          "Login gagal: ${body['message'] ?? 'Username atau password salah'}",
        );
      }
    } catch (e) {
      showToast("Kesalahan jaringan: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }
  
  void showToast(String message, {bool isSuccess = false}) {
    fToast.showToast(
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: isSuccess ? Colors.green : Colors.redAccent,
        ),
        child: Text(message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: userController,
                  decoration: InputDecoration(labelText: "Username"),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "Password"),
                ),
                SizedBox(height: 20),
                isLoading
                  ? CircularProgressIndicator()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          child: Text("Back"),
                        ),
                        SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            final username = userController.text.trim();
                            final password = passController.text.trim();
                            if (username.isEmpty || password.isEmpty) {
                              showToast("Harap isi semua kolom");
                            } else {
                              loginUser(username, password);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          child: Text("Login"),
                        ),
                      ],
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}