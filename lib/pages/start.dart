import 'package:flutter/material.dart';
import 'package:flutter_application_2/helper/variables.dart';
import 'package:flutter_application_2/services/user_provider.dart';
import 'package:flutter_application_2/services/variable_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'home/setting_home.dart';
//Collecting user data such as name and photo 
class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Consumer2<VariableProvider, UserProvider>(
        builder: (_, provider, user, __) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .1,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Upload Image!',
                        style: TextStyle(
                          fontFamily: font,
                          fontSize: MediaQuery.of(context).size.height * .035,
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Center(
                                child: Text(
                                  'Pick Path',
                                  style: TextStyle(
                                    fontFamily: font,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            .04,
                                  ),
                                ),
                              ),
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      provider.pickImage(ImageSource.camera);
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt_outlined,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      provider.pickImage(ImageSource.gallery);
                                    },
                                    icon: const Icon(
                                      Icons.image_outlined,
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'No Need!',
                                      style: TextStyle(
                                        fontFamily: font,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                .03,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * .25,
                          width: MediaQuery.of(context).size.width * .5,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.blueGrey,
                                blurRadius: 30,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: provider.imagePath.path.isEmpty
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    user.defualtImage,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    provider.imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                      Text(
                        'Or Not!',
                        style: TextStyle(
                          fontFamily: font,
                          fontSize: MediaQuery.of(context).size.height * .035,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .075,
                      ),
                      Text(
                        'Enter Any Name You Want!',
                        textScaleFactor:
                            MediaQuery.of(context).size.height * .0025,
                        style: TextStyle(
                          fontFamily: font,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .015,
                      ),
                      TextFormField(
                        controller: controllers[0],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            fontFamily: font,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      InkWell(
                        onTap: () {
                          if (provider.imagePath.path != '') {
                            if (formKey.currentState!.validate()) {
                              user.setUserInfo(
                                  controllers[0].text, provider.imagePath.path);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingHome(),
                                ),
                              );
                            }
                          } else {
                            //default image
                            if (formKey.currentState!.validate()) {
                              user.setUserInfo(
                                  controllers[0].text, user.userPhotoUrl);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingHome(),
                                ),
                              );
                            }
                          }
                        },
                        highlightColor: Colors.white,
                        splashColor: Colors.white,
                        child: Text(
                          'Start',
                          style: TextStyle(
                            fontFamily: font,
                            fontSize: MediaQuery.of(context).size.width * .1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
