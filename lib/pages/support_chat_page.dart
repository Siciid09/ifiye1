import 'package:flutter/material.dart';

class SupportChatPage extends StatelessWidget {
  const SupportChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support Agent"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {},
              icon: const Icon(Icons.call, size: 18),
              label: const Text("Call"),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("Hello! I am the BiyoKaab AI Agent."),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Card(
                    color: Colors.blue,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "My pump isn't starting.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Type message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const CircleAvatar(child: Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
