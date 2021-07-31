import 'package:flutter/material.dart';
import 'package:ispend/size_config.dart';
import 'package:ispend/ui/home/components/chart_data_container.dart';
import 'package:ispend/ui/home/components/transaction_list.dart';

class SilverWidgetHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
            flexibleSpace: ChartDataContainer(),
            centerTitle: true,
            floating: true,
            snap: true,
            expandedHeight: SizeConfig.availableHeight * 0.16,
            backgroundColor: Colors.white,
            elevation: 1,
            shadowColor: Colors.green),
        TransactionList(),
      ],
    );
  }
}
