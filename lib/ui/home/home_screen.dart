import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ispend/size_config.dart';
import 'package:ispend/ui/home/components/silver_widget_home.dart';
import 'package:ispend/ui/home/settings.dart';
import 'package:ispend/ui/new_transaction/new_transaction_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    void _showDialog({String message = 'Check me later'}) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Coding Functionality!!!',
          ),
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Ok'))
          ],
        ),
      );
    }

    // HomeScreen with the Scaffold and body
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text(
            //   'ISpend',
            //   style: Theme.of(context).textTheme.headline6,
            // ),
            IconButton(
              icon: SvgPicture.asset('assets/images/seo.svg'),
              color: Colors.white,
              onPressed: () {
                _showDialog(
                    message:
                        'This functionality will give you more analytic insight on your over all expense in weeks, months and years');

                // Navigator.of(context)
                //     .pushNamed(BuildingFunctionality.routeName);
              },
            ),
            IconButton(
              icon: SvgPicture.asset('assets/images/camera.svg'),
              color: Colors.white,
              onPressed: () {
                _showDialog(
                    message:
                        'This functionality will allow you to take a photo of an item with a price tag and it will be automatically added in your expenditure. This will be very handy in shoppping malls');
                // Navigator.of(context)
                //     .pushNamed(BuildingFunctionality.routeName);
              },
            ),
            IconButton(
              icon: SvgPicture.asset('assets/images/radar.svg'),
              color: Colors.white,
              onPressed: () {
                _showDialog();
                // Navigator.of(context)
                //     .pushNamed(BuildingFunctionality.routeName);
              },
            ),
            Settings(),
          ],
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        shadowColor: Colors.green,
      ),
      body: SilverWidgetHome(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(NewTransactionForm.routeName);

          // showModalBottomSheet(
          //   shape: RoundedRectangleBorder(
          //       borderRadius:
          //           BorderRadius.vertical(top: Radius.circular(25.0))),
          //   backgroundColor: Colors.white,
          //   context: context,
          //   isScrollControlled: true,
          //   builder: (context) => Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 18),
          //     child: NewTransactionDataContainer(),
          //   ),
          // );
        },
      ),
    );
  }
}
