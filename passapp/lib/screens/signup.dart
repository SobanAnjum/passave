import 'package:flutter/material.dart';
import 'package:passapp/screens/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
              "Register",
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
