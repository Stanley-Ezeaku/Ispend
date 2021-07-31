import 'package:flutter/material.dart';

import 'package:ispend/size_config.dart';

class BuildingFunctionality extends StatelessWidget {
  static const routeName = '/building_functionality';

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    // HomeScreen with the Scaffold and body
    return Scaffold(
      appBar: AppBar(
        title: Text('Building Functionality'),
      ),
      body: Center(child: Text('data')),
    );
  }
}
