import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(
              0.08 * width, .02 * height, .08 * width, .058 * height),
          padding: EdgeInsets.fromLTRB(
              .02 * width, .034 * height, .02 * width, .08 * height),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  spreadRadius: .03,
                  color: Colors.black.withOpacity(.3),
                )
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextField(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red[700],
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  border: Theme.of(context).inputDecorationTheme.border,
                  icon: Image.asset(
                    'assets/images/icons/user.png',
                    color: Colors.red[700],
                    width: 0.05 * width,
                  ),
                  hintText: 'Name',
                ),
              ),
              SizedBox(
                height: 0.034 * MediaQuery.of(context).size.height,
              ),
              TextField(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red[700],
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: Theme.of(context).inputDecorationTheme.border,
                  icon: Image.asset(
                    'assets/images/icons/email.png',
                    color: Colors.red[700],
                    width: 0.05 * width,
                  ),
                  hintText: 'Email',
                ),
              ),
              SizedBox(
                height: 0.034 * MediaQuery.of(context).size.height,
              ),
              TextField(
                obscureText: true,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red[700],
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  border: Theme.of(context).inputDecorationTheme.border,
                  icon: Image.asset(
                    'assets/images/icons/password.png',
                    color: Colors.red[700],
                    width: 0.05 * width,
                  ),
                  hintText: 'Password',
                ),
              ),
              SizedBox(
                height: 0.034 * MediaQuery.of(context).size.height,
              ),
              TextField(
                obscureText: true,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red[700],
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                ),
                decoration: InputDecoration(
                  border: Theme.of(context).inputDecorationTheme.border,
                  icon: Image.asset(
                    'assets/images/icons/confirm.png',
                    color: Colors.red[700],
                    width: 0.05 * width,
                  ),
                  hintText: 'Confirm Password',
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: .029 * height,
          left: (MediaQuery.of(context).size.width * 0.5) - (0.179 * width),
          child: RaisedButton(
            padding: EdgeInsets.symmetric(
                horizontal: .08 * width, vertical: 0.01 * height),
            color: Theme.of(context).buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 5,
            child: Text(
              'SIGN UP',
              style: Theme.of(context)
                  .textTheme
                  .button
                  .copyWith(color: Colors.red[700]),
            ),
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
