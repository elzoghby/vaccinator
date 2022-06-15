import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'About Us',
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.teal,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: double.infinity,
              height: 20.h,
              decoration: BoxDecoration(
                color: Colors.teal[300],
                image: DecorationImage(
                    image: AssetImage('assets/vaccine.png'),
                    fit: BoxFit.contain),
              ),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 1.w),
                  child: Text(
                    'Vaccinator',
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.w),
            child: GestureDetector(
              onTap: () {
                showAboutDialog(
                    context: context,
                    applicationIcon: Image.asset('assets/vaccine.png'),
                    applicationName: 'Vaccinator',
                    applicationVersion: '1.0',
                    children: [
                      Text(
                          'As described in our Internet Privacy Policy, one type of online resource that we provide is mobile computing applications ("Apps") for mobile devices, such as smartphones and tablets. Many of these can be purchased or downloaded from App Stores that are offered by the provider of the device operating system, such as Apple and Google. Some of these Apps allow you to record information within the App and store it on your device, to create reports, and to email content from the App. In some cases, that information may be "personal information" that identifies or is used to identify you, such as your name. Where the personal information you record is collected by us, or others working for us, it will be used in accordance with our Internet Privacy Policy. If you use an older version of one of our Apps, such as an App that we offered prior to 2014, the App may have functionality for evaluation of how it is used by enabling data about your use of the App on your device, such as which features you used the most, to be transmitted to Flurry, an analytics service provider. If you do not want Flurry to track your use of the App on your device, you can opt-out. If you have questions, please contact the Privacy Office.',style: TextStyle(),)
                    ]);
              },
              child: Text(
                'Terms and conditions',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 2.w,
            ),
            child: SizedBox(
              height: 2.h,
              child: Divider(
                thickness: 2,
                //    width: 20,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
