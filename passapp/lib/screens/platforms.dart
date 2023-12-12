import 'package:flutter/material.dart';

import 'package:passapp/screens/passwordscreen.dart';

class AddedPlatforms {
  AddedPlatforms({required this.name});

  String? name;
}

class Platforms extends StatefulWidget {
  const Platforms({super.key});

  @override
  State<Platforms> createState() => _PlatformsState();
}

final platformName = new TextEditingController();

List<String> platformList = ["Google", "Facebook"];

class _PlatformsState extends State<Platforms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Platforms"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
          itemCount: platformList.length,
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
                                        platformList[index] = platformName.text;
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
                                      setState(() {
                                        Navigator.of(context).pop();
                                        platformList.removeAt(index);
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
                        builder: (context) =>
                            PasswordsScreen(name: platformList[index]),
                      )),
                  child: Center(
                    child: Text(
                      platformList[index],
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            );
          },
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
                              platformList.add(platformName.text);
                              Navigator.of(context).pop();
                              platformName.clear();
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
