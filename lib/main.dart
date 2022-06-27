import 'package:flutter/material.dart';
import 'package:flutter_contact_application_1/my_icons_icons.dart';
import 'contact.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';
// import 'package:share/share.dart';

void main() => runApp(MaterialApp(
      home: ContactList(),
    ));

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  int index = 0;
  final controller = ScrollController();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  List<Contact> contactList = [
    //Contact information list...
    Contact(
        user: 'Chan Saw Lin',
        phone: 0152131113,
        dateTime: DateTime.parse("2021-06-30 16:10:05")),
    Contact(
        user: 'Lee Saw Loy',
        phone: 0161231346,
        dateTime: DateTime.parse("2019-07-11 15:39:59")),
    Contact(
        user: 'Khaw Tong Lin',
        phone: 0158398109,
        dateTime: DateTime.parse("2020-08-19 11:10:18")),
    Contact(
        user: 'Lim Kok Lin',
        phone: 0168279101,
        dateTime: DateTime.parse("2020-08-19 11:11:35")),
    Contact(
        user: 'Low Jun Wei',
        phone: 0112731912,
        dateTime: DateTime.parse("2020-08-15 13:00:05")),
    Contact(
        user: 'Yong Weng Kai',
        phone: 0172332743,
        dateTime: DateTime.parse("2020-07-31 18:10:11")),
    Contact(
        user: 'Jayden Lee',
        phone: 0191236439,
        dateTime: DateTime.parse("2020-08-22 08:10:38")),
    Contact(
        user: 'Kong Kah Yan',
        phone: 0111931233,
        dateTime: DateTime.parse("2020-07-11 12:00:00")),
    Contact(
        user: 'Jasmine Lau',
        phone: 0162879190,
        dateTime: DateTime.parse("2020-08-01 12:10:05")),
    Contact(
        user: 'Chan Saw Lin',
        phone: 016783239,
        dateTime: DateTime.parse("2020-08-23 11:59:05")),
  ];

  @override
  Widget build(BuildContext context) {
    //The application content or architecture...
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 15, 15),
      appBar: AppBar(
        title: Text('Contact List'),
        titleTextStyle: TextStyle(
          letterSpacing: 1.0,
          fontSize: 25.0,
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 68, 63, 63),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshlist,
        child: ListView(
          controller: controller,
          children:
              contactList.map((Contact) => contactTemplate(Contact)).toList(),
        ),
      ),
    );
  }

  Widget contactTemplate(Contact) {
    //For contact display template...
    return Card(
      margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              Contact.user,
              style: const TextStyle(
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Color.fromARGB(255, 26, 24, 24),
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              '0' + Contact.phone.toString(),
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              Jiffy(Contact.dateTime).fromNow(),
              textAlign: TextAlign.end,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                fontSize: 14.0,
                color: Colors.grey[800],
              ),
            ),
            IconButton(
              alignment: Alignment.topRight,
              onPressed: () {},
              icon: const Icon(MyIcons.share_variant_outline),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    controller.addListener(listenScrolling);
  }

  void listenScrolling() {
    //To detect the scrolling position and to display a toast message...
    if (controller.position.atEdge) {
      final isTop = controller.position.pixels == 0;

      if (!isTop) {
        Fluttertoast.showToast(
          msg: "You have reached end of the list",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[900],
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  // void _shareContent() {

  // }

  Future<void> refreshlist() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));
    contactList.shuffle();
    setState(() {});
  }
}
