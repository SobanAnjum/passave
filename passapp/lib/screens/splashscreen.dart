import "package:flutter/material.dart";
import "package:flutter_toastr/flutter_toastr.dart";
import "package:hive_flutter/adapters.dart";
import "package:passapp/screens/login.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'assets/images/splashbg.png',
            ),
          ),
          color: Colors.black,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Center(
                  child: Container(
                width: 300,
                child: Image.asset('assets/images/Logo.png'),
              )),
              const SizedBox(
                height: 350,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ));
                },
                child: Container(
                  width: 100,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: const Center(
                      child: Text(
                    "Next",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 179, 0),
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
