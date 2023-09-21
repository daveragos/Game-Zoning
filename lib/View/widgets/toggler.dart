import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gamezoning/Controller/Provider/position_provider.dart';

class Toggler extends StatelessWidget {
  const Toggler({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Radio(
              fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.orange.withOpacity(.32);
                }
                return Colors.orange;
              }),
              toggleable: true,
              activeColor: Colors.red,
              value: 'owner',
              groupValue: 'userType',
              onChanged: (value) {
                ref.read(toggleProvider.notifier).setToggler(value!);
              },
            ),
            Radio(
              value: 'employee',
              groupValue: 'userType',
              onChanged: (value) {
                ref.read(toggleProvider.notifier).setToggler(value!);
                print(value);
              },
            ),
          ],
        );
      },
    );
  }
}
