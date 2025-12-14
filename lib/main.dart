import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

void main() {
  runApp(const BiyoKaabApp());
}

// ==========================================
// 1. APP CONFIG & THEME MANAGEMENT
// ==========================================
class BiyoKaabApp extends StatefulWidget {
  const BiyoKaabApp({super.key});

  @override
  State<BiyoKaabApp> createState() => _BiyoKaabAppState();
}

class _BiyoKaabAppState extends State<BiyoKaabApp> {
  bool _isDarkMode = true; // Default to Dark Mode for Modern Look

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BiyoKaab',
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,

      // --- LIGHT THEME ---
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF5F0EB), // Sand White
        primaryColor: const Color(0xFF00695C), // Deep Teal
        cardColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xFF00695C)),
        textTheme: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)
            .apply(
              bodyColor: const Color(0xFF2D3436),
              displayColor: const Color(0xFF2D3436),
            ),
      ),

      // --- DARK THEME ---
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B1015), // Deep Void
        primaryColor: const Color(0xFF00E5FF), // Neon Cyan
        cardColor: const Color(0xFF151F28),
        iconTheme: const IconThemeData(color: Color(0xFF00E5FF)),
        textTheme: GoogleFonts.rubikTextTheme(
          Theme.of(context).textTheme,
        ).apply(bodyColor: const Color(0xFFE0E0E0), displayColor: Colors.white),
      ),

      home: MainContainer(toggleTheme: toggleTheme, isDark: _isDarkMode),
    );
  }
}

// ==========================================
// 2. REUSABLE GLASS CARD UI
// ==========================================
class GlassCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final VoidCallback? onTap;
  final Color? colorOverride;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.onTap,
    this.colorOverride,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color:
              colorOverride ??
              Theme.of(context).cardColor.withOpacity(isDark ? 0.6 : 0.9),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

