// a page that shows profile page

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamezoning/Model/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  //get info from shared preference

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late SharedPreferences preferences;
  Map<String, dynamic>? userInfoMap;

  Future<Map<String, dynamic>?> getData() async {
    try {
      preferences = await SharedPreferences.getInstance();
      final userInfo =
          preferences.getString(AppConstants.STORAGE_USER_PROFILE_INFO);
      if (userInfo != null) {
        userInfoMap = json.decode(userInfo);
        print('INFO============== $userInfoMap');
        return userInfoMap;
      } else {
        throw Exception("No data found");
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    // Use FutureBuilder for asynchronous data loading
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data as Map<String, dynamic>;
            return Card(
              margin: const EdgeInsets.all(20),
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.green[300],
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor:
                            Colors.white, // Specify the background color
                        child: Icon(
                          FontAwesomeIcons.user,
                          size: 40,
                          color: Colors.green, // Specify the icon color
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Name: ${data['name']}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Username: ${data['username']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Email: ${data['email']}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: Text('No data found.'),
            );
          }
        },
      ),
    );
  }
}
