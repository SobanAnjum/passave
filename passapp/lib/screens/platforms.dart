import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:passapp/components/emptyCheck.dart';

import 'package:passapp/screens/passwordscreen.dart';

var platformBox = Hive.box("Platforms");
List found = [];
void filter(String usersearch) {
  if (usersearch.isEmpty) {
    found = userPlatforms;
  } else {
    List foundentries = [];

    for (int i = 0; i < userPlatforms.length; i++) {
      String entrytext = userPlatforms[i][1].toLowerCase();
      if (entrytext.contains(usersearch.toLowerCase())) {
        foundentries.add(["${userPlatforms[i][0]}", "${userPlatforms[i][1]}"]);
      }
    }
    found = foundentries;
  }
}

class Platforms extends StatefulWidget {
  final String user_name;

  const Platforms({super.key, required this.user_name});

  @override
  State<Platforms> createState() => _PlatformsState();
}

final platformName = new TextEditingController();

List platForms = [];
List userPlatforms = [];

void updateLists(String username) {
  platForms.clear();
  userPlatforms.clear();
  var box = Hive.box("Platforms");
  platForms = box.values.toList();
  for (int i = 0; i < platForms.length; i++) {
    if (platForms[i][0] == username) {
      userPlatforms.add(platForms[i]);
    }
  }
}

class _PlatformsState extends State<Platforms> {
  @override
  void initState() {
    updateLists(widget.user_name);
    filter("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: Text(
            "",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
          ),
        ),
        leadingWidth: 1,
        title: Text("WELCOME ${widget.user_name.toUpperCase()}"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromARGB(255, 33, 150, 243),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
                width: 300,
                child: TextField(
                  onChanged: (value) {
                    print(found);
                    setState(() {
                      filter(value);
                      updateLists(widget.user_name);
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "Search Platform",
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                )),
            SizedBox(
              height: 50,
            ),
            Text(
              "P L A T F O R M S",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 30,
                fontFamily: 'Logo',
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Divider(indent: 20, color: Color.fromARGB(255, 75, 75, 75)),
            SizedBox(
              height: 15,
            ),
            if (found.length == 0)
              Center(
                child: Text(
                  'No Entries',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemCount: found.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Container(
                            child: AlertDialog(
                              title: Text("Edit"),
                              content: Container(
                                width: 100,
                                height: 120,
                                child: Column(
                                  children: [
                                    Container(
                                      child: TextField(
                                        controller: platformName,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                            hintText: "Platform Name",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              for (int i = 0;
                                                  i < platForms.length;
                                                  i++) {
                                                if (platForms[i][1] ==
                                                        found[index][1] &&
                                                    platForms[i][0] ==
                                                        widget.user_name) {
                                                  // Print relevant information for debugging
                                                  print(
                                                      'Updating platform at index $i');
                                                  print(
                                                      'Old platform values: ${platForms[i]}');

                                                  platformBox.putAt(i, [
                                                    "${widget.user_name}",
                                                    "${platformName.text}", // Use the updated platform name here
                                                  ]);

                                                  // Print updated platform values for debugging
                                                  print(
                                                      'Updated platform values: ${platformBox.getAt(i)}');

                                                  // Update the passwords associated with the platform
                                                  for (int j = 0;
                                                      j < PassBox.length;
                                                      j++) {
                                                    if (Passwords[j][1] ==
                                                            userPlatforms[index]
                                                                [1] &&
                                                        Passwords[j][0] ==
                                                            widget.user_name) {
                                                      // Print relevant information for debugging
                                                      print(
                                                          'Updating password at index $j');
                                                      print(
                                                          'Old password values: ${Passwords[j]}');

                                                      PassBox.putAt(j, [
                                                        "${widget.user_name}",
                                                        "${platformName.text}",
                                                        Passwords[j][
                                                            2], // Keep the username unchanged
                                                        Passwords[j][
                                                            3], // Keep the password unchanged
                                                      ]);

                                                      // Print updated password values for debugging
                                                      print(
                                                          'Updated password values: ${PassBox.getAt(j)}');
                                                    }
                                                  }

                                                  updateLists(widget.user_name);
                                                  break;
                                                }
                                              }
                                              platformName.clear();
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
                                            String platformname =
                                                found[index][1];
                                            setState(() {
                                              for (int i = 0;
                                                  i < platForms.length;
                                                  i++) {
                                                if (platForms[i][1] ==
                                                        platformname &&
                                                    platForms[i][0] ==
                                                        widget.user_name) {
                                                  platformBox.deleteAt(i);
                                                  updateLists(widget.user_name);
                                                  break;
                                                }
                                              }

                                              Navigator.of(context).pop();

                                              var passBox =
                                                  Hive.box("Passwords");
                                              var passList =
                                                  passBox.values.toList();
                                              for (int i = passList.length - 1;
                                                  i >= 0;
                                                  i--) {
                                                if (passList[i][1] ==
                                                        platformname &&
                                                    passList[i][0] ==
                                                        widget.user_name) {
                                                  PassBox.deleteAt(i);
                                                }
                                                passList.clear();
                                                passList =
                                                    passBox.values.toList();
                                              }
                                            });
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
                      height: 200,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          border: Border.all(
                              color: Color.fromARGB(255, 233, 233, 233),
                              width: 2,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(20)),
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PasswordsScreen(
                                  name: found[index][1],
                                  user: widget.user_name),
                            )),
                        child: Center(
                          child: Text(
                            found[index][1],
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
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
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(50)),
                    width: 100,
                    height: 120,
                    child: Column(
                      children: [
                        TextField(
                          controller: platformName,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "Name of Platform",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isEmpty(platformName)) {
                                FlutterToastr.show(
                                    "Please Check your Input Fields", context);
                              } else {
                                platformBox.add([
                                  "${widget.user_name}",
                                  "${platformName.text}"
                                ]);
                                Navigator.of(context).pop();
                                platformName.clear();
                                updateLists(widget.user_name);
                              }
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(child: Text("Add")),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
