import 'package:flutter/material.dart';
import 'package:outsource_mate/utils/routes_names.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Inbox',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.chatScreen,
                  );
                },
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: const Text(
                  'Muhammad Qasim',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text('Hello!'),
                trailing: const Text('8:46 PM'),
              ),
            );
          }),
    ));
  }
}
