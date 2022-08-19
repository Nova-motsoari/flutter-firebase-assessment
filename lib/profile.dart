import 'dart:developer';
import 'package:module4/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:module4/nextPage.dart';


class profile extends StatelessWidget {

TextEditingController userName =TextEditingController();
TextEditingController eMail =TextEditingController();
TextEditingController password =TextEditingController();

 registerProfile(){
   final name = userName.text;
   final mail = eMail.text;
   final passCode = password.text;

   final ref = FirebaseFirestore.instance.collection('UserInfo').doc();

   return ref
       .set({"User Name":name, "User eMail":mail, "User Password":passCode,"docID":ref.id})
        .then((value) => log("Data recorded"))
        .catchError((onError)=> log(onError));


 }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.red,
        scaffoldBackgroundColor: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: Center(
        child: Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text('Register'),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              registerProfile();
              },
            label: Text('Register Profile'),
            icon: Icon(Icons.arrow_forward_outlined),

          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: userName,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      labelText: 'User name',
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: eMail,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      labelText: 'Email address',
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: password,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      labelText: 'Password',
                    ),
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>info()));
                  },
                  child: Text('See data',style: TextStyle(fontSize: 20,),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
