import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gamezoning/Controller/Constants/https_route_consts.dart';
import 'package:gamezoning/Model/api.dart';
import 'package:gamezoning/View/widgets/toggler.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  bool isOwner =
      true; // Add a boolean variable to track if the user is an owner or employee
  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController ownerUsernameController = TextEditingController();

    void register() async {
      if (usernameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          nameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill all the fields'),
          ),
        );
      } else if (!emailController.text.contains('@')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid email'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registering...'),
          ),
        );
        //! uploading to the server
        final route =
            isOwner // Determine the route based on the value of isOwner
                ? Constants.OWNERS_REGISTER_URL
                : Constants.EMPLOYEES_REGISTER_URL;
        final data = {
          'name': nameController.text.toString(),
          'username': usernameController.text.toString(),
          'email': emailController.text.toString(),
          'password': passwordController.text.toString(),
        };
        if (!isOwner) {
          data['owner_username'] = ownerUsernameController.text.toString();
        }
        final result = await API().postRequest(route: route, data: data);
        // print(jsonDecode(result.toString()));
        if (result.statusCode == 200) {
          print('REGISTERED INFO : $result');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registered Successfully'),
            ),
          );
          GoRouter.of(context).go('/login');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${result.body}'),
            ),
          );
        }
      }
    }

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Toggler(
                // Add a Toggler widget to toggle between owner and employee login
                labels: const ['Owner', 'Employee'],
                onToggle: (index) {
                  setState(() {
                    isOwner = index == 0;
                  });
                },
              ),
            ),
            const Icon(Icons.gamepad, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            textField(
                nameController: nameController,
                label: 'Name',
                keyType: TextInputType.name,
                icon: const Icon(Icons.person),
                hide: false),
            textField(
                nameController: usernameController,
                label: 'UserName',
                keyType: TextInputType.name,
                icon: const Icon(FontAwesomeIcons.userCheck),
                hide: false),
            textField(
                nameController: emailController,
                label: 'Email',
                keyType: TextInputType.emailAddress,
                icon: const Icon(Icons.email),
                hide: false),
            textField(
                nameController: passwordController,
                label: 'Password',
                keyType: TextInputType.visiblePassword,
                icon: const Icon(Icons.lock),
                hide: true),
            !isOwner
                ? textField(
                    nameController: ownerUsernameController,
                    label: 'Owner Username',
                    keyType: TextInputType.name,
                    icon: const Icon(FontAwesomeIcons.userTie),
                    hide: false)
                : const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () => register(),
              child: const Text(
                'Register',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('Already have an account?'),
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).go('/login');
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(child: Divider()),
                Text('Or Register with'),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    // GoRouter.of(context).go('/login');
                  },
                  icon: const FaIcon(FontAwesomeIcons.google),
                ),
                IconButton(
                  onPressed: () {
                    // GoRouter.of(context).go('/login');
                  },
                  icon: const FaIcon(FontAwesomeIcons.facebook),
                ),
                IconButton(
                  onPressed: () {
                    // GoRouter.of(context).go('/login');
                  },
                  icon: const FaIcon(FontAwesomeIcons.apple),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }

  Padding textField(
      {required TextEditingController nameController,
      required label,
      required keyType,
      required icon,
      required hide}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: nameController,
        keyboardType: keyType,
        obscureText: hide,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
