import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);
  static const border = OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xff7A7EA3)),
    borderRadius: BorderRadius.all(Radius.circular(35.0)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact us'), backgroundColor: Colors.teal),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(3, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(35),
              color: Colors.white,
            ),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty ||! value.contains('@')) {
                  return 'Add a valid email ';
                } else {
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Color(0xff7A7EA3)),
                hintText: 'email',
                enabledBorder: border,
                focusedBorder: border,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(3, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(35),
              color: Colors.white,
            ),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty || value.length<11) {
                  return 'Add a valid email ';
                } else {
                  return null;
                }
              },
              maxLines: 5,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Color(0xff7A7EA3)),
                hintText: 'message',
                enabledBorder: border,
                focusedBorder: border,
              ),
            ),
          )
        ],
      ),
    );
  }
}
