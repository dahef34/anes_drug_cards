import 'package:flutter/gestures.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';



class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://cdn.dvidshub.net/media/video/1908/DOD_107107919/DOD_107107919-512x288-442k.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
            children: <Widget>[
              Center(heightFactor: 2,
              child: Image.asset('assets/usu_logo.png', height: MediaQuery.of(context).size.height * 0.15,
              fit: BoxFit.contain)
              ),
              RichText(
                text: TextSpan(
                  style: new TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Roboto', fontWeight: FontWeight.bold,
                  ),
                  text: 'Find a recruiter!',
                ),
              ),
              ButtonBar(
                mainAxisSize: MainAxisSize.min,
                buttonTextTheme: ButtonTextTheme.normal,// this will take space as minimum as posible(to center)
                children: <Widget>[
                  new RaisedButton(
                    child: new Text('Navy'),
                    onPressed: () async {
                      final url = 'https://www.navy.com/careers/medical';
                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceSafariVC: false,
                        );
                      }
                    },
                  ),
                  new RaisedButton(
                    child: new Text('Air Force'),
                    onPressed: () async {
                      final url = 'https://www.airforce.com/careers/detail/certified-registered-nurse-anesthetist';
                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceSafariVC: false,
                        );
                      }
                    },
                  ),
                  new RaisedButton(
                    child: new Text('Army'),
                    onPressed: () async {
                      final url = 'https://www.goarmy.com/careers-and-jobs/career-match/science-medicine/intensive-care/66f-nurse-anesthetist.html';
                      if (await canLaunch(url)) {
                        await launch(
                          url,
                          forceSafariVC: false,
                        );
                      }
                    },
                  ),
                ],
              ),
              Spacer(),
              Text(
                'We are CRNAs',
                style: TextStyle(
                    color: Colors.black, fontSize: 26, fontWeight: FontWeight.w600),
              ),
        Container(
            height: MediaQuery.of(context).size.width * 0.5625,
            width: MediaQuery.of(context).size.width,
            child:_controller.value.initialized
                ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
                )
                : Container(),
              ),
              Spacer(),
    ],
    ),
    floatingActionButton: FloatingActionButton(
    onPressed: () {
    setState(() {
    _controller.value.isPlaying
    ? _controller.pause()
        : _controller.play();
    });
    },
    child: Icon(
    _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
    ),
    ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}