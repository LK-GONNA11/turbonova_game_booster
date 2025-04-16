import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

void main() {
  runApp(const TurboNovaApp());
}

class TurboNovaApp extends StatelessWidget {
  const TurboNovaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TurboNova Game Booster',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
      ),
      home: const TurboBoosterPage(),
    );
  }
}

class TurboBoosterPage extends StatefulWidget {
  const TurboBoosterPage({super.key});

  @override
  State<TurboBoosterPage> createState() => _TurboBoosterPageState();
}

class _TurboBoosterPageState extends State<TurboBoosterPage> {
  String _deviceInfo = "Appareil inconnu";
  bool _isBoosting = false;
  String _status = "Prêt à booster";

  Future<void> _getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final androidInfo = await deviceInfoPlugin.androidInfo;
    setState(() {
      _deviceInfo = "${androidInfo.manufacturer} ${androidInfo.model}";
    });
  }

  Future<void> _performBoost() async {
    setState(() {
      _isBoosting = true;
      _status = "Optimisation en cours...";
    });

    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isBoosting = false;
      _status = "Boost terminé ! RAM libérée et distractions réduites.";
    });
  }

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TurboNova Game Booster'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Appareil détecté : $_deviceInfo", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _isBoosting ? null : _performBoost,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _isBoosting ? 160 : 200,
                height: _isBoosting ? 160 : 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: _isBoosting
                        ? [Colors.deepPurple.shade800, Colors.deepPurpleAccent]
                        : [Colors.purple, Colors.deepPurple],
                    center: Alignment.center,
                    radius: 0.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purpleAccent.withOpacity(0.6),
                      blurRadius: 25,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: _isBoosting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "BOOST",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Text(_status, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
