import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ====== ЗАМЕНИТЕ НА ССЫЛКУ НА ВАШ GIT-РЕПОЗИТОРИЙ ======
const String gitUrl = 'https://github.com/your-name/your-project';
// ======================================================
const String smolguUrl = 'https://smolgu.ru';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Котик',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const String _initialText = 'Привет, это лейбл';
  static const String _catText = 'Это котик';

  String _label = _initialText;

  void _toggleLabel() {
    setState(() {
      _label = _label == _initialText ? _catText : _initialText;
    });
  }

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось открыть $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Компоновка')),
      body: Stack(
        children: [
          // Верхняя строка: лейбл слева, кнопка по центру, кнопка справа
          Positioned(
            top: 16,
            left: 8,
            right: 8,
            child: Row(
              children: [
                // 1) Лейбл, прижат к левому краю
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _label,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                // 2) Кнопка Git, по центру
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () => _open(gitUrl),
                      child: const Text('Git'),
                    ),
                  ),
                ),
                // 3) Кнопка СмолГУ, прижата к правому краю
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () => _open(smolguUrl),
                      child: const Text('СмолГУ'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 4) Котик: по центру по горизонтали, снизу отступ ровно 42 px
          Positioned(
            left: 0,
            right: 0,
            bottom: 42,
            child: Center(
              child: GestureDetector(
                onTap: _toggleLabel,
                child: Image.asset(
                  'assets/cat.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
