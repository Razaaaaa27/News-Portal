import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'formlogin.dart';
import 'formregist.dart';
import 'main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  late Future<String?> _loginFuture;
  
  @override
  void initState() {
    super.initState();
    _loginFuture = getUsername();
  }
  
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }
  
  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('token');
    Fluttertoast.showToast(msg: 'Berhasil logout');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => MyApp(initialPage: 2)),
    );
  }
  
  Widget belumLogin() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.account_circle, size: 150, color: Colors.blue),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => LoginPage()),
            );
          },
          child: Text('Masuk', style: TextStyle(color: Colors.white)),
        ),
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Belum memiliki akun? '),
            GestureDetector(
              child: Text(
                'Create Account',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegistPage()),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
  
  Widget sudahLogin(String username) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.account_circle, size: 150, color: Colors.blue),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.blue, width: 3),
          ),
          child: Text(username, style: TextStyle(fontSize: 20)),
        ),
        IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: logOut,
          color: Colors.blue,
        ),
      ],
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _loginFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        final username = snapshot.data;
        return Center(
          child: username != null ? sudahLogin(username) : belumLogin(),
        );
      },
    );
  }
}