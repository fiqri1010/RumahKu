import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';

class NavItem {
  const NavItem({
    required this.route,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String route;
  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

/// Adaptive navigation shell:
/// - `< 680px` (Android / iOS Mobile): 5-tab bottom [NavigationBar]
/// - `>= 680px` (Tablet / Windows / macOS / Linux / Web): full sidebar [NavigationRail]
class AdaptiveShell extends StatelessWidget {
  const AdaptiveShell({
    super.key,
    required this.currentLocation,
    required this.child,
  });

  final String currentLocation;
  final Widget child;

  static const List<NavItem> desktopDestinations = [
    NavItem(
      route: '/',
      label: 'Beranda',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
    ),
    NavItem(
      route: '/items',
      label: 'Inventaris',
      icon: Icons.inventory_2_outlined,
      selectedIcon: Icons.inventory_2,
    ),
    NavItem(
      route: '/locations',
      label: 'Lokasi',
      icon: Icons.account_tree_outlined,
      selectedIcon: Icons.account_tree,
    ),
    NavItem(
      route: '/moving',
      label: 'Pindahan',
      icon: Icons.local_shipping_outlined,
      selectedIcon: Icons.local_shipping,
    ),
    NavItem(
      route: '/books',
      label: 'Buku',
      icon: Icons.auto_stories_outlined,
      selectedIcon: Icons.auto_stories,
    ),
    NavItem(
      route: '/documents',
      label: 'Berkas',
      icon: Icons.folder_special_outlined,
      selectedIcon: Icons.folder_special,
    ),
    NavItem(
      route: '/garage',
      label: 'Garasi',
      icon: Icons.directions_car_outlined,
      selectedIcon: Icons.directions_car,
    ),
    NavItem(
      route: '/analytics',
      label: 'Analitik',
      icon: Icons.insights_outlined,
      selectedIcon: Icons.insights,
    ),
    NavItem(
      route: '/household',
      label: 'Sync',
      icon: Icons.sync_outlined,
      selectedIcon: Icons.sync,
    ),
  ];

  static const List<NavItem> mobileDestinations = [
    NavItem(
      route: '/',
      label: 'Beranda',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
    ),
    NavItem(
      route: '/items',
      label: 'Inventaris',
      icon: Icons.inventory_2_outlined,
      selectedIcon: Icons.inventory_2,
    ),
    NavItem(
      route: '/locations',
      label: 'Lokasi',
      icon: Icons.account_tree_outlined,
      selectedIcon: Icons.account_tree,
    ),
    NavItem(
      route: '/moving',
      label: 'Pindahan',
      icon: Icons.local_shipping_outlined,
      selectedIcon: Icons.local_shipping,
    ),
    NavItem(
      route: '/more',
      label: 'Lainnya',
      icon: Icons.grid_view_outlined,
      selectedIcon: Icons.grid_view,
    ),
  ];

  int _selectedIndexFor(List<NavItem> items, {required bool isMobile}) {
    for (var i = 0; i < items.length; i++) {
      final route = items[i].route;
      if (route == '/' && currentLocation == '/') return i;
      if (route != '/' && currentLocation.startsWith(route)) return i;
    }
    return isMobile ? items.length - 1 : 0;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isDesktop = width >= 680;
    final isExtended = width >= 1180;

    if (!isDesktop) {
      final idx = _selectedIndexFor(mobileDestinations, isMobile: true);
      return Scaffold(
        body: child,
        bottomNavigationBar: NavigationBar(
          selectedIndex: idx,
          onDestinationSelected: (i) =>
              context.go(mobileDestinations[i].route),
          destinations: [
            for (final item in mobileDestinations)
              NavigationDestination(
                icon: Icon(item.icon),
                selectedIcon: Icon(item.selectedIcon),
                label: item.label,
              ),
          ],
        ),
      );
    }

    final idx = _selectedIndexFor(desktopDestinations, isMobile: false);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Row(
        children: [
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.sizeOf(context).height,
              ),
              child: IntrinsicHeight(
                child: NavigationRail(
                  extended: isExtended,
                  labelType: isExtended
                      ? NavigationRailLabelType.none
                      : NavigationRailLabelType.all,
                  selectedIndex: idx,
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: isExtended
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.home_work, color: scheme.primary),
                              const SizedBox(width: 8),
                              Text(
                                'RumahKu',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: scheme.primary,
                                    ),
                              ),
                            ],
                          )
                        : Icon(Icons.home_work, color: scheme.primary),
                  ),
                  onDestinationSelected: (i) =>
                      context.go(desktopDestinations[i].route),
                  destinations: [
                    for (final item in desktopDestinations)
                      NavigationRailDestination(
                        icon: Icon(item.icon),
                        selectedIcon: Icon(item.selectedIcon),
                        label: Text(item.label),
                      ),
                  ],
                ),
              ),
            ),
          ),
          VerticalDivider(width: 1, color: scheme.outlineVariant),
          Expanded(child: child),
        ],
      ),
    );
  }
}
