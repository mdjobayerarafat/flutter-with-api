
import 'package:flutter/material.dart';
import '../apis/panda_service.dart';
import '../models/panda_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PandaService _pandaService = PandaService();
  PandaList _pandas = PandaList(pandas: []);

  @override
  void initState() {
    super.initState();
    _fetchPandas();
  }

  Future<void> _fetchPandas() async {
    try {
      final pandas = await _pandaService.fetchPandas();
      setState(() {
        _pandas = pandas;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pandas'),
      ),
      body: _pandas.pandas.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _pandas.pandas.length,
              itemBuilder: (context, index) {
                final panda = _pandas.pandas[index];
                return ListTile(
                  title: Text(
                    panda.title,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  subtitle: Text(
                    panda.description,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  leading: Icon(
                    Icons.dark_mode,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.download,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      // TODO: Implement download functionality
                    },
                  ),
                );
              },
            ),
    );
  }
}