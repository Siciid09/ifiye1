import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/glass_card.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Services",
            style: GoogleFonts.rubik(fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.cyan,
            labelColor: Colors.cyan,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "🚛 Water Market"),
              Tab(text: "📄 Reports"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade800, Colors.blue.shade400],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Avg. Price",
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            "\$12.50",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.local_shipping,
                        size: 50,
                        color: Colors.white24,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const _Truck("Al-Misbaah", "15 mins", "\$12", Colors.green),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(20),
              children: const [
                _Report("Monthly Usage Report", "Nov 2025"),
                _Report("Drought Impact Assessment", "Critical"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Truck extends StatelessWidget {
  final String n, t, p;
  final Color c;
  const _Truck(this.n, this.t, this.p, this.c);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: GlassCard(
      child: Row(
        children: [
          const Icon(Icons.local_shipping, color: Colors.blue),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(n, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  t,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            p,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: c,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}

class _Report extends StatelessWidget {
  final String t, s;
  const _Report(this.t, this.s);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: GlassCard(
      child: Row(
        children: [
          const Icon(Icons.picture_as_pdf, color: Colors.red),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  s,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.download, color: Colors.grey),
        ],
      ),
    ),
  );
}
