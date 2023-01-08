import 'package:contact_app/data/contact_model.dart';
import 'package:contact_app/data/favorite_storage.dart';
import 'package:contact_app/theme/theme_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:faker/faker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';  
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';




class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key, }): super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  //putting underscores in front from a variable makes it a private access modifier in dart
  //'initState' runs when the widget is initialized
  
  void showGetXDialogBoxForEditingContact(bool isUpdate, DocumentSnapshot data) {
    Get.defaultDialog(
            title: isUpdate ? 'Edit Contact' : 'New Contact',
            titleStyle: GoogleFonts.comfortaa(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 18,),
            titlePadding: EdgeInsets.only(top: 10, bottom: 10),
            backgroundColor: Colors.white,
            content: Form(
              key: _formKey,
              child: SizedBox(
                //height: 250,
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      //controller: nameController,
                      initialValue: data['name'],  //name,
                      autocorrect: true,
                      keyboardType: TextInputType.name,
                      enableSuggestions: true,
                      enableInteractiveSelection: true,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        //labelStyle: ,
                        //hintStyle: ,
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: 'name:',
                        prefixIcon: Icon(Icons.account_circle_outlined, color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.tealAccent, width: 2.0),
                          borderRadius: BorderRadius.all(
                            const Radius.circular(50.0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.all(
                            const Radius.circular(50.0),
                          ),
                        ),            
                    ),
            onSaved: (value) {
                name = value!;
            },
            onChanged: (value) {
                name = value;
            },
            validator: (value) {
             if(value!.isEmpty) {
                return 'Input name';
             }
             return null;
            },
          ),
          SizedBox(
            height: 20
          ),
          TextFormField(
            autofocus: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            //controller: numberController,
            initialValue: data['number'],  //number,
            autocorrect: true,
            keyboardType: TextInputType.number,
            enableSuggestions: true, 
            enableInteractiveSelection: true,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                //labelStyle: ,
                //hintStyle: ,
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'phone:',
                prefixIcon: Icon(Icons.call, color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent, width: 2.0),
                  borderRadius: BorderRadius.all(
                    const Radius.circular(50.0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.all(
                    const Radius.circular(50.0),
                  ),
                ),           
            ),
            onSaved: (value) {
                number = value!;
            },
            onChanged: (value) {
                number = value;
            },
            validator: (value) {
                final phoneRegEx = RegExp(r'[@#<>?:_`;[\]\\|=+)(*&^%0-9-]');
                if(value!.isEmpty) {
                  return "Input contact";
                } 
                else if(!phoneRegEx.hasMatch(value)) {
                  return 'Invalid contact';
                }
                return null;
            },
          ),
          SizedBox(
            height: 20 //20
          ),
          SizedBox(
            height: 40,  //50
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  //Accessing Form through "_formKey"
                  if(_formKey.currentState!.validate()) {               
                    _formKey.currentState!.save();
                    if(isUpdate) {
                      final db = FirebaseFirestore.instance;
                      db.collection('contacts').doc(data.id).update({'name' : name, 'number': number}).whenComplete(() => print("$name and $number has been successfully updated in database"));
                      Get.snackbar(
                        "Contact Updated!", 
                        "The contact ${name} has been succesfully updated and saved!",
                        titleText: Text("Contact Updated!", style: GoogleFonts.comfortaa(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black),),
                        messageText: Text("The contact ${name} has been succesfully updated and saved!", style: GoogleFonts.comfortaa(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black),),
                        duration: Duration(seconds: 3), 
                        isDismissible: true, 
                        colorText: Colors.black, 
                        borderRadius: 10,
                        dismissDirection: DismissDirection.down,
                        icon: Icon(Icons.account_circle_outlined, color: Colors.tealAccent),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.white,
                      );
                    }
                    else {
                      firebaseCreateContact();
                      Get.snackbar(
                        "Contact Created!", 
                        "The contact ${name} has been succesfully createed and saved!",
                        titleText: Text("Contact Created!", style: GoogleFonts.comfortaa(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black),),
                        messageText: Text("The contact ${name} has been succesfully created and saved!", style: GoogleFonts.comfortaa(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black),),
                        duration: Duration(seconds: 3), 
                        isDismissible: true, 
                        colorText: Colors.black, 
                        borderRadius: 10,
                        dismissDirection: DismissDirection.down,
                        icon: Icon(Icons.account_circle_outlined, color: Colors.tealAccent),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.white,
                      );
                      print('${name }+ '' + ${number}');
                    }
                    Navigator.of(context).pop();
                  }
                }, 
                child: Text('Save Contact', style: GoogleFonts.comfortaa(fontSize: 17, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  //shadowColor: Colors.white,
                  foregroundColor: Colors.tealAccent, 
                  backgroundColor: Colors.tealAccent,
                  elevation: 2,
                  //surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    //side: BorderSide(
                      //color: Colors.black,
                      //style: BorderStyle.solid
                    //)
                  )
                ),
            ),
          ),
          SizedBox(
            height: 5
          ),
        ]
      ),
              )
    ),
            contentPadding: EdgeInsets.all(10),
            radius: 20,
  );
  }


  void showGetXDialogBoxForAddingContact() {
    Get.defaultDialog(
            title: 'New Contact',
            titleStyle: GoogleFonts.comfortaa(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 18,),
            titlePadding: EdgeInsets.only(top: 10, bottom: 10),
            backgroundColor: Colors.white,
            content: Form(
              key: _formKey,
              child: SizedBox(
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      //controller: nameController,
                      //initialValue: name
                      autocorrect: true,
                      keyboardType: TextInputType.name,
                      enableSuggestions: true,
                      enableInteractiveSelection: true,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        //labelStyle: ,
                        //hintStyle: ,
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: 'name:',
                        prefixIcon: Icon(Icons.account_circle_outlined, color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.tealAccent, width: 2.0),
                          borderRadius: BorderRadius.all(
                            const Radius.circular(50.0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.all(
                            const Radius.circular(50.0),
                          ),
                        ),           
                      ),
            onSaved: (value) {
                name = value!;
            },
            onChanged: (value) {
                name = value;
            },
            validator: (value) {
             if(value!.isEmpty) {
                return 'Input name';
             }
             return null;
            },
          ),
          SizedBox(
            height: 20
          ),
          TextFormField(
            autofocus: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            //controller: numberController,
            //initialValue: number
            autocorrect: true,
            keyboardType: TextInputType.number,
            enableSuggestions: true, 
            enableInteractiveSelection: true,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                //labelStyle: ,
                //hintStyle: ,
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'phone:',
                prefixIcon: Icon(Icons.call, color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent, width: 2.0),
                  borderRadius: BorderRadius.all(
                    const Radius.circular(50.0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.all(
                    const Radius.circular(50.0),
                  ),
                ),           
            ),
            onSaved: (value) {
                number = value!;
            },
            onChanged: (value) {
                number = value;
            },
            validator: (value) {
                final phoneRegEx = RegExp(r'[@#<>?:_`;[\]\\|=+)(*&^%0-9-]');
                if(value!.isEmpty) {
                  return "Input contact";
                } 
                else if(!phoneRegEx.hasMatch(value)) {
                  return 'Invalid contact';
                }
                return null;
            },
          ),
          SizedBox(
            height: 20
          ),
          SizedBox(
            height: 40,  //50
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () {
                  //Accessing Form through "_formKey"
                  if(_formKey.currentState!.validate()) {               
                    _formKey.currentState!.save();
                    firebaseCreateContact();
                    Get.snackbar(
                      "Contact Created!", 
                      "The contact ${name} has been succesfully created and saved!",
                      titleText: Text("Contact Created!", style: GoogleFonts.comfortaa(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black),),
                      messageText: Text("The contact ${name} has been succesfully created and saved!", style: GoogleFonts.comfortaa(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black),),
                      duration: Duration(seconds: 3), 
                      isDismissible: true, 
                      colorText: Colors.black, 
                      borderRadius: 10,
                      dismissDirection: DismissDirection.down,
                      icon: Icon(Icons.account_circle_outlined, color: Colors.tealAccent),
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.white,
                    );
                    print('${name }+ '' + ${number}');
                  }
                  //Navigator.of(context).pop();
                }, 
                child: Text('Save Contact', style: GoogleFonts.comfortaa(fontSize: 17, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  //shadowColor: Colors.white,
                  foregroundColor: Colors.tealAccent, 
                  backgroundColor: Colors.tealAccent,
                  elevation: 2,
                  //surfaceTintColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    //side: BorderSide(
                      //color: Colors.black,
                      //style: BorderStyle.solid
                    //)
                  )
                ),
            ),
          ),
          SizedBox(
            height: 5
          ),
        ]
      ),
              )
    ),
            contentPadding: EdgeInsets.all(10),
            radius: 20,
  );
  }



  final _formKey = GlobalKey<FormState>();  //very important for TextFormFields
  final nameController = TextEditingController();  
  final numberController = TextEditingController(); 
  String name = '';  //for onSaved function in "name text-form-field"
  String number = '';  //for onSaved function in "number text-form-field"
  String email = '';  //for onSaved function in "email text-form-field"


  void firebaseCreateContact() {
    final db = FirebaseFirestore.instance;
    db.collection('contacts').add({'name' : name, 'number': number}).whenComplete(() => print("$name and $number created successfully in database"));
  }


  @override
  void dispose() {
    //to dispose controllers after usage
    nameController.dispose();
    numberController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //to initialize controller after setting it
    super.initState();
    nameController.text = name;
    numberController.text = number;
  }

  @override
  Widget build(BuildContext context) {
    //with respect to scoped model
    final model = ScopedModel.of<ContactModel>(context);

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('C o n t a c t'),
        actions: [
          IconButton(
            onPressed: () {
              ///"Get.isDarkMode" is false by default
              //Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
              ThemeService().setThemeMode();
            },
            icon: Icon(           
              Icons.brightness_4_rounded,
            ), //Get.isDarkMode? Icons.nightlight : Icons.sunny_snowing,
            tooltip:'Dark/Light Theme',
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('contacts').snapshots(),
            builder: (context, snapshot) {
             return (snapshot.connectionState == ConnectionState.waiting)
            ?Center(child: CircularProgressIndicator(color: Colors.tealAccent, strokeWidth: 3))
            :ListView.separated(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 20);
              },
              itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListTile(
                  //contentPadding: EdgeInsets.all(8),
                  title: Text(
                    data['name'],  //model.contacts[index].name,
                    style: GoogleFonts.comfortaa(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  subtitle: Text(
                    data['number'],  //model.contacts[index].phoneNumber,
                    style: GoogleFonts.comfortaa(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  trailing: SizedBox(
                    height: 40,
                    width: 100,  //120, 
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        /*IconButton(
                          tooltip: 'Favourite',
                          onPressed: () {
                            FavouriteStorage().saveFavorite();
                            model.changeFavoriteStatus(index);               
                            print(model.contacts[index].isFavorite);
                            print('holla');
                            print(GetStorage('Favorite').read('isFavorite'));
                          }, 
                          icon: Icon(
                            model.contacts[index].isFavorite ? Icons.star : Icons.star_border,
                            color: model.contacts[index].isFavorite ? Colors.tealAccent : Colors.tealAccent,
                          ),
                        ),*/

                        IconButton(
                          onPressed: () async{
                            final phoneNumber = data['number'];
                            final url = "tel:$phoneNumber";
                            if(await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                          icon: Icon(Icons.call, color: Colors.tealAccent),
                          tooltip: 'Edit Contact',
                        ),

                        IconButton(
                          onPressed: () {
                            final db = FirebaseFirestore.instance;
                            db.collection('contacts').doc(data.id).delete().whenComplete(() => print("$name and $number deleted from database"));
                            Get.snackbar(
                              "Contact Deleted!", 
                              "contact succesfully deleted!",
                              titleText: Text("Contact Deleted!", style: GoogleFonts.comfortaa(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black),),
                              messageText: Text("contact succesfully deleted!", style: GoogleFonts.comfortaa(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black),),
                              duration: Duration(seconds: 3), 
                              isDismissible: true, 
                              colorText: Colors.black, 
                              borderRadius: 10,
                              dismissDirection: DismissDirection.down,
                              icon: Icon(Icons.account_circle_outlined, color: Colors.tealAccent),
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.white,
                            );
                          }, 
                          icon: Icon(Icons.delete)
                        )
                      ],
                    ),
                  ),
                  /*onTap: () {
                    setState(() {
                      model.contacts[index].isFavorite = false;
                    });
                    print(model.contacts[index].isFavorite);
                  },*/

                  onLongPress: () {
                    //edit/update data bu show dialog first befor editing
                    //final db = FirebaseFirestore.instance;
                    //db.collection('contacts').doc(data.id).update({'name' : name, 'number': number}).whenComplete(() => print("$name and $number has been successfully updated in database"));
                    showGetXDialogBoxForEditingContact(true, data);
                  },
                ),
              );
              }
            );
            }
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ignore: null_check_always_fails
          //showGetXDialogBoxForEditingContact(false, null!);
          showGetXDialogBoxForAddingContact();
        },
        child: Icon(Icons.add, color: Colors.white),
        tooltip: 'Add Contact',
        backgroundColor: Colors.tealAccent,
        elevation: 3,
      ),
    );
  }

}
