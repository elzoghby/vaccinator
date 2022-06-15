import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:vaccinator/models/vaccine.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class VaccinesItem extends StatefulWidget {
  final Vaccine vaccine;

  const VaccinesItem(this.vaccine);

  @override
  _VaccinesItemState createState() => _VaccinesItemState();
}

class _VaccinesItemState extends State<VaccinesItem> {
  bool expand = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration:BoxDecoration(color: Colors.white,
        boxShadow:  [
        BoxShadow(
          color: Colors.teal.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],) ,
      duration: const Duration(milliseconds: 300),
      height: expand ?  min(10 * 20.0 + 1170, 200) : 150,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: const Icon(
              Icons.vaccines_outlined,
              color: Colors.orange,
            ),
            title: Text(
              '${widget.vaccine.name}',
              style: TextStyle(color: Colors.green, fontSize: 17.sp),
            ),
            trailing: Text(
              'year: ${widget.vaccine.year} month: ${widget.vaccine.month} days: ${widget.vaccine.day}',
              style: TextStyle(color: Colors.teal, fontSize: 15.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'view vaccine detail',
                    style: TextStyle(color: Colors.grey, fontSize: 17.sp),
                  ),
                  IconButton(
                    icon: Icon(expand ? Icons.expand_less : Icons.expand_more),
                    onPressed: () {
                      setState(() {
                        expand = !expand;
                      });
                    },
                  ),
                ]),
          ),
          AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: expand   ? min(10 * 20.0 + 10, 10.h)
                  : 0,
              child: ListView(
                children: [
                Column(
                  children: [
                    Text(
                      'Description: ${widget.vaccine.description}',
                      style: TextStyle(color: Colors.black, fontSize: 15.sp),
                    ),SizedBox(height: 1.5.h,),
                    Text(
                      'Price : ${widget.vaccine.price}',
                      style: TextStyle(color: Colors.red, fontSize: 15.sp,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ])),
          const Spacer(),
        ],
      ),
    );
  }
}
