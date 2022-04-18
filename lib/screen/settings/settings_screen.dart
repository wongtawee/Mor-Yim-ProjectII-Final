import 'package:moryim/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/setting_item_caed.dart';
import 'package:moryim/screen/theme/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: defaultPadding),
              SettingTab(
                text: "แจ้งเตือน",
                iconSrc: "assets/icons/Notificatio_box.svg",
                value: true,
                onChanged: (value) {},
              ),
              SettingTab(
                text: "Dark mode",
                iconSrc: "assets/icons/dark-theme.svg",
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  final provider =
                      Provider.of<ThemeProvider>(context, listen: false);
                  provider.toggleTheme(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
