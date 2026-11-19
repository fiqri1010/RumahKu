import 'dart:math';

import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();
final _idrFormatter = NumberFormat.currency(
  locale: 'id_ID',
  symbol: 'Rp ',
  decimalDigits: 0,
);
final _dateFormatter = DateFormat('d MMM yyyy', 'id_ID');
final _dateTimeFormatter = DateFormat('d MMM yyyy, HH:mm', 'id_ID');

/// Generates a time-ordered UUID v7 suitable for conflict-free offline creation.
String newUuidV7() => _uuid.v7();

/// Formats a numeric amount in Indonesian Rupiah (`Rp 1.250.000`).
String formatIdr(double? amount, {String emptyFallback = '—'}) {
  if (amount == null) return emptyFallback;
  return _idrFormatter.format(amount.round());
}

/// Formats a nullable [DateTime] into a readable Indonesian date (`19 Nov 2026`).
String formatDate(DateTime? date, {String emptyFallback = '—'}) {
  if (date == null) return emptyFallback;
  return _dateFormatter.format(date.toLocal());
}

/// Formats a nullable [DateTime] including hours and minutes.
String formatDateTime(DateTime? date, {String emptyFallback = '—'}) {
  if (date == null) return emptyFallback;
  return _dateTimeFormatter.format(date.toLocal());
}

/// Generates a human-friendly 8-character household invite code (e.g. `RMH-4K9P`).
String generateInviteCode() {
  const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  final rng = Random.secure();
  final part1 = List.generate(4, (_) => chars[rng.nextInt(chars.length)]).join();
  final part2 = List.generate(4, (_) => chars[rng.nextInt(chars.length)]).join();
  return '$part1-$part2';
}

/// Generates a compact human-readable QR payload URI for an item or location.
String buildRumahKuQrUri({required String entityType, required String id}) {
  return 'rumahku://$entityType/$id';
}
