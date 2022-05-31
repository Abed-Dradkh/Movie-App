import 'package:flutter/material.dart';
import 'package:flutter_application_2/helper/builders.dart';
import 'package:flutter_application_2/helper/clipper.dart';
import 'package:flutter_application_2/helper/variables.dart';
import 'package:flutter_application_2/services/sign_provider.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<SignServices>(
      builder: ((_, signIn, __) {
        return Form(
          key: _formKey,
          child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 241, 239, 247),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ClipPath(
                    clipper: BackClipper(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.lightBlueAccent,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Ratalen',
                          style: TextStyle(
                            fontFamily: "DancingScript",
                            fontSize:
                                MediaQuery.of(context).size.height * 0.075,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: Column(
                      children: [
                        buildTextFormField(
                          controllers[0],
                          'Email',
                          const Icon(Icons.email),
                          null,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.015,
                        ),
                        buildTextFormField(
                          controllers[1],
                          'Password',
                          const Icon(Icons.key_rounded),
                          true,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.blue,
                            ),
                            minimumSize: const Size.fromHeight(40),
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                builder: (_) {
                                  return buildBottomSheet(context, signIn);
                                },
                              );
                            }
                          },
                          child: const Text('Login'),
                        ),
                        Divider(
                          height: MediaQuery.of(context).size.height * 0.05,
                          thickness: 2,
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.blue,
                            ),
                            minimumSize: const Size.fromHeight(40),
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    content: buildSignMethods(
                                      context,
                                      'google.png',
                                      () {
                                        signIn.gLogin();
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                });
                          },
                          child: const Text('Other login methods'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildBottomSheet(BuildContext context, SignServices signIn) {
    return Container();
  }
}
