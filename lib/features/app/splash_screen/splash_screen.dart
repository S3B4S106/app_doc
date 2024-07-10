import 'package:app_doc/pages/login/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';


class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});
  

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;
  TextStyle? font = GoogleFonts.getFont('Dancing Script');
  late VideoPlayerController _controller;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    _prefs.then((SharedPreferences prefs){
      bool switchValue = prefs.getBool('authenticade') ?? false;
      if(widget.child is LoginScreen || !switchValue){
       return normalProcess();
      }
      auth.isDeviceSupported().then(
          (bool isSupported) => setState(() {
            if(isSupported){
              _authenticate();
            }else{
              normalProcess();
            }
          }));
    });
    
    _controller = VideoPlayerController.asset("assets/Opening.mp4");
    _controller.initialize().then((_) {
      _controller.play();
    });
    
    
    super.initState();
  }

  void normalProcess(){
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widget.child!),
          (route) => false);
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }
    if (authenticated){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widget.child!),
          (route) => false);
    
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: MediaQuery.of(context).size.aspectRatio,
          child: VideoPlayer(_controller),
          // Container(
          //  decoration: BoxDecoration(
          //    image: DecorationImage(
          //      image: AssetImage('assets/Wallpapertouchup.jpg'),
          //      fit: BoxFit.cover,
          //    ),
          //  ),
        ),
        //  Center(
        //    child: Text(
        //      "Welcome To Px.Photo.Pro",
        //      style: font,

        //TextStyle(
        //fontSize: 31,
        //color: GlobalConfig.primaryColorApp,
        //fontWeight: FontWeight.w500,
        //GoogleFonts.getFont('Lato'),
        //),
        //  ),
        //   ),
      ),
      floatingActionButton: TextButton(child: Text('Unlock'),onPressed: _authenticate,),
    );
  }
}
