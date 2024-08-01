import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class Callee extends StatefulWidget {
  final String host;
  const Callee({super.key, required this.host});

  @override
  State<Callee> createState() => _CalleeState();
}

class _CalleeState extends State<Callee> {
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  @override
  initState() {
    super.initState();
    initRenderers();
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

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}