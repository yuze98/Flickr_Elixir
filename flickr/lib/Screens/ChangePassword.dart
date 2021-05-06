


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: changPassword(),
    );
  }
}



class changPassword extends StatefulWidget {
  @override
  _ChangePassword createState() => _ChangePassword();

}

class _ChangePassword extends  State<changPassword>  {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    double deviceSizeheight=MediaQuery.of(context).size.height;
    double deviceSizewidth=MediaQuery.of(context).size.width;


    return MaterialApp(
      title: 'Flickr',
      home: Scaffold(
        resizeToAvoidBottomInset: false,   //new line

        appBar: AppBar(
            backgroundColor: Colors.black,
          leading: Image.asset('images/flickricon.png'),
            title: Text(
              'Change Password ',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
toolbarHeight:deviceSizeheight*.1 ,
      ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20,bottom: 20),
              child:  Align(
                alignment: Alignment.centerLeft,

                child: Container(
                  child: Text("Enter New Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.black),
      ),
          ),
              ),
            ),

            Container(
              width: deviceSizewidth*.9,

              child: TextField(
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(

                  filled: true,
                  contentPadding: EdgeInsets.all(25),
                  border: OutlineInputBorder(borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                  ),
                  hintText: 'Old Password',

                  fillColor: Colors.white,
                ),

                    ),
            ), Padding(
              padding: const EdgeInsets.only(left: 20, top: 20,bottom: 20),
              child:  Align(
                alignment: Alignment.centerLeft,

                child: Container(
                  child: Text("Enter New Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.black),
                  ),
                ),
              ),
            ),
          Container(
            width: deviceSizewidth*.9,

            child: TextField(

              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(

                filled: true,
                contentPadding: EdgeInsets.all(25),
                border: OutlineInputBorder(borderRadius: const BorderRadius.all(
                  const Radius.circular(10.0),
                ),
                ),
                hintText: 'New Password',

                fillColor: Colors.white,
    ),
          ),
          ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20,bottom: 20),
              child:  Align(
                alignment: Alignment.centerLeft,

                child: Container(
                  child: Text("Enter New Password",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.black),
                  ),
                ),
              ),
            ),
            Container(
              width: deviceSizewidth*.9,
      child: TextField(
        keyboardType: TextInputType.text,
        obscureText: true,
                decoration: InputDecoration(

                  filled: true,
                  contentPadding: EdgeInsets.all(25),
                  border: OutlineInputBorder(borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                  ),
                  hintText: 'Confirm Password',

                  fillColor: Colors.white,
                ),
              ),
    ), Padding(
      padding: const EdgeInsets.only(top:200),
      child: Container(
        child: TextButton(

              style:ButtonStyle( backgroundColor: MaterialStateProperty.all(Colors.white),shape: MaterialStateProperty.all<RoundedRectangleBorder>( RoundedRectangleBorder( borderRadius: BorderRadius.circular(40.0),
                side: BorderSide(color: Colors.black),

            ),
            ),
            ),
          onPressed: () {
            primary:Colors.deepOrange;

            print('Pressed');
          },
                  child: Text('Confirm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.black,),


              )),
    ),),],
        ),
    backgroundColor: Colors.white,
      ),
    );
  }




  }


