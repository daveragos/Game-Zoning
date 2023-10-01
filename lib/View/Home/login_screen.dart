// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/Constants/https_route_consts.dart';
import 'package:gamezoning/Controller/Routes/approuter.dart';
import 'package:gamezoning/Model/api.dart';
import 'package:gamezoning/Model/api_constants.dart';
import 'package:gamezoning/View/widgets/toggler.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    void login() async {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please fill all the fields'),
          ),
        );
      } else if (!emailController.text.contains('@') ||
          !emailController.text.contains('.')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid email'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logging You In...'),
          ),
        );
        //! uploading to the server
        final result =
            await API().postRequest(route: Constants.OWNERS_LOGIN_URL, data: {
          'email': emailController.text.toString(),
          'password': passwordController.text.toString(),
        });
        // print(jsonDecode(result.toString()));
        if (result.statusCode == 200) {
          GoRouter.of(context).go(AppRouter.employeeHomePath);
          //! storing the login info of the user to local db
          SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString(AppConstants.STORAGE_USER_PROFILE_KEY,
              result.data['user'].toString());
          await pref.setString(AppConstants.STORAGE_USER_PROFILE_TOKEN,
              result.data['token'].toString());
          await pref.setString(AppConstants.STORAGE_USER_PROFILE_LABEL,
              result.data['label'].toString());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.data['message']),
            ),
          );
        } else {
          GoRouter.of(context).go(AppRouter.loginPath);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: ${result.body}'),
          ));
        }
      }
    }

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Toggler(),
              SizedBox(height: 20),
              Icon(Icons.gamepad, size: 100, color: Colors.green),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    labelText: 'email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => login(),
                child: Text('Login'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: Text('Forgot Password?'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => context.go(AppRouter.registerPath),
                  child: Text('already have an account'))
            ],
          ),
        ),
      ),
    );
  }
}
