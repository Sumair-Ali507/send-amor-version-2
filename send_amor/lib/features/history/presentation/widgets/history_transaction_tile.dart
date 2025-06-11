import 'package:flutter/material.dart';
import 'package:money_transfer_app/core/theme/app_color.dart';

class HistoryTransactionTile extends StatelessWidget {
  final String amount;
  final String name;
  final String date;
  const HistoryTransactionTile(
      {super.key,
      required this.amount,
      required this.name,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5.0),
      // decoration: BoxDecoration(
      //   color: Colors.grey[900],
      //   borderRadius: BorderRadius.circular(8),
      // ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style:
                    const TextStyle(color: Color(AppColor.black), fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: const TextStyle(
                    color: Color(AppColor.lightBlack), fontSize: 12),
              ),
            ],
          ),
          Text(
            amount,
            style: TextStyle(
              color: amount.startsWith('+')
                  ? const Color(AppColor.primaryColor)
                  : const Color(AppColor.lightBlack),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
