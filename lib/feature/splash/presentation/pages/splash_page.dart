import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../breeds/presentation/pages/breeds_page.dart';
import '../../../settings/presentation/providers/setting_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _isLoaded = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<SettingProvider>(context, listen: false);
      await provider.getDarkModeLocalStorage();
      await Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          _isLoaded = true;
        });
      });
      Future.delayed(const Duration(milliseconds: 800), () {
        BreedsPage.pushNavigate(context);
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<SettingProvider>().isDarkMode;
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: _isLoaded?200:0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInLeft(
                  child: Text(('Cat Breeds').toUpperCase(), style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
                ),
                ZoomIn(child: Image.asset('assets/images/logo_cat_n.png', width: 50, color: isDark?Colors.white:null,)),
              ],
            ),
          ),
          if (!_isLoaded)
            ZoomIn(child: Image.asset('assets/images/loading.gif', width: 250)),
          if (_isLoaded)
            ZoomOut(child: Image.asset('assets/images/loading.gif', width: 250)),
        ],
      ),
   );
  }
}