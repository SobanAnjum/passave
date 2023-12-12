import 'package:flutter/material.dart';

class PasswordsScreen extends StatefulWidget {
  final String name;

  const PasswordsScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<PasswordsScreen> createState() => _PassScreenState();
}

List<List> platformPasswords = [];
List<List> Passwords = [];
void passfilter(String name) {
  platformPasswords.clear();
  for (var i = 0; i < Passwords.length; i++) {
    if (Passwords[i][0] == name) {
      platformPasswords.add([
        "${Passwords[i][01]}",
        "${Passwords[i][02]}",
      ]);
      print(Passwords);
    }
  }
}

class _PassScreenState extends State<PasswordsScreen> {
  @override
  void initState() {
    super.initState();

    passfilter(widget.name);
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
        foregroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: platformPasswords.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
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
                                    var reqindex;
                                    for (var i = 0; i < Passwords.length; i++) {
                                      if (platformPasswords[index][0] ==
                                              Passwords[i][1] &&
                                          platformPasswords[index][1] ==
                                              Passwords[i][2] &&
                                          Passwords[i][0] == widget.name) {
                                        reqindex = i;
                                      }
                                    }
                                    setState(() {
                                      Passwords.removeAt(reqindex);
                                      Navigator.of(context).pop();
                                      username.clear();
                                      password.clear();
                                      passfilter(widget.name);
                                    });
                                  },
                                  child: Container(
                                    width: 75,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 255, 0, 0),
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
                      "${platformPasswords[index][0]}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("${platformPasswords[index][1]}")
                  ],
                ),
              ),
            ),
          );
        },
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
                                    Passwords.add([
                                      "${widget.name}",
                                      username.text,
                                      password.text
                                    ]);
                                    username.clear();
                                    password.clear();
                                    passfilter(widget.name);
                                    Navigator.of(context).pop();
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
