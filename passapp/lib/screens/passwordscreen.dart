import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import "package:hive_flutter/adapters.dart";
import 'package:passapp/components/emptyCheck.dart';

class PasswordsScreen extends StatefulWidget {
  final String name;
  final String user;

  const PasswordsScreen({Key? key, required this.name, required this.user})
      : super(key: key);

  @override
  State<PasswordsScreen> createState() => _PassScreenState();
}

List found = [];
void filter(String usersearch) {
  if (usersearch.isEmpty) {
    found = platformPasswords;
  } else {
    List foundentries = [];

    for (int i = 0; i < platformPasswords.length; i++) {
      String entrytext = platformPasswords[i][2].toLowerCase();
      if (entrytext.contains(usersearch.toLowerCase())) {
        foundentries.add(
          [
            "${platformPasswords[i][0]}",
            "${platformPasswords[i][1]}",
            "${platformPasswords[i][2]}",
            "${platformPasswords[i][3]}"
          ],
        );
      }
    }
    found = foundentries;
  }
}

final PassBox = Hive.box("Passwords");
List platformPasswords = [];
List Passwords = [];

void passfilter(String platformname, String username) {
  platformPasswords.clear();
  Passwords.clear();
  Passwords = PassBox.values.toList();
  for (int i = 0; i < Passwords.length; i++) {
    if (Passwords[i][0] == username && Passwords[i][1] == platformname) {
      platformPasswords.add(Passwords[i]);
    }
  }
}

class _PassScreenState extends State<PasswordsScreen> {
  @override
  void initState() {
    filter("");
    super.initState();

    passfilter(widget.name, widget.user);
  }

  @override
  Widget build(BuildContext context) {
    final username = new TextEditingController();
    final password = new TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 253, 253, 253),
        foregroundColor: Color.fromARGB(255, 33, 150, 243),
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
              width: 300,
              child: TextField(
                onChanged: (value) {
                  print(found);
                  setState(() {
                    filter(value);
                    passfilter(widget.name, widget.user);
                  });
                },
                decoration: InputDecoration(
                    hintText: "Search Passwords",
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30))),
              )),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "P A S S W O R D S",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 30,
                fontFamily: 'Logo',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            indent: 20,
            color: Colors.grey[500],
          ),
          SizedBox(
            height: 20,
          ),
          if (found.isEmpty) Center(child: Text("No Entries")),
          Expanded(
            child: ListView.builder(
              itemCount: found.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    username.text = platformPasswords[index][2];
                    password.text = platformPasswords[index][3];
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Container(
                          child: AlertDialog(
                            title: Text("Edit"),
                            content: Container(
                              width: 350,
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: TextField(
                                      controller: username,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          hintText: "Username",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: TextField(
                                      controller: password,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          )),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            for (int i = 0;
                                                i < PassBox.length;
                                                i++) {
                                              if (Passwords[i][1] ==
                                                      widget.name &&
                                                  Passwords[i][0] ==
                                                      widget.user &&
                                                  Passwords[i][2] ==
                                                      found[index][2] &&
                                                  Passwords[i][3] ==
                                                      found[index][3]) {
                                                PassBox.putAt(i, [
                                                  "${widget.user}",
                                                  "${widget.name}",
                                                  username.text,
                                                  password.text
                                                ]);
                                                passfilter(
                                                    widget.name, widget.user);
                                                break;
                                              }
                                            }
                                            username.clear();
                                            password.clear();
                                            passfilter(
                                                widget.name, widget.user);
                                            Navigator.of(context).pop();
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          width: 75,
                                          height: 40,
                                          child: Center(
                                              child: Text(
                                            "Update",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          username.clear();
                                          password.clear();
                                        },
                                        child: Container(
                                          width: 75,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Center(
                                              child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (isEmpty(username) ||
                                              isEmpty(password)) {
                                            FlutterToastr.show(
                                                "Please Check your Input Fields",
                                                context);
                                          } else {
                                            setState(() {
                                              for (int i = 0;
                                                  i < PassBox.length;
                                                  i++) {
                                                if (Passwords[i][1] ==
                                                        widget.name &&
                                                    Passwords[i][0] ==
                                                        widget.user &&
                                                    Passwords[i][2] ==
                                                        found[index][2] &&
                                                    Passwords[i][3] ==
                                                        found[index][3]) {
                                                  PassBox.deleteAt(i);
                                                  passfilter(
                                                      widget.name, widget.user);
                                                  break;
                                                }
                                              }
                                              Navigator.of(context).pop();
                                              username.clear();
                                              password.clear();
                                              passfilter(
                                                  widget.name, widget.user);
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: 75,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 255, 0, 0),
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Center(
                                              child: Text(
                                            "Delete",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          )),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: Color.fromARGB(255, 207, 207, 207),
                          style: BorderStyle.solid),
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: 100,
                    height: 130,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${found[index][2]}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("${found[index][3]}")
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Container(
                  child: AlertDialog(
                    title: Text("Enter Details"),
                    content: Container(
                      width: 200,
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: TextField(
                              controller: username,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: "Username",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: TextField(
                              controller: password,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isEmpty(username) ||
                                        isEmpty(password)) {
                                      FlutterToastr.show(
                                          "Please Check your Input Fields",
                                          context);
                                    } else {
                                      PassBox.add([
                                        "${widget.user}",
                                        "${widget.name}",
                                        username.text,
                                        password.text
                                      ]);
                                      username.clear();
                                      password.clear();
                                      passfilter(widget.name, widget.user);
                                      Navigator.of(context).pop();
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(30)),
                                  width: 100,
                                  height: 40,
                                  child: Center(
                                      child: Text(
                                    "Save",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                  username.clear();
                                  password.clear();
                                },
                                child: Container(
                                  width: 100,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Center(
                                      child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: Icon(Icons.bookmark_add)),
    );
  }
}
