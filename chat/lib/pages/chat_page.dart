import 'package:chat/components/messages.dart';
import 'package:chat/components/new_message.dart';
import 'package:chat/core/models/chat_notification.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/notification/chat_notification_service.dart';
import 'package:chat/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
                items: [
                  DropdownMenuItem(
                    value: 'logout',
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.black87,
                            ),
                            SizedBox(width: 10),
                            Text('Sair')
                          ],
                        ),
                      )
                  )
                ],
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
                onChanged: (value) {
                  if(value == 'logout') {
                    AuthService().logout();
                  }
                }
            ),
          ),
          Stack(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) {
                        return NotificationPage();
                      })
                    );
                  },
                  icon: Icon(Icons.notifications)
              ),
              Positioned(
                top: 5,
                  right: 5,
                  child: CircleAvatar(
                    maxRadius: 10,
                    backgroundColor: Colors.red.shade800,
                    foregroundColor: Colors.white,
                    child: Text(
                      '${Provider.of<ChatNotificationService>(context).itemsCount}',
                      style: TextStyle(
                        fontSize: 12
,                      ),
                    ),
                  ),
              )
            ],
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
            children: [
              Expanded(child: Messages()),
              NewMessage()
            ],
          )
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //     onPressed: () {
      //     Provider.of<ChatNotificationService>(context, listen: false).add(
      //         ChatNotification(
      //             title: 'Mais uma notificação!',
      //             body: Random().nextDouble().toString()),
      //     );
      //     }
      // ),
    );
  }
}
