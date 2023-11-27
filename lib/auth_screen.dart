import 'dart:math';

import 'package:authscreen/constants.dart';
import 'package:authscreen/widgets/homepage.dart';
import 'package:authscreen/widgets/login_form.dart';
import 'package:authscreen/widgets/signup_form.dart';
import 'package:authscreen/widgets/socal_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;
  bool _isSowSignUp = false;
  void SetUpAnimation(){
    _animationController = AnimationController(vsync: this,duration: defaultDuration );
    _animationTextRotate = Tween<double>(begin: 0, end: 90).animate(_animationController);
      }
  @override
  void initState() {
    SetUpAnimation();
    super.initState();
  }
  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }
  void UpdateView(){
    setState(() {
      _isSowSignUp = !_isSowSignUp;
    });
    _isSowSignUp ? _animationController.forward() : _animationController.reverse();
  }
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
      animation: _animationController,
        builder: (context, _) {
          return Stack(
            children: [
              AnimatedPositioned(
                duration: defaultDuration,
                width: _size.width * 0.88,
                height: _size.height,
                left: _isSowSignUp ? -_size.width * 0.76 : 0,
                child: Container(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isSowSignUp = !_isSowSignUp;
                      });
                    },
                    child: Container(
                      color: login_bg,
                      child: LoginForm(),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                  duration: defaultDuration,
                  height: _size.height,
                  width: _size.width * 0.88,
                  left: _isSowSignUp ? _size.width * 0.12 : _size.width * 0.88,
                  child: Container(
                    color: signup_bg,
                    child: SignUpForm(),
                  )),
              AnimatedPositioned(
                  duration: defaultDuration,
                  top: _size.height * 0.1,
                  left: 0,
                  right: _isSowSignUp ? -_size.width * 0.06 : _size.width * 0.06,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white60,
                    child: AnimatedSwitcher(
                      duration: defaultDuration,
                      child: _isSowSignUp
                          ? SvgPicture.asset(
                              "assets/animation_logo.svg",
                              color: signup_bg,
                            )
                          : SvgPicture.asset(
                              "assets/animation_logo.svg",
                              color: login_bg,
                            ),
                    ),
                  )),
              AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width,
                  bottom: _size.height * 0.1,
                  right: _isSowSignUp ? -_size.width * 0.06 : _size.width * 0.06,
                  child: SocalButtns()),
              AnimatedPositioned(
                  duration: defaultDuration,
                  bottom: _isSowSignUp ? _size.height / 2 - 80 : _size.height * 0.3,
                  left: _isSowSignUp ? 0 : _size.width * 0.44 - 80,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: _isSowSignUp ? 20 : 32,
                          color: _isSowSignUp ? Colors.white : Colors.white70),
                    child: Transform.rotate(
                      alignment: Alignment.topLeft,
                      angle: -_animationTextRotate.value * pi / 180,
                      child: InkWell(
                        onTap: (){
                          if(_isSowSignUp){
                            UpdateView();
                          }
                          else {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyWidget()));
                          }
                        },
                        child: Container(
                          padding:EdgeInsets.symmetric(vertical: defpaultPadding * 0.75),
                          //color: Colors.amber,
                          width: 160,
                          child: Text(
                              "Log in".toUpperCase(),
                            ),
                        ),
                      ),
                    ),
                  )),
                  AnimatedPositioned(
                  duration: defaultDuration,
                  bottom: !_isSowSignUp ? _size.height / 2- 80 : _size.height * 0.3,
                  right: _isSowSignUp ?  _size.width * 0.44 - 80 : 0,
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: !_isSowSignUp ? 20 : 32,
                          color: _isSowSignUp ? Colors.white : Colors.white70),
                    child: Transform.rotate(
                      alignment: Alignment.topRight,
                      angle: (90 -_animationTextRotate.value) * pi / 180,
                      child: InkWell(
                        onTap: (){
                          if(_isSowSignUp){
                           Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyWidget()));
                          }
                          else {
                          UpdateView();
                          }
                        },
                        child: Container(
                          padding:EdgeInsets.symmetric(vertical: defpaultPadding * 0.75),
                          //color: Colors.amber,
                          width: 160,
                          child: Text(
                              "Sign Up".toUpperCase(),
                            ),
                        ),
                      ),
                    ),
                  ))
            ],
          );
        }
      ),
    );
  }
}
