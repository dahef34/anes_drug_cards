import 'package:flutter/material.dart';
import 'package:news_app/models/config.dart';
import 'package:news_app/pages/intro.dart';
import 'package:news_app/pages/sign_up.dart';
import 'package:news_app/utils/next_screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool signInStartGoogle = false;
  double leftPaddingGoogle = 20;
  double rightPaddingGoogle = 20;
  bool signInCompleteGoogle = false;

  bool signInStartFb = false;
  double leftPaddingFb = 10;
  double rightPaddingFb = 10;
  bool signInCompleteFb = false;

  handleAfterSignupGoogle() {
    setState(() {
      leftPaddingGoogle = 20;
      rightPaddingGoogle = 20;
      Future.delayed(Duration(milliseconds: 1000)).then((f) {
        nextScreenReplace(context, IntroPage());
      });
    });
  }

  handleAfterSignupFb() {
    setState(() {
      leftPaddingFb = 10;
      rightPaddingFb = 10;
      Future.delayed(Duration(milliseconds: 1000)).then((f) {
        nextScreenReplace(context, IntroPage());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage(Config().splashIcon),
                      height: 130,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: 'Welcome to ',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700]),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Drug',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600)),
                              TextSpan(
                                  text: 'Cards',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30, right: 30, top: 5),
                          child: Text(
                            'Sign In to continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black45),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
            SizedBox(
              height: 15,
            ),
            Spacer(),
            Text("Sign back in!"),
            FlatButton(
              child: Text(
                'Continue with Email  >>',
                style: TextStyle(color: Colors.blueAccent),
              ),
              onPressed: () {
                nextScreen(context, SignUpPage());
              },
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
