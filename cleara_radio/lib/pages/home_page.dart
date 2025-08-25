import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/radio_player_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final RadioPlayerService player = context.watch<RadioPlayerService>();

    final Color background = const Color(0xFFF4F4F4);
    final Color panelColor = const Color(0xFFDADADA);
    final TextStyle titleStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        );

    final TextStyle subtitleStyle = Theme.of(context).textTheme.labelLarge!.copyWith(
          color: const Color(0xFF0E1F55),
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
        );

    return Scaffold(
      backgroundColor: background,
      drawer: const _MainDrawer(),
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87, size: 28),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: Center(
                child: _CoverOval(
                  imageUrl: _kDefaultCoverImage,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text('CLEARA RADIO ONLINE', style: titleStyle),
            const SizedBox(height: 6),
            Text(player.isPlaying ? 'NOW PLAYING' : 'PAUSED', style: subtitleStyle),
            const SizedBox(height: 16),
            _BottomControlPanel(
              color: panelColor,
              isPlaying: player.isPlaying,
              isBuffering: player.isBuffering,
              onPressed: () => player.togglePlayPause(),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomControlPanel extends StatelessWidget {
  const _BottomControlPanel({
    required this.color,
    required this.isPlaying,
    required this.isBuffering,
    required this.onPressed,
  });

  final Color color;
  final bool isPlaying;
  final bool isBuffering;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.infinity,
      color: color,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: isBuffering
            ? const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(strokeWidth: 3, color: Colors.black87),
              )
            : Icon(
                isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                size: 64,
                color: Colors.black87,
              ),
      ),
    );
  }
}

class _MainDrawer extends StatelessWidget {
  const _MainDrawer();

  @override
  Widget build(BuildContext context) {
    final List<_DrawerItem> items = const [
      _DrawerItem('PLAYER', Icons.radio, '/'),
      _DrawerItem('ABOUT APP', Icons.info_outline, '/about'),
      _DrawerItem('TERMS', Icons.article_outlined, '/terms'),
      _DrawerItem('PRIVACY', Icons.lock_outline, '/privacy'),
      _DrawerItem('DISCLAIMER', Icons.report_gmailerrorred_outlined, '/disclaimer'),
      _DrawerItem('CONTACT', Icons.mail_outline, '/contact'),
    ];

    return Drawer(
      width: 280,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: CircleAvatar(radius: 12, backgroundColor: Colors.black87),
            ),
            const SizedBox(height: 24),
            for (final _DrawerItem item in items)
              ListTile(
                dense: true,
                title: Text(item.title, style: const TextStyle(fontSize: 16, letterSpacing: 0.5)),
                leading: Icon(item.icon, color: Colors.black87),
                onTap: () {
                  Navigator.pop(context);
                  if (item.route != '/') {
                    Navigator.pushNamed(context, item.route);
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem {
  const _DrawerItem(this.title, this.icon, this.route);
  final String title;
  final IconData icon;
  final String route;
}

class _CoverOval extends StatelessWidget {
  const _CoverOval({required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(160),
      child: AspectRatio(
        aspectRatio: 3/5,
        child: Container(
          width: 240,
          decoration: const BoxDecoration(color: Colors.black12),
          child: Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) {
            return const Center(child: Icon(Icons.radio, size: 84));
          }),
        ),
      ),
    );
  }
}

const String _kDefaultCoverImage = 'https://images.unsplash.com/photo-1544739313-7f861e47f0d2?q=80&w=900&auto=format&fit=crop';

