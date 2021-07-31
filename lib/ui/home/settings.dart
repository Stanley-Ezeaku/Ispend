import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  static String me = '\$';
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    loadSharedPreferencesAndData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset('assets/images/settings.svg'),
      color: Colors.white,
      onPressed: () {
        // _showDialog();
        // Navigator.of(context)
        //(     .pushNamed(BuildingFunctionality.routeName);

        showCurrencyPicker(
          context: context,
          showFlag: true,
          showCurrencyName: true,
          showCurrencyCode: true,
          onSelect: (Currency currency) {
            editItem(currency.symbol);
          },
        );
      },
    );
  }

  void loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  void loadData() {
    String listString = sharedPreferences.getString('list');

    setState(() {
      Settings.me = listString;
    });
  }

  void saveData() {
    sharedPreferences.setString('list', Settings.me);
  }

  void editItem(String title) {
    Settings.me = title;
    saveData();
  }
}
