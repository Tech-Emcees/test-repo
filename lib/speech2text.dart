import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Speech2text extends StatefulWidget {
  const Speech2text({super.key});

  @override
  State<Speech2text> createState() => _Speech2textState();
}

class _Speech2textState extends State<Speech2text> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
  _speechEnabled = await _speechToText.initialize(
    onError: (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Speech recognition not available: ${error.errorMsg}')),
      );
    },
  );
  setState(() {});
}


  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 40,
      child: ElevatedButton(
          onPressed: _speechToText.isNotListening ? _startListening : _stopListening,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade50),
          child: Text(
            _speechToText.isListening
                ? _lastWords
                : _speechEnabled
                    ? '🎙️ Tap the microphone to start listening...'
                    : 'Speech not available',
            style: const TextStyle(
                color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold),
          )),
    );
  }
}
