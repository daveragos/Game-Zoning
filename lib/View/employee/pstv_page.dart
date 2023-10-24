import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TVCounterPage extends StatefulWidget {
  const TVCounterPage({Key? key}) : super(key: key);

  @override
  State<TVCounterPage> createState() => _TVCounterPageState();
}

class _TVCounterPageState extends State<TVCounterPage> {
  late SharedPreferences _prefs;
  int tv1 = 0;
  int tv2 = 0;
  int tv3 = 0;
  int tv4 = 0;
  int tv5 = 0;

  @override
  void initState() {
    super.initState();
    _loadCounterState();
  }

  Future<void> _loadCounterState() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      tv1 = _prefs.getInt('tv1') ?? 0;
      tv2 = _prefs.getInt('tv2') ?? 0;
      tv3 = _prefs.getInt('tv3') ?? 0;
      tv4 = _prefs.getInt('tv4') ?? 0;
      tv5 = _prefs.getInt('tv5') ?? 0;
    });
  }

  Future<void> _saveCounterState() async {
    await _prefs.setInt('tv1', tv1);
    await _prefs.setInt('tv2', tv2);
    await _prefs.setInt('tv3', tv3);
    await _prefs.setInt('tv4', tv4);
    await _prefs.setInt('tv5', tv5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          int? tv;
          switch (index) {
            case 0:
              tv = tv1;
              break;
            case 1:
              tv = tv2;
              break;
            case 2:
              tv = tv3;
              break;
            case 3:
              tv = tv4;
              break;
            case 4:
              tv = tv5;
              break;
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Icon(FontAwesomeIcons.tv,
                      size: 100, color: Theme.of(context).primaryColor),
                  Positioned(
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '$tv',
                        style: const TextStyle(
                          fontSize: 60,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        switch (index) {
                          case 0:
                            tv1 = 0;
                            break;
                          case 1:
                            tv2 = 0;
                            break;
                          case 2:
                            tv3 = 0;
                            break;
                          case 3:
                            tv4 = 0;
                            break;
                          case 4:
                            tv5 = 0;
                            break;
                        }
                        _saveCounterState();
                      });
                    },
                    icon: const Icon(FontAwesomeIcons.xmark),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        switch (index) {
                          case 0:
                            tv1++;
                            break;
                          case 1:
                            tv2++;
                            break;
                          case 2:
                            tv3++;
                            break;
                          case 3:
                            tv4++;
                            break;
                          case 4:
                            tv5++;
                            break;
                        }
                        _saveCounterState();
                      });
                    },
                    icon: const Icon(FontAwesomeIcons.plus),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
