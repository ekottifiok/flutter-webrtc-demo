import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutter_webrtc_demo/src/serveless/models.dart';
import 'package:flutter_webrtc_demo/src/serveless/progress.dart';
import 'package:flutter_webrtc_demo/src/serveless/signaling.dart';

class Caller extends StatefulWidget {
  final String host;
  const Caller({super.key, required this.host});

  @override
  State<Caller> createState() => _CallerState();
}

class _CallerState extends State<Caller> {
  bool _inCalling = false;
  Signaling? _signaling;
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  SeverlessSteps step = SeverlessSteps.notStarted;

  @override
  initState() {
    super.initState();
    initRenderers();
    _signaling ??= Signaling(widget.host, context)..connect();
  }

  initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  @override
  deactivate() {
    super.deactivate();
    _localRenderer.dispose();
    _remoteRenderer.dispose();
  }

  void shareText() {}

  @override
  Widget build(BuildContext context) {
    bool stepDone = step == SeverlessSteps.done;
    return Scaffold(
        appBar: AppBar(
          title: Text('Severless Caller'),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) => Column(
            children: [
              Visibility(
                visible: !stepDone,
                child: ServerlessProgress(
                  step: step,
                ),
              ),
              Visibility(
                visible: _signaling?.text != null,
                child: Row(
                  children: [
                    Text(_signaling!.text?.title ?? ''),
                    IconButton.filled(
                      onPressed: shareText,
                      icon: Icon(Icons.share),
                    )
                  ],
                ),
              ),
              // Visibility(
              //     visible: !_inCalling,
              //     child: Container(
              //       child: Stack(children: <Widget>[
              //         Positioned(
              //             left: 0.0,
              //             right: 0.0,
              //             top: 0.0,
              //             bottom: 0.0,
              //             child: Container(
              //               margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              //               width: MediaQuery.of(context).size.width,
              //               height: MediaQuery.of(context).size.height,
              //               child: RTCVideoView(_remoteRenderer),
              //               decoration: BoxDecoration(color: Colors.black54),
              //             )),
              //         Positioned(
              //           left: 20.0,
              //           top: 20.0,
              //           child: Container(
              //             width: orientation == Orientation.portrait
              //                 ? 90.0
              //                 : 120.0,
              //             height: orientation == Orientation.portrait
              //                 ? 120.0
              //                 : 90.0,
              //             child: RTCVideoView(_localRenderer, mirror: true),
              //             decoration: BoxDecoration(color: Colors.black54),
              //           ),
              //         ),
              //       ]),
              //     )),
            ],
          ),
        ));
  }
}
