import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:vaccinator/providers/vaccine_provider.dart';
import 'package:vaccinator/services/database_methods.dart';

import '../models/child.dart';
import 'event_provider.dart';





class ChildrenProvider with ChangeNotifier {
  List<Child> children = [];


  addChild(Child child) async {
    try {
    DatabaseMethods().addChild(child);
      children.add(child);
      return true;
    } catch (e) {
      return e;
    }
  }
  Future <void>fetchChildren()async{
  children=await  DatabaseMethods().fetchChildernbase();

  }

}
