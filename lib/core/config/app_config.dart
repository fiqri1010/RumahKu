/// Runtime configuration loaded via `--dart-define` or `--dart-define-from-file=.env`.
///
/// When `SUPABASE_URL` or `SUPABASE_ANON_KEY` are empty, RumahKu automatically
/// runs in pure offline local mode (`NoopSyncAdapter`) without requiring any
/// cloud account or login.
class AppConfig {
  const AppConfig({
    required this.supabaseUrl,
    required this.supabaseAnonKey,
  });

  factory AppConfig.fromEnvironment() {
    const url = String.fromEnvironment('SUPABASE_URL', defaultValue: '');
    const anonKey = String.fromEnvironment(
      'SUPABASE_ANON_KEY',
      defaultValue: '',
    );
    return const AppConfig(
      supabaseUrl: url,
      supabaseAnonKey: anonKey,
    );
  }

  final String supabaseUrl;
  final String supabaseAnonKey;

  bool get isCloudConfigured =>
      supabaseUrl.trim().isNotEmpty && supabaseAnonKey.trim().isNotEmpty;
}
