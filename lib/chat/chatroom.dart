import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../ultils/state_m.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({super.key});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}
late IO.Socket _socket;
  final TextEditingController _messageInputController = TextEditingController();
  // _sendMessage() {
  //   _socket.emit('message', {
  //     'message': _messageInputController.text.trim(),
  //     'sender': widget.username
  //   });
  //   _messageInputController.clear();
  // }

  // _connectSocket() {
  //   _socket.onConnect((data) => print('Connection established'));
  //   _socket.onConnectError((data) => print('Connect Error: $data'));
  //   _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
  //   _socket.on(
  //     'message',
  //     (data) => Provider.of<HomeProvider>(context, listen: false).addNewMessage(
  //       Message.fromJson(data),
  //     ),
  //   );
  // }

final dataControllers = Get.put(dataController());
class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(), child: chatWidget()
     
        );
  }
chatBox(){
  return Container();
}
  chatWidget() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CHat to id: ${dataControllers.s_id}',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Stack(
        children: <Widget>[
          //   ListView.builder(
          //     itemCount: chatMessage.length,
          //     shrinkWrap: true,
          //     padding: EdgeInsets.only(top: 10,bottom: 10),
          //     physics: NeverScrollableScrollPhysics(),
          //     itemBuilder: (context, index){
          //     return ChatBubble(
          //       chatMessage: chatMessage[index],
          //     );
          //     },
          //  ),
          SizedBox.expand(
              child: Container(
                child: chatBox(),
            color: Colors.grey[200],
          )),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 16, bottom: 10),
              height: 60,
              width: double.infinity,
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: 
                      ElevatedButton(
                          onPressed: () {},
                          child: Center(child: Icon(Icons.add)),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.only(left: 1),
                          ),
                        ),
                      
                      
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      // height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                top: 5, bottom: 5, left: 10, right: 5),
                            hintText: "Type message...",
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                 Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Center(child: Icon(Icons.send)),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.only(left: 4),
                          ),
                        ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