// ==========================================
// 3. MAIN CONTAINER (Navigation Hub)
// ==========================================
class MainContainer extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDark;

  const MainContainer({
    super.key,
    required this.toggleTheme,
    required this.isDark,
  });

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // THE 5 MAIN PAGES (ALL FEATURES INCLUDED)
    final List<Widget> pages = [
      DashboardPage(toggleTheme: widget.toggleTheme, isDark: widget.isDark),
      const MonitorPage(),
      const AIPredictionPage(),
      const ServicesPage(), // Marketplace & Reports
      const AcademyPage(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],

      // CUSTOM BOTTOM NAVIGATION BAR
      bottomNavigationBar: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            color: Theme.of(context).cardColor,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _navItem(0, Icons.grid_view, "Dash"),
                _navItem(1, Icons.show_chart, "Monitor"),
                _navItem(2, Icons.psychology, "AI Data"),
                _navItem(3, Icons.shopping_bag, "Market"),
                _navItem(4, Icons.school, "Help"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    bool isSelected = _selectedIndex == index;
    Color activeColor = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: activeColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(15),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? activeColor : Colors.grey, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isSelected ? activeColor : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 4. DASHBOARD PAGE (The Winning Screen)
// ==========================================
class DashboardPage extends StatelessWidget {
  final VoidCallback toggleTheme;
  final bool isDark;

  const DashboardPage({
    super.key,
    required this.toggleTheme,
    required this.isDark,
  });

  // 📢 BROADCAST HUB (Inclusivity Feature)
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
            Row(
              children: const [
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
              "Select a channel to warn the community about the Water Shortage.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // SMS OPTION
            GlassCard(
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Sending 142 SMS Alerts...")),
                );
              },
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.green.withOpacity(0.2),
                    child: const Icon(Icons.sms, color: Colors.green),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "SMS Blast (GSM)",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Send to 142 Registered Villagers",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // RADIO OPTION
            GlassCard(
              onTap: () {},
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.orange.withOpacity(0.2),
                    child: const Icon(Icons.radio, color: Colors.orange),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Radio Script Gen",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Generate Somali Text for Imam/Radio",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              "Preview Script:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "SCRIPT: \"Wargelin! Dhammaan dadweynaha tuulada, nidaamka BiyoKaab wuxuu saadaalinayaa biyo yaraan 10-ka maalmood ee soo socda. Fadlan yareeya isticmaalka biyaha maanta.\"",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "CLOSE COMMAND CENTER",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
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
          // HEADER: LOCATION & ACTIONS
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
                  // 🗺️ LOCATION CONTEXT
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
                        builder: (context) => const SupportChatPage(),
                      ),
                    ),
                    icon: const Icon(Icons.support_agent),
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).cardColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: toggleTheme,
                    icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).cardColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 15),

          // ⚡ HARDWARE STATUS STRIP (Solar/Battery)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statusItem(Icons.sunny, "Solar: 14.2V", Colors.orange),
                _statusItem(Icons.battery_5_bar, "Bat: 85%", Colors.green),
                _statusItem(
                  Icons.signal_cellular_alt,
                  "LoRa: Strong",
                  Colors.blue,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🚨 THE "ACTION ALERT" CARD (CRITICAL UPDATE)
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
                        "Water will run out in 14 days.",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
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

          // MAIN GAUGE
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 12.0,
                  percent: 0.65,
                  backgroundColor: Colors.grey.withOpacity(0.1),
                  progressColor: Colors.blueAccent,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                CircularPercentIndicator(
                  radius: 80.0,
                  lineWidth: 12.0,
                  percent: 0.30,
                  backgroundColor: Colors.transparent,
                  progressColor: Colors.orangeAccent,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                Column(
                  children: [
                    Text(
                      "14 DAYS",
                      style: GoogleFonts.orbitron(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Survival Capacity",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),
          Text(
            "Live Intelligence",
            style: GoogleFonts.rubik(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),

          // 2x2 GRID
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 0.9,
            children: [
              _buildGridCard(
                context,
                Icons.water_drop,
                "Rationing",
                "Active: 50L",
                Colors.orange,
              ),
              _buildGridCard(
                context,
                Icons.cloud_download,
                "Fog Net",
                "+12L Today",
                Colors.blue,
              ),
              _buildGridCard(
                context,
                Icons.opacity,
                "Soil",
                "Critical 18%",
                Colors.red,
              ),
              _buildGridCard(
                context,
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

  Widget _statusItem(IconData icon, String label, Color color) {
    return Row(
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

  Widget _buildGridCard(
    BuildContext context,
    IconData icon,
    String title,
    String sub,
    Color color,
  ) {
    return GlassCard(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            sub,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 5. MONITOR PAGE (Deep Data - 3 Tabs)
// ==========================================
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
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                _buildTab("Sources", 0),
                _buildTab("Atmosphere", 1),
                _buildTab("Soil", 2),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (_tab == 0) _buildSourcesView(context),
          if (_tab == 1) _buildAtmosphereView(context),
          if (_tab == 2) _buildSoilView(context),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index) {
    bool active = _tab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _tab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? Theme.of(context).primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: active ? Colors.black : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  // Monitor Views
  Widget _buildSourcesView(BuildContext context) {
    return Column(
      children: [
        _dataRow("Barkad Level", "75%", 0.75, Colors.brown),
        _dataRow("Roof Tank", "30%", 0.30, Colors.blue),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: _miniMetric(context, "pH Level", "7.2", Icons.science),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _miniMetric(context, "Turbidity", "Low", Icons.blur_on),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _miniMetric(context, "Flow Rate", "45 L/m", Icons.speed),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _miniMetric(
                context,
                "Pressure",
                "2.1 Bar",
                Icons.compress,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAtmosphereView(BuildContext context) {
    return Column(
      children: [
        GlassCard(
          child: Row(
            children: const [
              Icon(Icons.air, size: 40),
              SizedBox(width: 10),
              Text("Wind: 14km/h NW\nHumidity: 88%"),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: _miniMetric(
                context,
                "Dew Point",
                "18°C",
                Icons.water_drop,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _miniMetric(
                context,
                "UV Index",
                "High (8)",
                Icons.wb_sunny,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSoilView(BuildContext context) {
    return Column(
      children: [
        _dataRow("Tomato Zone", "CRITICAL 18%", 0.18, Colors.red),
        const SizedBox(height: 15),
        const Text(
          "Nutrient Levels (N-P-K)",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _miniMetric(
                context,
                "Nitrogen",
                "Good",
                Icons.grass,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: _miniMetric(
                context,
                "Phosphorus",
                "Low",
                Icons.landscape,
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: _miniMetric(
                context,
                "Potassium",
                "Good",
                Icons.eco,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _dataRow(String t, String val, double p, Color c) => Padding(
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
            val,
            style: TextStyle(color: c, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );

  Widget _miniMetric(
    BuildContext context,
    String title,
    String val,
    IconData icon, {
    Color? color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: color ?? Theme.of(context).primaryColor),
          const SizedBox(height: 5),
          Text(
            val,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 6. AI DATA PAGE (Confidence + Explanation)
// ==========================================
class AIPredictionPage extends StatelessWidget {
  const AIPredictionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.psychology,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
              const SizedBox(width: 10),
              Text(
                "AI Forecast & Analysis",
                style: GoogleFonts.rubik(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
                Container(
                  height: 150,
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _bar(30),
                      _bar(40),
                      _bar(80, isHigh: true),
                      _bar(60),
                      _bar(20),
                      _bar(10),
                      _bar(10),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // 🧠 AI EXPLANATION & CONFIDENCE
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "🤖 AI Confidence: 85%",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Reasoning: Prediction based on regional satellite cloud density + historical 10-year patterns for Hargeisa.",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _aiStatTile(context, "Water Saved", "1,200 Liters", Colors.blue),
          _aiStatTile(context, "Pump Efficiency", "94% Optimal", Colors.green),
        ],
      ),
    );
  }

  Widget _bar(double h, {bool isHigh = false}) {
    return Container(
      width: 20,
      height: h,
      decoration: BoxDecoration(
        color: isHigh ? Colors.blue : Colors.blue.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _aiStatTile(
    BuildContext context,
    String title,
    String val,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(
              val,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 7. SERVICES PAGE (Market + Reports)
// ==========================================
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
            "External Services",
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
            // Market Tab
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Avg. Hargeisa Price",
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
                          Text(
                            "Per 200L Barrel",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.local_shipping,
                        size: 50,
                        color: Colors.white24,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Available Trucks",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _truck(context, "Al-Misbaah", "15 mins", "\$12", Colors.green),
                _truck(
                  context,
                  "Hargeisa Express",
                  "45 mins",
                  "\$10",
                  Colors.orange,
                ),
              ],
            ),
            // Reports Tab
            ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _report(context, "Monthly Usage Report", "Nov 2025"),
                _report(context, "Drought Impact Assessment", "Critical"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _truck(
    BuildContext context,
    String name,
    String time,
    String price,
    Color c,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GlassCard(
        child: Row(
          children: [
            const Icon(Icons.local_shipping, color: Colors.blue),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    time,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            Text(
              price,
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

  Widget _report(BuildContext context, String title, String sub) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GlassCard(
        child: Row(
          children: [
            const Icon(Icons.picture_as_pdf, color: Colors.red),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    sub,
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
}

// ==========================================
// 8. ACADEMY PAGE
// ==========================================
class AcademyPage extends StatelessWidget {
  const AcademyPage({super.key});

  final List<Map<String, String>> faqList = const [
    {
      "q": "How do I reset the pump?",
      "a": "Turn off the main breaker for 10 seconds, then restart.",
    },
    {
      "q": "Why is the sensor reading 0?",
      "a": "Check if the wire is disconnected or the soil is extremely dry.",
    },
    {
      "q": "How to clean the Fog Net?",
      "a": "Gently shake the mesh to remove dust. Do not use soap.",
    },
    {
      "q": "What is 'Survival Mode'?",
      "a": "AI limits water usage to 50L/day to ensure 14-day survival.",
    },
    {
      "q": "Can I override the AI?",
      "a": "Yes, go to Dashboard > Settings > Manual Override.",
    },
    {
      "q": "Does it work without Wi-Fi?",
      "a": "Yes, the system switches to SMS/GSM mode automatically.",
    },
    {
      "q": "How accurate is the rain forecast?",
      "a": "The AI uses satellite data with 85% accuracy for Hargeisa.",
    },
    {
      "q": "My Barkad is leaking, what now?",
      "a": "Use the 'Diagnose' tab to upload a photo for repair tips.",
    },
    {
      "q": "How much power does it use?",
      "a": "The system runs on a small 12V Solar panel.",
    },
    {
      "q": "Can I share water with neighbors?",
      "a": "Yes, use the Community Tab to transfer water credits.",
    },
    {
      "q": "Where is the data stored?",
      "a": "Data is stored locally on the ESP32 and synced to the cloud.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Resilience Academy",
            style: GoogleFonts.rubik(fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.cyan,
            labelColor: Colors.cyan,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Help Center (11)"),
              Tab(text: "AI Diagnose"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: faqList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  color: Theme.of(context).cardColor,
                  child: ExpansionTile(
                    title: Text(
                      "${index + 1}. ${faqList[index]['q']}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          faqList[index]['a']!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            // Diagnose Tab
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    "AI Crop Doctor",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Icon(Icons.add_a_photo, size: 60, color: Colors.grey),
                  const SizedBox(height: 20),
                  const Text(
                    "Tap to Scan Plant",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 9. SUPPORT CHAT PAGE
// ==========================================
class SupportChatPage extends StatelessWidget {
  const SupportChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Support Agent"),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15, top: 8, bottom: 8),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {},
              icon: const Icon(Icons.call, size: 18),
              label: const Text("Call Agent"),
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
                ChatBubble(
                  isMe: false,
                  text:
                      "Hello! I am the BiyoKaab AI Agent. How can I help you today?",
                ),
                ChatBubble(isMe: true, text: "My pump isn't starting."),
                ChatBubble(
                  isMe: false,
                  text:
                      "I checked your system logs. The 'Survival Mode' is active, which disables the pump until 6:00 PM.",
                ),
                ChatBubble(isMe: true, text: "Yes, I need water now."),
                ChatBubble(
                  isMe: false,
                  text:
                      "Understood. I have enabled a 10-minute emergency flow override.",
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).cardColor,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text("Type a message..."),
                  ),
                ),
                const SizedBox(width: 10),
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String text;
  const ChatBubble({super.key, required this.isMe, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        constraints: const BoxConstraints(maxWidth: 250),
        decoration: BoxDecoration(
          color: isMe ? Colors.blueAccent : Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: isMe ? const Radius.circular(15) : Radius.zero,
            bottomRight: isMe ? Radius.zero : const Radius.circular(15),
          ),
        ),
        child: Text(text),
      ),
    );
  }
}
