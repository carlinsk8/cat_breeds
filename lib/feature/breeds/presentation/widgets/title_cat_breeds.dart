import '../../../settings/presentation/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../settings/presentation/providers/setting_provider.dart';

class TitleCatBreeds extends StatelessWidget {
  const TitleCatBreeds({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<SettingProvider>().isDarkMode;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(('Cat Breeds').toUpperCase(), style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        Image.asset('assets/images/logo_cat_n.png', width: 35, color: isDark?Colors.white:null,),
        const Spacer(),
        IconButton(
          onPressed: () => SettingPage.pushNavigate(context), 
          icon: const Icon(Icons.menu)
        )
      ],
    );
  }
}