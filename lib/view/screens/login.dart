import 'package:flutter/material.dart';

import '../../helper/firebase_auth_helper.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  GlobalKey<FormState> signupform = GlobalKey<FormState>();
  GlobalKey<FormState> signinform = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            children: [
              Container(
                  height: 450,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    "https://clickup.com/blog/wp-content/uploads/2020/01/note-taking.png",
                    fit: BoxFit.cover,
                  )),
            ],
          ),
          Container(
            height: 500,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(30),
                  left: Radius.circular(30),
                ),
                color: Colors.amber.shade300),
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: signinform,
                  child: Column(children: [
                    TextFormField(
                      controller: emailcontroller,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Email address first";
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.mail),
                          filled: true,
                          hintText: "Email Address",
                          hintStyle: TextStyle(color: Colors.black),
                          labelText: "Email",
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordcontroller,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Password first";
                        }
                      },
                      onSaved: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.remove_red_eye),
                          filled: true,
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.black),
                          labelText: "Password",
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                  ]),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (signinform.currentState!.validate()) {
                      signinform.currentState!.save();

                      Map<String, dynamic> res = await FirebaseAuthHelper
                          .firebaseAuthHelper
                          .signIn(email: email!, password: password!);
                      if (res['user'] != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Sign In Successfully....."),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                        ));
                        Navigator.of(context).pushReplacementNamed("/");
                      } else if (res['error'] != null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(res['error']),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Sign In Failed......"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                    emailcontroller.clear();
                    passwordcontroller.clear();
                    setState(() {
                      email = null;
                      password = null;
                    });
                  },
                  child: Text("Log In")),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          padding: EdgeInsets.all(5),
                          child: Image.network(
                              "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-suite-everything-you-need-know-about-google-newest-0.png"),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.deepPurple.shade400, width: 2),
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white),
                        ),
                        Text(
                          "Google",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          padding: EdgeInsets.all(2),
                          child: Image.network(
                              "https://www.freepnglogos.com/uploads/facebook-logo-icon/facebook-logo-icon-facebook-icon-png-images-icons-and-png-backgrounds-1.png"),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.deepPurple.shade400, width: 2),
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white),
                        ),
                        Text(
                          "Facebook",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          padding: EdgeInsets.all(5),
                          child: Image.network(
                              "https://www.freepnglogos.com/uploads/apple-logo-png/apple-logo-png-dallas-shootings-don-add-are-speech-zones-used-4.png"),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.deepPurple.shade400, width: 2),
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white),
                        ),
                        Text(
                          "Apple",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          padding: EdgeInsets.all(5),
                          child: Image.network(
                              "https://www.freepnglogos.com/uploads/twitter-logo-png/twitter-logo-vector-png-clipart-1.png"),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.deepPurple.shade400, width: 2),
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white),
                        ),
                        Text(
                          "Twitter",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  validatesignup();
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.shade100),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  Map user =
                      await FirebaseAuthHelper.firebaseAuthHelper.Anonymous();
                  if (user['user'] != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Log In Successfully"),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ));
                    Navigator.of(context)
                        .pushReplacementNamed("/", arguments: user['user']);
                  } else if (user['error'] != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(user['error']),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Log In Failed"),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ));
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.deepPurple),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue.shade100),
                  child: Text(
                    "Sign In As Guest",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  validatesignup() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text("Sign Up"),
            ),
            content: Form(
              key: signupform,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(
                  controller: emailcontroller,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter Email address first";
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.mail),
                      filled: true,
                      hintText: "Email Address",
                      hintStyle: TextStyle(color: Colors.black),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20)),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordcontroller,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter Password first";
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.remove_red_eye),
                      filled: true,
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.black),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20)),
                ),
              ]),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    if (signupform.currentState!.validate()) {
                      signupform.currentState!.save();

                      Map<String, dynamic> res = await FirebaseAuthHelper
                          .firebaseAuthHelper
                          .signUp(email: email!, password: password!);
                      if (res['user'] != null) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Sign Up Successfully....."),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                        ));
                      } else if (res['error'] != null) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(res['error']),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Sign Up Failed......"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                    emailcontroller.clear();
                    passwordcontroller.clear();

                    setState(() {
                      email = null;
                      password = null;
                    });
                  },
                  child: Text("Sign Up")),
              OutlinedButton(
                onPressed: () {
                  emailcontroller.clear();
                  passwordcontroller.clear();
                  setState(() {
                    email = null;
                    password = null;
                  });
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          );
        });
  }
}
