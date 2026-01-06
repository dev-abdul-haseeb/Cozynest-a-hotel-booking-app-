import 'package:flutter/material.dart';
import 'package:hotel_booking/Data/Database.dart';
import 'package:hotel_booking/Functions/TextStyles.dart';
import 'package:hotel_booking/homeScreen.dart';
import 'package:lottie/lottie.dart';

class loginScreen extends StatefulWidget {
  @override
  State<loginScreen> createState() => _loginScreenState();
}

var username = TextEditingController();
var password = TextEditingController();

var inputName = TextEditingController();
var inputCity = TextEditingController();
var inputCountry = TextEditingController();
var inputUsername = TextEditingController();
var inputPassword = TextEditingController();

class _loginScreenState extends State<loginScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    DBManager.getInstance().expirePastPendingBookings();
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    username.text = "";
    password.text = "";

    inputName.text = "";
    inputCity.text = "";
    inputCountry.text = "";
    inputUsername.text = "";
    inputPassword.text = "";

    final List<Widget> _pages = [
      getLoginScreen(screenWidth, screenHeight, _onItemTapped, context),
      getSignUpScreen(screenWidth, screenHeight, _onItemTapped,context),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('CozyNest', style: LogoHead(screenHeight * 0.04)),
        centerTitle: true,
        backgroundColor: Colors.green.shade100,
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Lottie.asset(
              'Assets/Animations/SplashScreenGradient.json',
              fit: BoxFit.cover,
            ),
          ),
          Center(child: _pages[_selectedIndex]),
        ],
      ),
    );
  }
}

Widget getLoginScreen(
  double screenWidth,
  double screenHeight,
  Function(int) onTabChange,
  BuildContext context,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(height: screenHeight * 0.07),
      Container(
        width: screenWidth * 0.55,
        height: screenHeight * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey.shade600,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth * 0.27,
              height: screenHeight * 0.05,
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'Log in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenHeight*0.025,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () => onTabChange(1),
              child: Container(
                width: screenWidth * 0.23,
                height: screenHeight * 0.055,
                child: Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenHeight*0.02,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),    //LoginSignUp buttons
      SizedBox(height: screenHeight * 0.1),
      Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey.shade600.withOpacity(0.7),
        ),
        child: Column(
          children: [
            SizedBox(height: screenHeight*0.025,),
            Container(
              width: screenWidth*0.8,
              height: screenHeight*0.05,
              child: Center(child: Text('Welcome back!',style: TextStyle(fontSize: screenHeight*0.035,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.blue.shade100),)),
            ),    //Welcome
            SizedBox(height: screenHeight*0.045,),
            Column(
              children: [
                Container(
                  width: screenWidth*0.7,
                  height: screenHeight*0.05,
                  child: Text('Enter username:',style: TextStyle(fontSize: screenHeight*0.025,color: Colors.green.shade100,fontFamily: 'RobotSerif',fontWeight: FontWeight.bold),),
                ),
                Container(
                    width: screenWidth*0.7,
                    height: screenHeight*0.07,
                    child: TextField(
                      controller: username,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.blue.shade50,fontSize: screenHeight*0.02,fontStyle: FontStyle.italic),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.green, width: 3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue, width: 3),
                        ),
                      ),
                    )
                ),
              ],
            ),      //Username TextField
            SizedBox(height: screenHeight*0.03,),
            Column(
              children: [
                Container(
                  width: screenWidth*0.7,
                  height: screenHeight*0.05,
                  child: Text('Enter password:',style: TextStyle(fontSize: screenHeight*0.025,color: Colors.green.shade100,fontFamily: 'RobotSerif',fontWeight: FontWeight.bold),),
                ),
                Container(
                    width: screenWidth*0.7,
                    height: screenHeight*0.07,
                    child: TextField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.blue.shade50,fontSize: screenHeight*0.02,fontStyle: FontStyle.italic),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.green, width: 3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue, width: 3),
                        ),
                      ),
                    )
                ),
              ],
            ),      //Password TextField
            SizedBox(height: screenHeight*0.03,),
            Container(
              width: screenWidth*0.3,
              height: screenHeight*0.05,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade200,
                ),
                onPressed: () async {
                  if (username.text.isEmpty || password.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill all fields")),
                    );
                    return;
                  }

                  DBManager db = DBManager.getInstance();
                  final user = await db.getUser(
                    username: username.text,
                    password: password.text,
                  );

                  if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Invalid username or password")),
                    );
                    return;
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => homeScreen(username: user['username'],name: user['name'],city: user['city'],country: user['country'],)),
                    );
                  }
                },
                child: Text('Log In', style: TextStyle(color: Colors.grey.shade600,fontSize: screenHeight*0.025,fontWeight: FontWeight.bold),)),
            )     //Button
          ],
        ),
      ),    //Form Container
    ],
  );
}

