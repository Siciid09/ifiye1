import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../widgets/glass_card.dart';

class MonitorPage extends StatefulWidget {
  const MonitorPage({super.key});
  @override
  State<MonitorPage> createState() => _MonitorPageState();
}

class _MonitorPageState extends State<MonitorPage> {
  int _tab = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "System Monitor",
            style: GoogleFonts.rubik(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _TabBtn("Sources", 0, _tab, (i) => setState(() => _tab = i)),
              _TabBtn("Atmosphere", 1, _tab, (i) => setState(() => _tab = i)),
              _TabBtn("Soil", 2, _tab, (i) => setState(() => _tab = i)),
            ],
          ),
          const SizedBox(height: 20),
          if (_tab == 0) ...[
            _DataRow("Barkad Level", "75%", 0.75, Colors.brown),
            _DataRow("Roof Tank", "30%", 0.30, Colors.blue),
            const SizedBox(height: 15),
            Row(
              children: const [
                Expanded(child: _MiniMetric("pH Level", "7.2", Icons.science)),
                SizedBox(width: 10),
                Expanded(child: _MiniMetric("Turbidity", "Low", Icons.blur_on)),
              ],
            ),
          ],
          if (_tab == 1) ...[
            GlassCard(
              child: Row(
                children: const [
                  Icon(Icons.air, size: 40),
                  SizedBox(width: 10),
                  Text("Wind: 14km/h NW\nHumidity: 88%"),
                ],
              ),
            ),
          ],
          if (_tab == 2) ...[
            _DataRow("Tomato Zone", "CRITICAL 18%", 0.18, Colors.red),
            const SizedBox(height: 15),
            Row(
              children: const [
                Expanded(child: _MiniMetric("Nitrogen", "Good", Icons.grass)),
                SizedBox(width: 10),
                Expanded(
                  child: _MiniMetric("Phosphorus", "Low", Icons.landscape),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _TabBtn extends StatelessWidget {
  final String label;
  final int index;
  final int current;
  final Function(int) onTap;
  const _TabBtn(this.label, this.index, this.current, this.onTap);
  @override
  Widget build(BuildContext context) => Expanded(
    child: GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: current == index
              ? Theme.of(context).primaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: current == index ? Colors.black : Colors.grey,
          ),
        ),
      ),
    ),
  );
}

class _DataRow extends StatelessWidget {
  final String t;
  final String v;
  final double p;
  final Color c;
  const _DataRow(this.t, this.v, this.p, this.c);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: GlassCard(
      child: Row(
        children: [
          CircularPercentIndicator(radius: 20, percent: p, progressColor: c),
          const SizedBox(width: 10),
          Expanded(
            child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text(
            v,
            style: TextStyle(color: c, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}

class _MiniMetric extends StatelessWidget {
  final String title;
  final String val;
  final IconData icon;
  const _MiniMetric(this.title, this.val, this.icon);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor.withOpacity(0.5),
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Colors.grey.withOpacity(0.1)),
    ),
    child: Column(
      children: [
        Icon(icon, size: 20),
        const SizedBox(height: 5),
        Text(val, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    ),
  );
}
