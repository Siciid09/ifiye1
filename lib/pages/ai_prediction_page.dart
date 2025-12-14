import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/glass_card.dart';

class AIPredictionPage extends StatelessWidget {
  const AIPredictionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "AI Forecast",
            style: GoogleFonts.rubik(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "7-Day Rain Probability",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _Bar(30),
                      _Bar(40),
                      _Bar(80, isHigh: true),
                      _Bar(60),
                      _Bar(20),
                      _Bar(10),
                      _Bar(10),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "🤖 AI Confidence: 85%",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Reasoning: Satellite cloud density + historical trends.",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final double h;
  final bool isHigh;
  const _Bar(this.h, {this.isHigh = false});
  @override
  Widget build(BuildContext context) => Container(
    width: 20,
    height: h,
    decoration: BoxDecoration(
      color: isHigh ? Colors.blue : Colors.blue.withOpacity(0.3),
      borderRadius: BorderRadius.circular(4),
    ),
  );
}