Widget getSignUpScreen(
  double screenWidth,
  double screenHeight,
  Function(int) onTabChange,
  BuildContext context,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(height: screenHeight * 0.07),
      Container(
        width: screenWidth * 0.55,
        height: screenHeight * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.grey.shade600,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => onTabChange(0),
              child: Container(
                width: screenWidth * 0.23,
                height: screenHeight * 0.055,
                child: Center(
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenHeight*0.02,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.3,
              height: screenHeight * 0.05,
              decoration: BoxDecoration(
                color: Colors.grey.shade700,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenHeight*0.027,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),      //Login/SignUp button
      SizedBox(height: screenHeight * 0.062),
      Container(
        width: screenWidth * 0.8,
        height: screenHeight * 0.61,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey.shade600.withOpacity(0.7),
        ),
        child: Column(
          children: [
            SizedBox(height: screenHeight*0.025,),
            Container(
              width: screenWidth*0.78,
              height: screenHeight*0.089,
              child: Center(
                child: Column(
                  children: [
                    Text('Welcome to',style: TextStyle(fontSize: screenHeight*0.025,fontWeight: FontWeight.bold, color: Colors.blue.shade100),),
                    Text('CozyNest!',style: TextStyle(fontSize: screenHeight*0.035,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, color: Colors.green.shade100),),
                  ],
                )
              ),
            ),    //Welcome
            SizedBox(height: screenHeight*0.017,),
            Column(
              children: [
                Container(
                  width: screenWidth*0.7,
                  height: screenHeight*0.04,
                  child: Text('Enter name:',style: TextStyle(fontSize: screenHeight*0.023,color: Colors.green.shade100,fontFamily: 'RobotSerif',fontWeight: FontWeight.bold),),
                ),
                Container(
                    width: screenWidth*0.7,
                    height: screenHeight*0.05,
                    child: TextField(
                      controller: inputName,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        hintStyle: TextStyle(color: Colors.blue.shade50,fontSize: screenHeight*0.02,fontStyle: FontStyle.italic),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.green, width: 3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue, width: 3),
                        ),
                      ),
                    )
                ),
              ],
            ),      //Name TextField
            SizedBox(height: screenHeight*0.01,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: screenWidth*0.35,
                      height: screenHeight*0.04,
                      child: Text('City:',style: TextStyle(fontSize: screenHeight*0.023,color: Colors.green.shade100,fontFamily: 'RobotSerif',fontWeight: FontWeight.bold),),
                    ),
                    Container(
                        width: screenWidth*0.34,
                        height: screenHeight*0.05,
                        child: TextField(
                          controller: inputCity,
                          decoration: InputDecoration(
                            hintText: 'City',
                            hintStyle: TextStyle(color: Colors.blue.shade50,fontSize: screenHeight*0.02,fontStyle: FontStyle.italic),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.green, width: 3),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue, width: 3),
                            ),
                          ),
                        )
                    ),
                  ],
                ),    //City TextField
                SizedBox(width: screenWidth*0.02,),
                Column(
                  children: [
                    Container(
                      width: screenWidth*0.35,
                      height: screenHeight*0.04,
                      child: Text('Country:',style: TextStyle(fontSize: screenHeight*0.023,color: Colors.green.shade100,fontFamily: 'RobotSerif',fontWeight: FontWeight.bold),),
                    ),
                    Container(
                        width: screenWidth*0.34,
                        height: screenHeight*0.05,
                        child: TextField(
                          controller: inputCountry,
                          decoration: InputDecoration(
                            hintText: 'Country',
                            hintStyle: TextStyle(color: Colors.blue.shade50,fontSize: screenHeight*0.02,fontStyle: FontStyle.italic),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.green, width: 3),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.blue, width: 3),
                            ),
                          ),
                        )
                    ),
                  ],
                ),    //Country TextField
              ],
            ),      //Location TextField
            SizedBox(height: screenHeight*0.01,),
            Column(
              children: [
                Container(
                  width: screenWidth*0.7,
                  height: screenHeight*0.04,
                  child: Text('Enter username:',style: TextStyle(fontSize: screenHeight*0.023,color: Colors.green.shade100,fontFamily: 'RobotSerif',fontWeight: FontWeight.bold),),
                ),
                Container(
                    width: screenWidth*0.7,
                    height: screenHeight*0.05,
                    child: TextField(
                      controller: inputUsername,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.blue.shade50,fontSize: screenHeight*0.02,fontStyle: FontStyle.italic),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.green, width: 3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue, width: 3),
                        ),
                      ),
                    )
                ),
              ],
            ),      //Username TextField
            SizedBox(height: screenHeight*0.01,),
            Column(
              children: [
                Container(
                  width: screenWidth*0.7,
                  height: screenHeight*0.04,
                  child: Text('Enter password:',style: TextStyle(fontSize: screenHeight*0.023,color: Colors.green.shade100,fontFamily: 'RobotSerif',fontWeight: FontWeight.bold),),
                ),
                Container(
                    width: screenWidth*0.7,
                    height: screenHeight*0.05,
                    child: TextField(
                      controller: inputPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.blue.shade50,fontSize: screenHeight*0.02,fontStyle: FontStyle.italic),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.green, width: 3),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue, width: 3),
                        ),
                      ),
                    )
                ),
              ],
            ),      //Password TextField
            SizedBox(height: screenHeight*0.02,),
            Container(
              width: screenWidth*0.315,
              height: screenHeight*0.05,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade200,
                  ),
                  onPressed: () async{
                    if (inputName.text.isEmpty ||
                        inputCity.text.isEmpty ||
                        inputCountry.text.isEmpty ||
                        inputUsername.text.isEmpty ||
                        inputPassword.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please fill in all fields'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    else {
                      DBManager db = DBManager.getInstance();
                      bool success = await db.insertUser(
                        username: inputUsername.text,
                        password: inputPassword.text,
                        name: inputName.text,
                        city: inputCity.text,
                        country: inputCountry.text,
                      );

                      if (success) {
                        onTabChange(0);
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Username already exists!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  child: Text('Sign Up', style: TextStyle(color: Colors.grey.shade600,fontSize: screenHeight*0.022,fontWeight: FontWeight.bold),)),
            )     //Button
          ],
        ),
      ),    //Form Container
    ],
  );
}
