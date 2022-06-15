import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vaccinator/models/child.dart';
import 'package:vaccinator/models/vaccine.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vaccinator/providers/child_vaccine_provider.dart';

import '../../../models/child_vaccine.dart';


class HistoryItem extends StatefulWidget {

   HistoryItem({Key? key ,required this.myChild,required this.birth}) : super(key: key);
   List <ChildVaccine> myChild;
   Child birth;
  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
   bool expand = false;

  @override
  Widget build(BuildContext context) {
    return
           Padding(
             padding:  EdgeInsets.symmetric(horizontal:3.w,vertical: 3.5.w),
             child: AnimatedContainer(

              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(3, 3), // changes position of shadow
                  ),
                ],
              ),
              duration: const Duration(milliseconds: 300),
              height: expand ? min(widget.myChild.length * 22.0 + 30.h, widget.myChild.length*10.h) : 30.h,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(
                      Icons.vaccines_outlined,
                      color: Colors.orange,
                    ),
                    title: Text(
                      "${widget.myChild[0].childName}",
                      style: TextStyle(color: Colors.green, fontSize: 17.sp),
                    ),
                    trailing: Text(
                      ' birthday: ${DateFormat('dd/MM/yyyy').format(widget.birth.birthDay)}',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15.sp),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'view vaccination history',
                            style: TextStyle(color: Colors.grey, fontSize: 17.sp),
                          ),
                          IconButton(
                            icon: Icon(expand
                                ? Icons.expand_less
                                : Icons.expand_more),
                            onPressed: () {

                                expand = !expand;
                                setState(() {

                                });

                            },
                          ),
                        ]),
                  ),
                  AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                      height: expand ? min(widget.myChild.length * 25.0 + 20.h, widget.myChild.length*4.h) : 0,
                      child: ListView(
                          children: widget.myChild
                              .map((childHistory) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                childHistory.vaccine,
                                style:  TextStyle(
                                    fontSize: 17.5.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(childHistory.status==1?'missed':'taken',
                                style: TextStyle(
                                    fontSize: 18.sp,  color:childHistory.status==1?Colors.red :Colors.greenAccent),
                              )
                            ],
                          ))
                              .toList())),
                  const Spacer(),
                ],
              ),
          ),
           );
  }
}
