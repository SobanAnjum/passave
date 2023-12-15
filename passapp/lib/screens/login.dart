import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:passapp/components/emptyCheck.dart';
import 'package:passapp/screens/platforms.dart';
import 'package:passapp/screens/signup.dart';
import 'package:hive_flutter/adapters.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

final userName = TextEditingController();
final passWord = TextEditingController();

class _RegisterState extends State<Register> {
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
              "LOGIN",
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
              height: 30,
            ),
            Container(
                width: 250,
                child: TextField(
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
                    String strName = userName.text;
                    var box = Hive.box("Users");
                    bool found = false;
                    List boxtolist = [];
                    print(box.values);
                    boxtolist = box.values.toList();

                    for (int i = 0; i < boxtolist.length; i++) {
                      if (boxtolist[i][0] == userName.text &&
                          boxtolist[i][1] == passWord.text) {
                        found = true;
                        break;
                      } else {
                        found = false;
                      }
                    }
                    if (found) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Platforms(user_name: strName),
                          ));
                    } else {
                      FlutterToastr.show("Invalid Login Credentials", context,
                          duration: 2);
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
                    "Sign in",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                )),
            SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                userName.clear();
                passWord.clear();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Signup(),
                    ));
              },
              child: Text(
                "Don't have an account? Click here to Signup",
                style: TextStyle(color: const Color.fromARGB(255, 67, 67, 67)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
