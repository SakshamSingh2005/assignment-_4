import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactive Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF003F7F),
        primaryColor: Color(0xFF00A9CC),
        textTheme: ThemeData.light().textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(Colors.white),
          trackColor: MaterialStateProperty.all(Color(0xFF00A9CC)),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(Color(0xFF00A9CC)),
          checkColor: MaterialStateProperty.all(Colors.white),
        ),
      ),
      home: DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int _counter = 0;
  final ValueNotifier<bool> _showImage = ValueNotifier(false);
  final List<bool> _taskStatus = [false, false, false];

  final List<String> _tasks = [
    "Buy groceries",
    "Finish report",
    "Call mom",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Interactive Demo"),
        backgroundColor: Color(0xFF00A9CC),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: ListView(
          children: [
            Text(
              "Counter",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text("Tap the button to increment the counter."),
            SizedBox(height: 12),
            Text("Count: $_counter", style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                onPressed: () => setState(() => _counter++),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00A9CC),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Text("Increment"),
                ),
              ),
            ),
            SizedBox(height: 28),
            Text(
              "Toggle Visibility",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text("Toggle the visibility of the widget below."),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Show Widget"),
                ValueListenableBuilder(
                  valueListenable: _showImage,
                  builder: (context, value, _) => Switch(
                    value: value,
                    onChanged: (val) => _showImage.value = val,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            ValueListenableBuilder(
              valueListenable: _showImage,
              builder: (context, value, _) {
                return value
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          "https://media.gettyimages.com/id/2204797442/photo/mls-2025-official-headshots.jpg?s=1024x1024&w=gi&k=20&c=1tTJSirEhnNKQB1BtcdeuGFEaSiCscX4jRUybqLpORU=",
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      )
                    : SizedBox.shrink();
              },
            ),
            SizedBox(height: 28),
            Text(
              "Task List",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text("Mark tasks as completed by checking the boxes."),
            SizedBox(height: 12),
            for (int i = 0; i < _tasks.length; i++)
              CheckboxListTile(
                value: _taskStatus[i],
                onChanged: (val) {
                  setState(() {
                    _taskStatus[i] = val!;
                  });
                },
                title: Text("Task ${i + 1}: ${_tasks[i]}"),
                controlAffinity: ListTileControlAffinity.trailing,
              ),
          ],
        ),
      ),
    );
  }
}
