import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vaccinator/pages/signUp_screen.dart';
import 'package:vaccinator/pages/vaccines_screen/vaccines_screen.dart';

import '../pages/about_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [

          AppBar(backgroundColor: Colors.teal,
            titleSpacing: 15,
            title: Icon(Icons.child_care_outlined,color: Colors.white,size: 35.sp),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.vaccines_outlined),
            title: Text('Vaccines'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => VaccinesScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              //FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => AboutScreen()));
            },
          ),
        ],
      ),
    );
  }
}
