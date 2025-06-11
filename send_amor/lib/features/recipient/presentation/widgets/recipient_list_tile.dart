import 'package:flutter/material.dart';
import 'package:money_transfer_app/common/widgets/IText.dart';
import '../../../../core/theme/app_color.dart';
import '../../../../core/utils/Utils.dart';

class RecipientListTile extends StatelessWidget {
  final String name;
  final String nickName;
  final VoidCallback onDelete;
  final Widget? trailing;
  const RecipientListTile({
    super.key,
    required this.name,
    required this.nickName,
    required this.onDelete,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: const Color(AppColor.white),
          boxShadow: [Utility.lightShadow()]),
      child: ListTile(
        leading: const CircleAvatar(
          radius: 12,
          backgroundColor: Color(
            AppColor.primaryColor,
          ),
          child: Icon(
            Icons.person,
            size: 20,
            color: Color(AppColor.white),
          ),
        ),
        title: IText(
          fontWeight: FontWeight.bold,
          content: name,
          color: const Color(
            AppColor.black,
          ),
        ),
        subtitle: IText(
          content: nickName,
          color: const Color(
            AppColor.grey,
          ),
        ),
        trailing: trailing ??
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'delete') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: const Color(AppColor.white),
                        title: const Text(
                          'Confirm Delete',
                          style: TextStyle(
                            color: Color(AppColor.black),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: const Text(
                            'Are you sure want to delete this recipient?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(color: Color(AppColor.black)),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(AppColor.white),
                              backgroundColor: const Color(AppColor.red),
                            ),
                            onPressed: () {
                              onDelete();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Color(AppColor.red)),
                    ),
                  ),
                ];
              },
              icon: const Icon(Icons.more_vert),
            ),
      ),
    );
  }
}
