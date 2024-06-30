
import 'package:web_socket_channel/web_socket_channel.dart';
class WebSocket{

WebSocketChannel? _channel;
final url = 'wss://echo.websocket.org/.sse';
late bool isConnected ;

WebSocket(){
  isConnected = false;
  connect();
}


void connect (){
_channel = WebSocketChannel.connect(Uri.parse(url));

_channel!.stream.listen((msg){
  isConnected = true;
   print(msg);
}
,onError: (e){

  print(e);
},onDone:(){
  isConnected = false;
   print('WebSocket Connection Closed');
}
);
}

sendMsg(msg){
  if(isConnected ==true){
    _channel!.sink.add(msg);
  }
}

void disconnect(){
  _channel!.sink.close();
  isConnected = false;
}

}