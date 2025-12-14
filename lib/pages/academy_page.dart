import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcademyPage extends StatelessWidget {
  const AcademyPage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Academy",
            style: GoogleFonts.rubik(fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.cyan,
            labelColor: Colors.cyan,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Help Center"),
              Tab(text: "AI Diagnose"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                ExpansionTile(
                  title: Text("1. How do I reset the pump?"),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("Turn off the main breaker for 10 seconds."),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text("2. Why is sensor reading 0?"),
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("Check wire connection."),
                    ),
                  ],
                ),
              ],
            ),
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, size: 60, color: Colors.grey),
                  SizedBox(height: 20),
                  Text("Tap to Scan Plant"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
