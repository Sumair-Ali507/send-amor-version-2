import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsFromPhone extends StatefulWidget {
  const ContactsFromPhone({super.key});

  @override
  State<ContactsFromPhone> createState() => _ContactsFromPhoneState();
}

class _ContactsFromPhoneState extends State<ContactsFromPhone> {
  List<Contact> contacts = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getContactPermission();
  }

  void getContactPermission() async {
    if (await Permission.contacts.isGranted) {
      // Contact Fetch
      fetchContacts();
    } else {
      await Permission.contacts.request();
      if (await Permission.contacts.isGranted) {
        fetchContacts();
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void fetchContacts() async {
    contacts = await FlutterContacts.getContacts(
        withProperties: true, withPhoto: true);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : contacts.isEmpty
          ? const Center(child: Text('No contacts found'))
          : ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              height: 30.h,
              width: 30.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    color: Colors.white.withOpacity(0.1),
                    offset: const Offset(-3, -3),
                  ),
                  BoxShadow(
                    blurRadius: 7,
                    color: Colors.black.withOpacity(0.7),
                    offset: const Offset(3, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(6.r),
                color: const Color(0xff262626),
              ),
              child: Text(
                contacts[index].displayName.isNotEmpty
                    ? contacts[index].displayName[0].toUpperCase()
                    : '?',
                style: TextStyle(
                  fontSize: 23.sp,
                  color: Colors.primaries[
                  Random().nextInt(Colors.primaries.length)],
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            title: Text(
              contacts[index].displayName.isNotEmpty
                  ? contacts[index].displayName
                  : 'Unknown',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.cyanAccent,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(
              contacts[index].phones.isNotEmpty
                  ? contacts[index].phones[0].number
                  : 'No phone number',
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xffC4c4c4),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            horizontalTitleGap: 12.w,
          );
        },
      ),
    );
  }
}
