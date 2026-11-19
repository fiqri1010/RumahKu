import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rumahku/app/router.dart';
import 'package:rumahku/app/theme.dart';
import 'package:rumahku/core/config/app_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID');

  final config = AppConfig.fromEnvironment();
  if (config.isCloudConfigured) {
    await Supabase.initialize(
      url: config.supabaseUrl,
      publishableKey: config.supabaseAnonKey,
    );
  }

  runApp(const ProviderScope(child: RumahKuApp()));
}

class RumahKuApp extends ConsumerWidget {
  const RumahKuApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'RumahKu',
      debugShowCheckedModeBanner: false,
      theme: RumahKuTheme.light(),
      darkTheme: RumahKuTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
