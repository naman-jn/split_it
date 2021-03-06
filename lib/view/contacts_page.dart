import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:split_it/constants.dart';
import 'package:split_it/models/contactList.dart';

class ContactsPage extends StatefulWidget {
  ContactsPage({Key key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    final contactsList = Provider.of<ContactList>(context);

    if (contactsList.contacts == null) {
      return CircularProgressIndicator();
    }

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
            kBlueDark,
            kBlue1,
          ])),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: kGrey1,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          padding: EdgeInsets.all(15),
          child: Center(
              child: RefreshIndicator(
            onRefresh: () async {
              await contactsList.refresh();
            },
            child: Column(
              children: [
                Text('My Contacts',
                    style: TextStyle(
                        color: kMidnight,
                        fontWeight: FontWeight.w600,
                        fontSize: 21)),
                Expanded(
                  child: ListView(
                    children: [
                      ...contactsList.contacts.map((e) => ListTile(
                            leading: Icon(
                              Icons.person_outline,
                              size: 30,
                            ),
                            title: Text(e.name),
                            subtitle: Text(e.mobile),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
