import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vaccinator/pages/home.dart';
import 'package:vaccinator/pages/home.dart';

import '../models/child_vaccine.dart';
import '../models/vaccine.dart';
import '../providers/child_vaccine_provider.dart';

class MissedVaccineScreen extends StatefulWidget {
String id;
   MissedVaccineScreen({Key? key,required this.id}) : super(key: key);

  @override
  State<MissedVaccineScreen> createState() => _MissedVaccineScreenState();
}

class _MissedVaccineScreenState extends State<MissedVaccineScreen> {
  @override

  Widget build(BuildContext context) {

    List<ChildVaccine>missed= Provider.of<ChildVaccinesProvider>(context,listen: false).missedVaccines;
    print('sdfghgfdsasdfghgfzxcvbvcxz     '+missed.length.toString() );
    return Scaffold(
      body: SafeArea(

        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Center(
                child: Text(
                    'these are the missed  please choose the ones he has been given',textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold
                    )),
              ),
              Column(
                children: List.generate(missed.length, (index) => CheckboxListTile(
                  activeColor: Colors.green[500],
                  dense: false,
                  //font change
                  title:  Text(
                    missed[index].vaccine,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5),
                  ),
                  value:missed[index].status==1? false:true,
                  onChanged: (bool? val) {
                    setState(() {
                      if(val!)
                        missed[index].status=2;

                    });
                  },
                )),
              ),
              TextButton(onPressed: () async {
              await Provider.of<ChildVaccinesProvider>(context,listen : false).addAllChildVaccine(widget.id, missed);
               Provider.of<ChildVaccinesProvider>(context,listen : false).missedVaccines.clear();

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Home()));
              }, child: Text('save') )
            ],
          ),
        ),
      ),
    );
  }
}
