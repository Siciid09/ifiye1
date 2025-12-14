import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../widgets/glass_card.dart';
import '../main.dart'; // To access Theme Toggle
import 'support_chat_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  void _showBroadcastPanel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: 600,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.cell_tower, color: Colors.red, size: 30),
                SizedBox(width: 10),
                Text(
                  "Community Early Warning",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Select a channel to warn the community.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            GlassCard(
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Sending SMS Alerts...")),
                );
              },
              child: const Row(
                children: [
                  Icon(Icons.sms, color: Colors.green),
                  SizedBox(width: 15),
                  Text("SMS Blast (GSM)"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "CLOSE",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "BiyoKaab",
                    style: GoogleFonts.orbitron(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primary,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 12,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Hargeisa, District 26",
                        style: GoogleFonts.rubik(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SupportChatPage(),
                      ),
                    ),
                    icon: const Icon(Icons.support_agent),
                  ),
                  IconButton(
                    onPressed: () => BiyoKaabApp.of(context)?.toggleTheme(),
                    icon: const Icon(Icons.brightness_6),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatusItem(Icons.sunny, "Solar: 14.2V", Colors.orange),
                _StatusItem(Icons.battery_5_bar, "Bat: 85%", Colors.green),
                _StatusItem(
                  Icons.signal_cellular_alt,
                  "LoRa: Strong",
                  Colors.blue,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GlassCard(
            colorOverride: Colors.orange.shade900.withOpacity(0.8),
            onTap: () => _showBroadcastPanel(context),
            child: Row(
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "HIGH DROUGHT RISK",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "Water out in 14 days.",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "ACT NOW",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 12.0,
              percent: 0.65,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "14 DAYS",
                    style: GoogleFonts.orbitron(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text("Survival", style: TextStyle(color: Colors.grey)),
                ],
              ),
              progressColor: Colors.blueAccent,
              circularStrokeCap: CircularStrokeCap.round,
            ),
          ),
          const SizedBox(height: 30),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.9,
            children: const [
              _GridCard(
                Icons.water_drop,
                "Rationing",
                "Active: 50L",
                Colors.orange,
              ),
              _GridCard(
                Icons.cloud_download,
                "Fog Net",
                "+12L Today",
                Colors.blue,
              ),
              _GridCard(Icons.opacity, "Soil", "Critical 18%", Colors.red),
              _GridCard(
                Icons.currency_exchange,
                "Market",
                "Prices Up",
                Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatusItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _StatusItem(this.icon, this.label, this.color);
  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, size: 14, color: color),
      const SizedBox(width: 4),
      Text(
        label,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

class _GridCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String sub;
  final Color color;
  const _GridCard(this.icon, this.title, this.sub, this.color);
  @override
  Widget build(BuildContext context) => GlassCard(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color, size: 30),
        const SizedBox(height: 15),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          sub,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
