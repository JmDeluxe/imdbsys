import 'package:flutter/material.dart';
import 'package:registration/Pages/Register.dart';
import '../login.dart';

class body extends StatelessWidget {
  const body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: -85,
            left: -60,
            child: Image.asset('assets/magicpattern-blob-1684655777828.png',
            width: size.width * 0.5,),
          ),
          Positioned(
            bottom: -85,
            right: -40,
            child: Image.asset('assets/magicpattern-blob-1684655786407.png',
              width: size.height * 0.3,),
          ),
          Positioned(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('WELCOME TO PLATE', style: TextStyle(fontSize: 20, letterSpacing: 2),),
                SizedBox(height: 10,),
                Image.asset('assets/checking.png', width: size.height * 0.3,),
                SizedBox(height: 20,),
                Container(
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      colors: [
                        Colors.orange.withOpacity(0.7),
                        Colors.deepOrangeAccent,
                      ]
                    )
                  ),
                  child: TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return login();
                    }));
                  },
                    child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 17),),
                    style: TextButton.styleFrom(padding: EdgeInsets.all(16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),)),
                  ),
                ),
                SizedBox(height: 12,),
                Container(
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          colors: [
                            Colors.deepOrangeAccent,
                            Colors.orange.withOpacity(0.7),
                          ]
                      )
                  ),
                  child: TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Register();
                    }));
                  },
                    child: Text('Register',style: TextStyle(color: Colors.white, fontSize: 17),),
                    style: TextButton.styleFrom(padding: EdgeInsets.all(16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }

}
