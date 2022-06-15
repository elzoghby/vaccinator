import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:vaccinator/models/child.dart';
import 'package:vaccinator/pages/children_history_screen/component/history_item.dart';
import 'package:vaccinator/providers/childern_provider.dart';

import '../../models/child_vaccine.dart';
import '../../providers/child_vaccine_provider.dart';

class ChildrenHistoryScreen extends StatelessWidget {
  const ChildrenHistoryScreen({Key? key}) : super(key: key);
  static String id = 'historyss';

  @override
  Widget build(BuildContext context) {
    List<Child>children=Provider.of<ChildrenProvider>(context).children;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Children'),
        centerTitle: true,
      ),
      body:  ListView.builder(

          itemBuilder: (context, i)  {



            return HistoryItem(myChild:children[i].history!,birth: children[i],);},
          itemCount: children.length,
        ),

    );
  }
}
