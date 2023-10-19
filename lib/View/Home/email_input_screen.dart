import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/Routes/approuter.dart';
import 'package:gamezoning/View/widgets/button_widget.dart';
import 'package:gamezoning/View/widgets/textfield_widget.dart';
import 'package:go_router/go_router.dart';

class EmailInput extends ConsumerWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController emailController = TextEditingController();
    void verifyEmail() async {
      if (emailController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all the fields'),
          ),
        );
      } else if (!emailController.text.contains('@') ||
          !emailController.text.contains('.')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid email'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sending you a link...'),
          ),
        );
        //! uploading to the server
        context.push(AppRouter.resetPasswordPath);
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
              const Text('Enter Your Email',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              textField(
                  nameController: emailController,
                  label: 'Enter Your Email',
                  keyType: TextInputType.emailAddress,
                  icon: const Icon(Icons.email),
                  hide: false),
              const SizedBox(height: 20),
              buttonWidget(
                  OnTap: () => verifyEmail(),
                  title: 'Send Me Link',
                  context: context)
            ],
          ),
        ),
      ),
    );
  }
}
