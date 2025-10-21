import '../../../export.dart';

class NavPage extends StatelessWidget {
  const NavPage({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (int index) => _onTap(context, index),
        items: [
          BottomNavigationBarItem(
            label: 'whoAmI',
            icon: Image.asset(Assets.imagesApple),
          ),
          BottomNavigationBarItem(
            label: 'countries',
            icon: Image.asset(Assets.imagesApple),
          ),
          BottomNavigationBarItem(
            label: 'services',
            icon: Image.asset(Assets.imagesApple),
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
