import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

const String facebookUrl = 'https://www.facebook.com/';
const String gmailUrl = 'https://mail.google.com/';
const String icloudUrl = 'https://www.icloud.com/';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/mobile_number': (context) => MobileNumberPage(),
        '/otp_verification': (context) => OtpVerificationPage(),
        '/account_created': (context) => AccountCreatedPage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showError = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Logo
                Image.network(
                  'https://cdn.dribbble.com/users/3061686/screenshots/17599145/figma-logo-2.png',
                  width: 200.0,
                  height: 150.0,
                ),

                // Create Your Account Heading
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 5.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Create Your Account!',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.0),

                // Email Input Field with Border
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold, // Make it bold
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your email',
                        ),
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!isValidEmail(value)) {
                            return 'Please enter a valid email (e.g., abc@gmail.com)';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.0),

                // Password Input Field with Border
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold, // Make it bold
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your password',
                        ),
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 8) {
                            return 'Password must contain at least 8 characters';
                          }
                          if (!isValidPassword(value)) {
                            return 'Password must consist of * characters only';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.0),

                Text(
                  'Password must contain at least 8 characters',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: showError ? Colors.red : Colors.transparent,
                  ),
                ),

                Container(
                  width: 300.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(context, '/mobile_number');
                      } else {
                        setState(() {
                          showError = true;
                        });
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 25),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                    ),
                  ),
                ),

                SizedBox(height: 20.0),
                Text(
                  'by clicking sign-up you are agreeing to the terms of service and privacy policy.',
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  '━━━━━━━━━ Or sign in with ━━━━━━━━━',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 10.0),

                // Row of buttons for signing in with Gmail, Facebook, and iCloud
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // ignore: deprecated_member_use
                        launch(gmailUrl); // Open Gmail login page
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black, // Button background color
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.mail,
                              size: 24,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Gmail',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0), // Add spacing between buttons
                    InkWell(
                      onTap: () {
                        // ignore: deprecated_member_use
                        launch(facebookUrl); // Open Gmail login page
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue, // Button background color
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.facebook,
                              size: 24,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Facebook',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0), // Add spacing between buttons
                    InkWell(
                      onTap: () {
                        // ignore: deprecated_member_use
                        launch(icloudUrl);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black, // Button background color
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          children: [
                            Icon(
                              Icons.cloud,
                              size: 24,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'iCloud',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange, // Change text color to orange
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp('@gmail.com');
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    return password.length >= 8;
  }
}

class MobileNumberPage extends StatefulWidget {
  @override
  _MobileNumberPageState createState() => _MobileNumberPageState();
}

class _MobileNumberPageState extends State<MobileNumberPage> {
  TextEditingController mobileController = TextEditingController();
  bool showError = false;

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo
              Image.network(
                'https://cdn.dribbble.com/users/3061686/screenshots/17599145/figma-logo-2.png',
                width: 200.0,
                height: 150.0,
              ),

              SizedBox(height: 20.0),

              // Text: Verify your mobile number (bold)
              Text(
                'Verify your mobile number',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10.0),

              // Text: OTP will be sent to this number
              Text(
                'OTP will be sent to this number',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),

              SizedBox(height: 20.0),

              // Mobile Number Input Field
              Container(
                width: 300.0,
                height: 50.0,
                padding: EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: TextFormField(
                  controller: mobileController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixText: '+91 ',
                    prefixStyle: TextStyle(
                      fontWeight: FontWeight.bold, // Apply bold style here
                    ),
                    hintText: 'Enter your mobile number',
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 10, // Allow for the "+91 " prefix
                  onChanged: (value) {
                    setState(() {
                      showError = false;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    if (value.length < 10) {
                      return 'Mobile number is incomplete';
                    }
                    if (!isNumeric(value)) {
                      return 'Please enter a valid mobile number';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (mobileController.text.length == 10) {
                    // Pass the mobile number to the OTP verification page
                    Navigator.pushNamed(context, '/otp_verification',
                        arguments: mobileController.text);
                  } else {
                    setState(() {
                      showError = true;
                    });
                  }
                },
                child: Text('Send OTP'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  minimumSize: Size(200, 50),
                ),
              ),

              SizedBox(height: 10.0),

              if (showError)
                Text(
                  'Please enter correct number',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  bool isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }
}

class OtpVerificationPage extends StatefulWidget {
  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  List<TextEditingController> otpControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  bool showError = false;

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mobileNumber = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo
              Image.network(
                'https://cdn.dribbble.com/users/3061686/screenshots/17599145/figma-logo-2.png',
                width: 200.0,
                height: 150.0,
              ),

              SizedBox(height: 20.0),

              // Text: Enter the OTP (bold)
              Text(
                'Enter the OTP',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10.0),

              // Text: We have sent an OTP to [mobileNumber]
              Text(
                'We have sent an OTP to the number $mobileNumber',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),

              SizedBox(height: 20.0),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: TextFormField(
                      controller: otpControllers[index],
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                      ),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 3.0),

              // Error Message
              if (showError)
                Text(
                  'Please enter the code above',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.red,
                  ),
                ),

              SizedBox(height: 10.0),

              // Didn't receive the OTP?
              Text(
                "Didn't receive the OTP?",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 20.0),

              // Verify OTP Button
              ElevatedButton(
                onPressed: () {
                  bool isOtpEntered = true;
                  for (var controller in otpControllers) {
                    if (controller.text.isEmpty) {
                      isOtpEntered = false;
                      break;
                    }
                  }

                  if (isOtpEntered) {
                    // Add logic to verify OTP and proceed to the next page
                    Navigator.pushNamed(context, '/account_created');
                  } else {
                    setState(() {
                      showError = true;
                    });
                  }
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  minimumSize: Size(200, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OTPTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.0,
      child: TextFormField(
        maxLength: 1,
        decoration: InputDecoration(
          counterText: '',
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class AccountCreatedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Created',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Account Created!'),
          ],
        ),
      ),
    );
  }
}
