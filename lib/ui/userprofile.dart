import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/widgets/button.dart';
import 'package:ecommerce/widgets/mytext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bottom_navbar.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserProfile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _divController = TextEditingController();
  TextEditingController _branchController = TextEditingController();
  TextEditingController _prnController = TextEditingController();
    TextEditingController _rollnoController = TextEditingController();

  

  sendUserDataToDB()async{

    final FirebaseAuth _auth = FirebaseAuth.instance;
    var  currentUser = _auth.currentUser;

    CollectionReference _collectionRef = FirebaseFirestore.instance.collection("users-form-data");
    return _collectionRef.doc(currentUser!.email).set({
      "name":_nameController.text,
      "phone":_phoneController.text,
      "div":_divController.text,
      "branch":_branchController.text,
      "prn":_prnController.text,
      "rollno":_rollnoController.text,
    }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=>BottomNavController()))).catchError((error)=>print("something is wrong. $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
               
                
                SizedBox(
                  height: 15,
                ),
                myTextField("enter your name",TextInputType.text,_nameController),
                myTextField("enter your phone number",TextInputType.number,_phoneController),
                
              
                myTextField("enter your prn",TextInputType.number,_prnController),

                SizedBox(
                  height: 50,
                ),

                // elevated button
               customButton("Continue",()=>sendUserDataToDB()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
