import 'package:flutter/material.dart';
import 'package:stopwatch_lafay/models/timer_entity.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<TimerEntity> timers;
  final VoidCallback onPop;

  const HomeAppBar({super.key, required this.timers, required this.onPop});

  onSelected(BuildContext context, int value) async {
    switch (value) {
      case 1:
        await Navigator.pushNamed(context, '/settings',
            arguments: {'timers': timers}).then((value) => onPop());
        break;
      case 2:
        launchURL("https://olivier-lafay.com/categorie-produit/nos-livres/");
        break;
      default:
    }
  }

  Future<void> launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Stopwatch Lafay',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.grey[900],
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
          child: PopupMenuButton<int>(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 28,
            ),
            color: Colors.grey[900],
            onSelected: (value) => onSelected(context, value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                textStyle: TextStyle(color: Colors.white, fontSize: 16),
                value: 1,
                child: Text('Settings'),
              ),
              const PopupMenuItem(
                textStyle: TextStyle(color: Colors.white, fontSize: 16),
                value: 2,
                child: Text("Olivier Lafay's books"),
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
