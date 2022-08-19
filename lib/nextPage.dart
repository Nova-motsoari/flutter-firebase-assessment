import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:module4/main.dart';
import 'package:module4/profile.dart';

class info extends StatefulWidget {
  const info({Key? key}) : super(key: key);

  @override
  State<info> createState() => _infoPageState();
}

class _infoPageState extends State<info> {
  final Stream<QuerySnapshot> infom =
      FirebaseFirestore.instance.collection("UserInfo").snapshots();

  @override
  Widget build(BuildContext context) {
    TextEditingController userEmail = TextEditingController();
    TextEditingController userPword = TextEditingController();
    TextEditingController userUname = TextEditingController();

    void delete(docId) {
      FirebaseFirestore.instance.collection("UserInfo").doc(docId).delete();
    }

    ;

    void update(data) {

      var collectInfo = FirebaseFirestore.instance.collection("UserInfo");

      userEmail.text=data["User eMail"];
      userPword.text=data["User Password"];
      userUname.text=data["User Name"];

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Update info'),
          content: Column(
            children: [
              TextField(
                controller: userUname,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  labelText: 'New userName',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: userPword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  labelText: 'New Password',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: userEmail,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  labelText: 'New email',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  collectInfo.doc(data["docID"]).update({
                    "User Name":userUname.text,
                    "User Password":userPword.text,
                    "User eMail":userEmail.text
                  });
                  Navigator.pop(context);
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      );
    }

    ;

    return StreamBuilder(
      stream: infom,
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
        if (snapshot.hasError) {
          return Text('Collection failed');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text('View data and edit'),
            ),
            body: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot documentSnapshot) {
                      Map<String, dynamic> data =
                          documentSnapshot.data()! as Map<String, dynamic>;
                      return Column(
                        children: [
                          ListTile(
                            title: Text(data['User Name']),
                            subtitle: Text(data['User Password']),
                          ),
                          ButtonTheme(
                            child: ButtonBar(
                              children: [
                                OutlineButton.icon(
                                  onPressed: () {
                                    update(data);
                                  },
                                  icon: Icon(Icons.edit),
                                  label: Text('Edit data'),
                                ),
                                OutlineButton.icon(
                                  onPressed: () {
                                    delete(data["docID"]);
                                  },
                                  icon: Icon(Icons.remove),
                                  label: Text('Delete data'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList()),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text("no data");
        }
        ;
      },
    );
  }
}
