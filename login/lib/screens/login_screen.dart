import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login/firebase/email_auth.dart';
import 'package:login/responsive.dart';
import 'package:login/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController email = TextEditingController();
TextEditingController passwd = TextEditingController();



final btnGoogle = SocialLoginButton(
  buttonType: SocialLoginButtonType.google,
  onPressed: () {},
);

final btnFb= SocialLoginButton(
  buttonType: SocialLoginButtonType.facebook,
  onPressed: () {},
);

final btnGit = SocialLoginButton(
  buttonType: SocialLoginButtonType.github,
  onPressed: () {},
);

final imgLogo=Image.asset('assets/logo.png');

final spaceH= SizedBox(height: 15);

class _LoginScreenState extends State<LoginScreen> {

  EmailAuth emailAuth = EmailAuth();
  bool isLoading =false;

  @override
  Widget build(BuildContext context) {

    final txtEmail =  TextFormField(
      controller: email,
      decoration: const InputDecoration(
        label: Text('email'),
        border: OutlineInputBorder()),
    );

    final txtPass =  TextFormField( 
      controller: passwd,
      decoration: const InputDecoration(
        label: Text('password'),
        border: OutlineInputBorder()),
    );  

  final txtRegister = Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
         onPressed: () {
          Navigator.pushNamed(context, '/register');
        }, 
      child: const Text('crear cuenta'),
    ),
  );

  final btnEmail = SocialLoginButton(
    buttonType: SocialLoginButtonType.generalLogin,
    onPressed: () {
      isLoading =true;
      setState(() {}); //renderiza la interfaz
      emailAuth.signInWithEmailAndPassword(
        email: email.text,
        password: passwd.text
      ).then((value){
        if(value){   
          isLoading=false;
          Navigator.pushNamed(context, '/dash');
        }else{
          isLoading=false;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('error')
            )
          );
        }
      });
    },
  );

  return Scaffold(
    resizeToAvoidBottomInset: false,
      body:SafeArea(
        child: Responsive(
            mobile: MobileViewWidget(btnEmail: btnEmail, txtRegister: txtRegister, isLoading: isLoading),
            desktop: WebViewWidget(btnEmail: btnEmail, txtRegister: txtRegister),
          ),
      ),
    );
  }
}

class WebViewWidget extends StatelessWidget {
  const WebViewWidget({
    Key? key,
    required this.btnEmail,
    required this.txtRegister,
  }) : super(key: key);

  final SocialLoginButton btnEmail;
  final Padding txtRegister;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          opacity: .4,
          fit: BoxFit.cover,
          image: AssetImage('assets/1.jpeg')
        )
      ),
      child: Expanded(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    spaceH,
                    Row(
                      children: [
                        const Spacer(),
                        Expanded(
                          flex: 8,
                          child:Image.asset('assets/logo.png') 
                        ),
                        const Spacer()
                      ],
                    ),
                    spaceH
                  ],
                ),
            ),
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 450,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: email,
                          decoration: const InputDecoration(
                            label: Text('email'),
                            border: OutlineInputBorder()),
                        ),
                        spaceH,
                        TextFormField( 
                          controller: passwd,
                          decoration: const InputDecoration(
                            label: Text('password'),
                            border: OutlineInputBorder()),
                        ),
                        spaceH,
                        btnEmail,
                        spaceH,
                        btnGoogle,
                        spaceH,
                        btnFb,
                        spaceH,
                        btnGit,
                        spaceH,
                        txtRegister
                      ],
                    ),
                  ),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}

class MobileViewWidget extends StatelessWidget {
  const MobileViewWidget({
    Key? key,
    required this.btnEmail,
    required this.txtRegister,
    required this.isLoading,
  }) : super(key: key);

  final SocialLoginButton btnEmail;
  final Padding txtRegister;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: .4,
              fit: BoxFit.cover,
              image: AssetImage('assets/1.jpeg')
            )
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        children: [
                          spaceH,
                          Row(
                            children: [
                              const Spacer(),
                              Expanded(
                                flex: 8,
                                child:Image.asset('assets/logo.png') 
                              ),
                              const Spacer()
                            ],
                          ),
                          spaceH
                        ],
                      ),
                      TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                          label: Text('email'),
                          border: OutlineInputBorder()),
                      ),
                      spaceH,
                      TextFormField( 
                        controller: passwd,
                        decoration: const InputDecoration(
                          label: Text('password'),
                          border: OutlineInputBorder()),
                      ),
                      spaceH,
                      btnEmail,
                      spaceH,
                      btnGoogle,
                      spaceH,
                      btnFb,
                      spaceH,
                      btnGit,
                      spaceH,
                      txtRegister
                    ],
                  ),
            ),
          ),
        ),
        isLoading? const LoadingModalWidget():Container()
      ],
    );
  }
}