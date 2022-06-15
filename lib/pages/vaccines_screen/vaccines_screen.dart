import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:vaccinator/providers/vaccine_provider.dart';



import 'component/vaccines_item.dart';

class VaccinesScreen extends StatelessWidget {
  const VaccinesScreen({Key? key}) : super(key: key);
  static String id = 'Vaccines_screen';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
backgroundColor: Colors.teal,
        title: const Text('Vaccines'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Provider.of<Vaccines>(context,listen: false).getVaccines(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {

            return const Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent));
          } else if (snapshot.hasError) {
            return Center(child: Text('an error occured${snapshot.error}'));
          } else {


            return Consumer<Vaccines>(
              builder: (c, vaccine, child) => ListView.builder(
                itemBuilder: (context, i) => VaccinesItem(vaccine.vaccines[i]),
                itemCount: vaccine.vaccines.length,
              ),
            );
          }
        },
      ),


    );
  }
}
