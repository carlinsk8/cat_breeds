import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/setting_provider.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({super.key});
  static const id = 'setting_page';

  static Future<T?> pushNavigate<T extends Object?>(BuildContext context) {
    return Navigator.pushNamed(
      context,
      id,
    );
  }

  @override
  State<SettingPage>  createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _isDayMode = false;

  @override
  void initState() {
    final provider = context.read<SettingProvider>();
    _isDayMode = provider.isDarkMode;
    provider.getInfoDevice();
    provider.getDarkModeLocalStorage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final version = context.watch<SettingProvider>().version;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Dark Mode', style: TextStyle(fontSize: 18)),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isDayMode = !_isDayMode;
                      final provider = context.read<SettingProvider>();
                      provider.toggleDarkMode(_isDayMode);
                    });
                  },
                  child: Container(
                    width: 55,
                    height: 30,
                    padding: const EdgeInsets.all(6.0),
                    margin: const EdgeInsets.only(right: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: _isDayMode ? Colors.grey[800] : Colors.grey[400],
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      children: [
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.nightlight_round,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.wb_sunny,
                            size: 15,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        AnimatedAlign(
                          duration: const Duration(milliseconds: 300),
                          alignment: _isDayMode ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('v$version'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}