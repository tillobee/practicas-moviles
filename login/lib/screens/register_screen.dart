import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/firebase/email_auth.dart';
import 'package:social_login_buttons/social_login_buttons.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool _noImg=true;
  String _path='';

  EmailAuth? emailAuth = EmailAuth();

  final spaceH = SizedBox(height: 15);

  TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();


  /* final btnSend = SocialLoginButton(
    buttonType: SocialLoginButtonType.generalLogin, 
    text: 'Registrar cuenta',
    onPressed:(() {_validate();}) 
  ); */

  final txtPass = TextFormField(
    decoration: const InputDecoration(
      label: Text('Password'),
      border:OutlineInputBorder()
    ),
    obscureText: true,
    validator: ValidationBuilder().build(),
  );

  final txtFirstN = TextFormField(
    decoration: const InputDecoration(
      label: Text('First name'),
      border:OutlineInputBorder()
    ),
    validator: ValidationBuilder().build(),
  );

  final txtLastN = TextFormField(
    decoration: const InputDecoration(
      label: Text('Last name'),
      border:OutlineInputBorder(),
    ),
    validator: ValidationBuilder().build(),
  );

  final txtEmail = TextFormField(
    decoration: const InputDecoration(
      label: Text('Email'),
      border:OutlineInputBorder()
    ),
    validator: ValidationBuilder().email().maxLength(100).build(),
  );

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _validate(){
    _formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: .4,
            fit: BoxFit.cover,
            image: AssetImage('assets/1.jpeg')
          ) 
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Subir foto',style: TextStyle(fontSize: 16)),
                    spaceH,
                    //si no hay imagen muestra boton para abrir modal de selección
                    //Si no hay imagen cargar el icono de no IMAGE al boton imagen y abrir modal para ahi mismo cargar una foto
                    GestureDetector(
                      onTap: (() {
                        showBottomSheet();
                      }),
                      child:ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(50),
                          child:_noImg
                                ?Image.asset('assets/no_image.jpg')
                                :Image.file(
                                  File(_path), 
                                  fit: BoxFit.fill
                                ),
                        ),
                      ),
                    ),
                    spaceH,
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        label: Text('Email'),
                        border:OutlineInputBorder()
                      ),
                      validator: ValidationBuilder().email().maxLength(100).build(),
                    ),
                    spaceH,
                    TextFormField(
                      controller: password,
                      decoration: const InputDecoration(
                        label: Text('Password'),
                        border:OutlineInputBorder()
                      ),
                      obscureText: true,
                      validator: ValidationBuilder().build(),
                    ),
                    spaceH,
                    SocialLoginButton(
                      buttonType: SocialLoginButtonType.generalLogin, 
                      text: 'Registrar cuenta',
                      onPressed:(() {
                        _validate();
                        emailAuth!.createUserWithEmailAndPassword(
                            email: email.text,
                            password: password.text
                          );
                        }
                      ) 
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheet() =>showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10)
        )
    ), 
    builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.image_search),
          title: const Text('Escoger de galería'),
          onTap: (() {
            pickImageGallery().then(((value) {
              Navigator.pop(context);
              setState(() {
               if(_path!=''){
                _noImg=false;
               }
              });
            }));
          }),
        ),
        ListTile(
          leading: const Icon(Icons.camera),
          title: const Text('Tomar foto'),
          onTap: (() {
            takePictureCamera().then((value){
              Navigator.pop(context);
              if(_path!=''){
                _noImg=false;
              }
            });
          }),
        )
      ],
    )
  );

  Future pickImageGallery() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return ;
      final tempPath = image.path;
      setState(() => _path=tempPath);
    } on PlatformException catch(e){
      print('failed $e');
    }
  }
  
  Future takePictureCamera() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null) return ;
      final tempPath = image.path;
      setState(() => _path=tempPath);
    } on PlatformException catch(e){
      print('failed $e');
    }
  }

}