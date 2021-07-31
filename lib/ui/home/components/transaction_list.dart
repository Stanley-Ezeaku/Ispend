import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ispend/providers/transactions.dart';
import 'package:ispend/size_config.dart';
import 'package:ispend/ui/home/components/transaction_item.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final transactionDate = Provider.of<Transactions>(
    //   context,
    //   listen: false,
    // );
    // final transaction = transactionDate.transactions;

    return FutureBuilder(
      future: Provider.of<Transactions>(context, listen: false)
          .fetchAndsetTransactions(),
      builder: (ctx, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? SliverToBoxAdapter(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Consumer<Transactions>(
              builder: (
                ctx,
                transaction,
                childreceived,
              ) =>
                  transaction.transactions.isEmpty
                      ? childreceived
                      : SliverPadding(
                          padding: EdgeInsets.all(10),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => TransactionItem(
                                  key: ValueKey(
                                      transaction.transactions[index].id),
                                  transaction: transaction.transactions[index],
                                  deletetransaction:
                                      transaction.deleteTransaction),
                              childCount: transaction.transactions.length,
                            ),
                          ),
                        ),
              child: SliverPadding(
                padding: EdgeInsets.all(10),
                sliver: SliverMine(
                  child: Column(
                    children: [
                      Text(
                        'No Expenditure',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Container(
                        child: SvgPicture.asset('assets/images/empty_cart.svg'),
                        height: SizeConfig.availableHeight * 0.5,
                        width: SizeConfig.availableWidth * 0.6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

// this class is use to render the Icons in the SliverAppBar
class SliverMine extends SingleChildRenderObjectWidget {
  SliverMine({Widget child, Key key}) : super(child: child, key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSliverMine();
  }
}

// RenderSliver for SlliverMine
class RenderSliverMine extends RenderSliverSingleBoxAdapter {
  RenderSliverMine({
    RenderBox child,
  }) : super(child: child);

  @override
  void performLayout() {
    if (child == null) {
      geometry = SliverGeometry.zero;
      return;
    }
    final SliverConstraints constraints = this.constraints;
    child.layout(constraints.asBoxConstraints(), parentUsesSize: true);
    double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child.size.width;
        break;
      case Axis.vertical:
        childExtent = child.size.height;
        break;
    }
    assert(childExtent != null);
    final double paintedChildSize =
        calculatePaintOffset(constraints, from: 0.0, to: childExtent);
    final double cacheExtent =
        calculateCacheOffset(constraints, from: 0.0, to: childExtent);

    assert(paintedChildSize.isFinite);
    assert(paintedChildSize >= 0.0);
    geometry = SliverGeometry(
      scrollExtent: childExtent,
      paintExtent: paintedChildSize,
      cacheExtent: cacheExtent,
      maxPaintExtent: childExtent,
      hitTestExtent: paintedChildSize,
      hasVisualOverflow: childExtent > constraints.remainingPaintExtent ||
          constraints.scrollOffset > 0.0,
    );
    setChildParentData(child, constraints, geometry);
  }
}
