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
  int _numTVs = 5;
  final List<int> _tvCounters = [];

  @override
  void initState() {
    super.initState();
    _loadCounterState();
  }

  Future<void> _loadCounterState() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _numTVs = _prefs.getInt('numTVs') ?? 5;
      for (int i = 0; i < _numTVs; i++) {
        _tvCounters.add(_prefs.getInt('tv$i') ?? 0);
      }
    });
  }

  Future<void> _saveCounterState() async {
    await _prefs.setInt('numTVs', _numTVs);
    for (int i = 0; i < _numTVs; i++) {
      await _prefs.setInt('tv$i', _tvCounters[i]);
    }
  }

  void _addTV() {
    setState(() {
      _numTVs++;
      _tvCounters.add(0);
      _saveCounterState();
    });
  }

  void _removeTV() {
    setState(() {
      if (_numTVs > 0) {
        _numTVs--;
        _tvCounters.removeLast();
        _saveCounterState();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: _numTVs,
              itemBuilder: (context, index) {
                int? tv = _tvCounters[index];
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
                          child: Transform.translate(
                            offset: const Offset(10, -5),
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
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _tvCounters[index] = 0;
                              _saveCounterState();
                            });
                          },
                          icon: const Icon(FontAwesomeIcons.xmark),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _tvCounters[index]++;
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _removeTV,
                icon: const Icon(Icons.remove),
              ),
              IconButton(
                onPressed: _addTV,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
