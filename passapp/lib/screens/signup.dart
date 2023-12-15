import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:passapp/components/emptyCheck.dart';
import 'package:passapp/screens/login.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

final userName = TextEditingController();
final passWord = TextEditingController();

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

List Users = [];
List userList() {
  Users.clear();
  var box = Hive.box("Users");
  Users = box.values.toList();
  return Users;
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Center(
              child: Image.asset(
                'assets/images/Logo.png',
                width: 300,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            const Text(
              "Register",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Logo',
                  color: Colors.red),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 250,
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Color.fromARGB(255, 243, 50, 50),
                    ),
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250,
              child: TextField(
                controller: userName,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.contacts,
                      color: Color.fromARGB(255, 243, 50, 50),
                    ),
                    hintText: "Username",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(),
                        borderRadius: BorderRadius.circular(30))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                width: 250,
                child: TextField(
                  inputFormatters: [],
                  obscureText: true,
                  controller: passWord,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color.fromARGB(255, 243, 50, 50),
                      ),
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(30))),
                )),
            const SizedBox(
              height: 30,
            ),
            InkWell(
                onTap: () {
                  if (isEmpty(userName) || isEmpty(passWord)) {
                    FlutterToastr.show(
                        "Please Check your Input Fields", context);
                  } else {
                    var box = Hive.box("Users");
                    bool found = false;
                    userList();

                    for (int i = 0; i < userList().length; i++) {
                      if (userList()[i][0] == userName.text) {
                        found = true;
                      } else {
                        found = false;
                      }
                    }
                    if (found) {
                      FlutterToastr.show(
                        "User Already Exists",
                        context,
                        duration: 2,
                      );
                    } else {
                      print("enter login no exist");
                      box.add(["${userName.text}", "${passWord.text}"]);
                      FlutterToastr.show(
                        "Created new User",
                        context,
                        duration: 2,
                      );
                    }
                    userName.clear();
                    passWord.clear();
                  }
                },
                child: Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.amber[400],
                  ),
                  child: const Center(
                      child: Text(
                    "Register",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                )),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                userName.clear();
                passWord.clear();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register(),
                    ));
              },
              child: const Text(
                "Already have an Account? Click here to Login",
                style: TextStyle(color: Color.fromARGB(255, 67, 67, 67)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
