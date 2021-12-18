import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sell_beta_customer/Api/api-repo/api.dart';
import 'package:sell_beta_customer/Api/model/update_profile_model.dart';
import 'package:sell_beta_customer/Component/Widgets.dart';
import 'package:sell_beta_customer/Config/icon_config.dart';
import 'package:sell_beta_customer/Provider/user_provider.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final ImagePicker _picker = ImagePicker();
  AccountIcon _accountIcon = AccountIcon();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var zipController = TextEditingController();
  var countryController = TextEditingController();
  var stateController = TextEditingController();
  var cityController = TextEditingController();
  XFile? _image;

  File? _finalImage;

  Future getImage(userId) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = XFile(pickedFile.path);
        if (_image != null) {
          getImageCrop(userId);
        }
      } else {
        showSnackBar(context, "No Image");
      }
    });
  }

  getImageCrop(userId) async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: _image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          // CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile != null) {
      _finalImage = croppedFile;
      UpdateProfileModel? model = await uploadProfilePic(
          userId,
          _finalImage!.path,
          nameController.text,
          phoneController.text,
          addressController.text,
          countryController.text,
          stateController.text,
          cityController.text,
          zipController.text);
      if (model!.status) {
        showSnackBar(context, "Image Upload Successful");
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        showSnackBar(context, model.message);
      }
    }
  }

  _updateProfile(user) async {
    try {
      var userId = user;
      var name = nameController.text;
      var phone = phoneController.text;
      var address = addressController.text;
      var country = countryController.text;
      var state = stateController.text;
      var city = cityController.text;
      var zip = zipController.text;
      UpdateProfileModel? model = await updateProfile(
          userId, name, phone, address, country, state, city, zip);
      if (model!.status) {
        showSnackBar(context, "${model.message}");
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        showSnackBar(context, model.message);
      }
    } catch (e) {
      showToast(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var data = Provider.of<UserProfileModel>(context, listen: false);
    nameController.text = data.name ?? "";
    emailController.text = data.emailId ?? "";
    phoneController.text = data.number ?? "";
    addressController.text = data.address ?? "";
    countryController.text = data.country ?? "";
    stateController.text = data.state ?? "";
    stateController.text = data.city ?? "";
    zipController.text = data.zip ?? "";
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var user = Provider.of<UserProvider>(context);
    var userProfile = Provider.of<UserProfileModel>(context);
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        title: Text("Edit profile"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[
                Color(0xffEA5524),
                Color(0xffF7941D),
              ])),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                child: IconButton(
                    onPressed: () async {
                      _updateProfile(user.userId);
                    },
                    icon: Icon(Icons.check))),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: height,
                  width: width,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: height * .1,
                    ),
                    Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * .09,
                              ),
                              ProfileText(
                                text: "Customer Name",
                              ),
                              CustomTextField(
                                controller: nameController,
                                hint: "Arlene McCoy",
                              ),
                              ProfileText(
                                text: "Email ID",
                              ),
                              CustomTextField(
                                controller: emailController,
                                enable: false,
                                hint: "jackson.graham@example.com",
                              ),
                              ProfileText(
                                text: "Contact Number",
                              ),
                              CustomTextField(
                                controller: phoneController,
                                hint: "(209) 555-0104",
                              ),
                              ProfileText(
                                text: "Address",
                              ),
                              CustomTextField(
                                controller: addressController,
                                hint: "6391 Elgin St. Celina, Delaware 10299",
                              ),
                              ProfileText(
                                text: "Total purchase",
                              ),
                              CustomTextField(
                                hint: "5001",
                              ),
                              // ProfileText(
                              //   text: "Country",
                              // ),
                              // CustomTextField(
                              //   controller: countryController,
                              //   hint: "6391 Elgin St. Celina, Delaware 10299",
                              // ),
                              ProfileText(
                                text: "State",
                              ),
                              CustomTextField(
                                controller: stateController,
                                hint: "Kansas",
                              ),
                              ProfileText(
                                text: "City",
                              ),
                              CustomTextField(
                                controller: cityController,
                                hint: "Janestad",
                              ),
                              ProfileText(
                                text: "ZIP",
                              ),
                              CustomTextField(
                                controller: zipController,
                                hint: "25138",
                              ),
                              SizedBox(
                                height: height * .05,
                              )
                            ],
                          ),
                        )),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: height * .05,
                    ),
                    _finalImage != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(File(_finalImage!.path)),
                            radius: 42,
                          )
                        : userProfile.image != null
                            ? CircleAvatar(
                                backgroundImage:
                                    NetworkImage(userProfile.image),
                                radius: 42,
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    AssetImage(_accountIcon.sampleIcon),
                                radius: 42,
                              ),
                    SizedBox(
                      height: height * .01,
                    ),
                    SizedBox(
                      height: 30,
                      child: OutlineButton(
                        borderSide: BorderSide(color: Color(0xffF15741)),
                        onPressed: () {
                          getImage(user.userId);
                        },
                        child: Text("Change Photo"),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * .1,
          )
        ],
      ),
    );
  }
}

class ProfileText extends StatelessWidget {
  const ProfileText({Key? key, this.text}) : super(key: key);
  final text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 5, left: 5),
          child: Text(
            text,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color(0xffF15741)),
          ),
        ),
      ],
    );
  }
}
