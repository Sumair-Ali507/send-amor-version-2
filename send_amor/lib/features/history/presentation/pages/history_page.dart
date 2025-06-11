import 'package:flutter/material.dart';
import 'package:money_transfer_app/common/widgets/IText.dart';
import 'package:money_transfer_app/common/widgets/IVerticalSpace.dart';
import 'package:money_transfer_app/core/constants/app_texts.dart';
import 'package:money_transfer_app/core/theme/app_color.dart';
import 'package:money_transfer_app/features/history/presentation/widgets/history_transaction_tile.dart';

import '../../../../common/mixins/ts.dart';
import '../../../../core/utils/Utils.dart';


class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildTopView(),
            IVerticalSpace(),
            buildSearchBar(),
            IVerticalSpace(),
            Expanded(child: buildTransactionList())
          ],
        ),
      ),
    );
  }

  buildTopView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IText(
            content: AppTexts.activity,
            textStyle: Ts.mediumStyle(context: context),
          ),
          const CircleAvatar(
            radius: 14, // Adjust the size of the avatar
            backgroundColor: Colors.blue, // Background color of the avatar
            child: Icon(
              Icons.person_2_outlined, // Person icon
              size: 20, // Icon size
              color: Colors.white, // Icon color
            ),
          ),
        ],
      ),
    );
  }

  buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5.0),
      decoration: BoxDecoration(
          color: const Color(AppColor.white),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [Utility.lightShadow()]),
      child: const TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search Transactions',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(12),
        ),
      ),
    );
  }

  buildTransactionList() {
    return Container(
      color: const Color(AppColor.white),
      child: ListView(
        children: const [
          HistoryTransactionTile(
              amount: '\$246', name: 'Kaolin', date: 'On Jan 30, 2023'),
          HistoryTransactionTile(
              amount: '+ \$60.47',
              name: 'Jasmine Brown',
              date: 'On Jan 30, 2023'),
          HistoryTransactionTile(
              amount: '\$388', name: 'Andrew', date: 'On Jan 30, 2023'),
          HistoryTransactionTile(
              amount: '+ \$185.12', name: 'James', date: 'On Jan 30, 2023'),
          HistoryTransactionTile(
              amount: '+ \$370.25', name: 'Mitchal ', date: 'On Jan 30, 2023'),
          HistoryTransactionTile(
              amount: '\$600', name: 'Kemar Austin', date: 'On Jan 30, 2023')
        ],
      ),
    );
  }
}
