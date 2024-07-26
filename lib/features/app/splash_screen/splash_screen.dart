import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextStyle? font = GoogleFonts.getFont('Dancing Script');
  late VideoPlayerController _controller;
  @override
  void initState() {
    _controller = VideoPlayerController.asset("assets/Opening2.mp4");
    _controller.initialize().then((_) {
      _controller.play();
    });
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widget.child!),
          (route) => false);
    });
    super.initState();
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
    );
  }
}
