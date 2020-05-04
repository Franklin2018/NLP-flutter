import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';


class SpeechToTextPage extends StatefulWidget {
  @override
  _SpeechToTextPageState createState() => _SpeechToTextPageState();
}

class _SpeechToTextPageState extends State<SpeechToTextPage> {
  
   SpeechRecognition _speechRecognition; //objeto de reconocimiento de voz
    bool _isAvailable = false;
    bool _isListening = false;

    String transcription = 'hola'; //aqui tendremos el resultado de la transcripcion
  
  @override
    void initState() { 
      super.initState();
      activateSpeechRecognizer();
    }
     void activateSpeechRecognizer() {
       _speechRecognition = SpeechRecognition();

       _speechRecognition.setAvailabilityHandler(onSpeechAvailability);
       _speechRecognition.setRecognitionStartedHandler(onRecognitionStarted);
       _speechRecognition.setRecognitionResultHandler(onRecognitionResult);
       _speechRecognition.setRecognitionCompleteHandler(onRecognitionComplete);
      
       _speechRecognition.activate().then((res) => setState(() => _isAvailable = res));

     }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech To Text'),
      ),
      body: Container(
            child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(transcription,
                      style: TextStyle(fontSize: 22),),
                    )
                  ],
                ),
                Column(
                   mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FloatingActionButton(// boton para cancelar                           
                              mini: true,
                              backgroundColor: Colors.deepOrange,
                              child: Icon(Icons.delete_forever),
                              onPressed: (){
                                  _cancelMicrofono();
                              },                            
                          ),
                          FloatingActionButton(//boton para activar el mic.
                              child: Icon(Icons.mic),
                              onPressed: (){
                                  _activarMicrofono();
                              },
                          ),
                          FloatingActionButton(//boton para detener el mic.
                              mini: true,
                              backgroundColor: Colors.deepPurpleAccent,
                              child: Icon(Icons.stop),
                              onPressed: (){
                                  _stopMicrofono();
                              },
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
    );
      
    
  }
    // metodos
  void onSpeechAvailability(bool result) => setState(() => _isAvailable = result);

  void onRecognitionStarted() => setState(() => _isListening = true);//aui el microfono esta escuchando

  void onRecognitionResult(String text) => setState(() => transcription = text);// aqui la funcion devolvera el texto

  void onRecognitionComplete() => setState(() => _isListening = false);

   void _activarMicrofono() {
    if( _isAvailable && !_isListening)
      _speechRecognition
        .listen(locale: 'es_ES').then((result)=>print('$result'));
  }

  void _stopMicrofono() {//para avisar que se completo el dictado, deja de escuchar
    if( _isListening)
      _speechRecognition.stop().then(
        (result) => setState(() => _isListening = result),
      );
  }

  void _cancelMicrofono() {
    if( _isListening)
      _speechRecognition.cancel().then(
        (result) => setState( (){
          _isListening = result;
          transcription = "transcripcion cancelada";
        } )
        );
  } 
}