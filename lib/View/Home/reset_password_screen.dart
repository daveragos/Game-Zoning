import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/Routes/approuter.dart';
import 'package:gamezoning/View/widgets/button_widget.dart';
import 'package:gamezoning/View/widgets/textfield_widget.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    TextEditingController tokenController = TextEditingController();
    void verifyPassword() async {
      if (passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty ||
          tokenController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all the fields'),
          ),
        );
      } else if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Passwords do not match'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Resetting your password...'),
          ),
        );
        //! uploading to the server
        context.go(AppRouter.loginPath);
      }
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Icon(Icons.gamepad, size: 100, color: Colors.green),
              const SizedBox(height: 20),
              const Text('Reset Your Password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              textField(
                  nameController: tokenController,
                  label: 'Enter your token from email',
                  keyType: TextInputType.text,
                  icon: const Icon(Icons.token),
                  hide: false),
              textField(
                  nameController: passwordController,
                  label: 'Enter new password',
                  keyType: TextInputType.visiblePassword,
                  icon: const Icon(Icons.lock),
                  hide: true),
              textField(
                  nameController: confirmPasswordController,
                  label: 'Confrim new password',
                  keyType: TextInputType.visiblePassword,
                  icon: const Icon(Icons.lock_reset),
                  hide: true),
              const SizedBox(height: 20),
              buttonWidget(
                  OnTap: () => verifyPassword(),
                  title: 'Send Me Link',
                  context: context)
            ],
          ),
        ),
      ),
    );
  }
}
