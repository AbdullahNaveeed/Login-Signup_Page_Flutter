import 'package:flutter/material.dart';
import 'package:login_signup_page/Notification.dart';
import 'package:login_signup_page/Profile.dart';
import 'package:login_signup_page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreenPage extends StatefulWidget {
  static const String id = 'chat_Screen';
  const ChatScreenPage({super.key});

  @override
  State<ChatScreenPage> createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  String? email = ' ';
  String? name = ' ';
  @override
  void initState() {
    _loadLoginDetails();
    super.initState();
  }

  Future<void> _loadLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email')!;
      name = prefs.getString('name')!;
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs
        .clear(); // This clears all saved preferences including login status
    Navigator.pushReplacementNamed(
        context, loginPageScreen.id); // Navigate back to login screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              // currentAccountPictureSize: Size(50, 50),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(
                  name![0].toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              accountName: Text(
                name!,
                style: const TextStyle(fontSize: 20),
              ),
              accountEmail: Text(email!, style: TextStyle(fontSize: 12)),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ProfilePageScreen.id);
              },
              leading: const Icon(Icons.supervised_user_circle_sharp),
              title: const Text("Profile"),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, NotificationPage.id);
              },
              leading: const Icon(Icons.notifications),
              title: const Text("Notification"),
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ChatScreenPage.id);
              },
              leading: const Icon(Icons.chat_outlined),
              title: const Text("Chats"),
            ),
            ListTile(
              onTap: () {
                _logout();
                Navigator.pushNamed(context, loginPageScreen.id);
              },
              leading: const Icon(Icons.logout),
              title: const Text("Log Out"),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return const ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(
                'A',
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text("Abdullah"),
            subtitle: Text(
              "Hello",
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Text('3:01'),
          );
        },
      ),
    );
  }
}
