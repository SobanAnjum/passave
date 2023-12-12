import 'package:flutter/material.dart';
import 'package:passapp/screens/platforms.dart';
import 'package:passapp/screens/signup.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
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
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: 250,
              child: TextField(
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
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Platforms(),
                    )),
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
