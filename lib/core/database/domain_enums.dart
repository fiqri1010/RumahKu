import 'package:material_ui/material_ui.dart';

enum LocationKind {
  property('property', 'Properti / Rumah', Icons.home_outlined),
  room('room', 'Ruangan', Icons.meeting_room_outlined),
  furniture('furniture', 'Lemari / Rak / Meja', Icons.shelves),
  bookshelf('bookshelf', 'Rak Buku', Icons.menu_book_outlined),
  safeFolder('safe_folder', 'Brankas / Map Berkas', Icons.folder_special_outlined),
  container('container', 'Wadah / Kotak', Icons.inventory_2_outlined),
  movingBox('moving_box', 'Kardus Pindahan', Icons.local_shipping_outlined),
  vehicleCompartment(
    'vehicle_compartment',
    'Bagasi / Kompartemen Kendaraan',
    Icons.directions_car_outlined,
  );

  const LocationKind(this.dbValue, this.label, this.icon);
  final String dbValue;
  final String label;
  final IconData icon;

  static LocationKind fromDb(String value) => LocationKind.values.firstWhere(
        (e) => e.dbValue == value,
        orElse: () => LocationKind.room,
      );
}

enum AssetType {
  general('general', 'Barang Umum', Icons.category_outlined),
  electronics('electronics', 'Elektronik & Gadget', Icons.devices_outlined),
  furniture('furniture', 'Furnitur', Icons.chair_outlined),
  appliance('appliance', 'Peralatan Rumah', Icons.kitchen_outlined),
  tool('tool', 'Perkakas & Alat', Icons.handyman_outlined),
  hobby('hobby', 'Hobi & Olahraga', Icons.sports_esports_outlined),
  vehicle('vehicle', 'Kendaraan', Icons.directions_car_filled_outlined),
  book('book', 'Buku', Icons.auto_stories_outlined),
  document('document', 'Berkas / Dokumen', Icons.description_outlined);

  const AssetType(this.dbValue, this.label, this.icon);
  final String dbValue;
  final String label;
  final IconData icon;

  static AssetType fromDb(String value) => AssetType.values.firstWhere(
        (e) => e.dbValue == value,
        orElse: () => AssetType.general,
      );
}

enum ItemCondition {
  excellent('excellent', 'Sangat Baik', Color(0xFF15803D)),
  good('good', 'Baik', Color(0xFF0F766E)),
  fair('fair', 'Cukup / Lecet', Color(0xFFD97706)),
  broken('broken', 'Rusak', Color(0xFFDC2626));

  const ItemCondition(this.dbValue, this.label, this.color);
  final String dbValue;
  final String label;
  final Color color;

  static ItemCondition fromDb(String value) => ItemCondition.values.firstWhere(
        (e) => e.dbValue == value,
        orElse: () => ItemCondition.good,
      );
}

enum UsageMode {
  dailyStatus('daily_status', 'Status Pemanfaatan (Harian)'),
  countTracked('count_tracked', 'Hitung Pemakaian (Cost-per-Use)'),
  vehicleOdometer('vehicle_odometer', 'Odometer Kendaraan (Rp/km)'),
  bookReading('book_reading', 'Progres Baca Buku'),
  archiveDoc('archive_doc', 'Arsip Berkas');

  const UsageMode(this.dbValue, this.label);
  final String dbValue;
  final String label;

  static UsageMode fromDb(String value) => UsageMode.values.firstWhere(
        (e) => e.dbValue == value,
        orElse: () => UsageMode.dailyStatus,
      );
}

enum UtilityStatus {
  essential('essential', 'Wajib Harian', Color(0xFF0F766E)),
  frequent('frequent', 'Sering Dipakai', Color(0xFF2563EB)),
  occasional('occasional', 'Sesekali', Color(0xFFD97706)),
  idle('idle', 'Nganggur (Kandidat Declutter)', Color(0xFFEA580C)),
  forSale('for_sale', 'Rencana Jual / Hibah', Color(0xFF7C3AED)),
  disposed('disposed', 'Sudah Dijual / Dibuang', Color(0xFF64748B));

  const UtilityStatus(this.dbValue, this.label, this.color);
  final String dbValue;
  final String label;
  final Color color;

  static UtilityStatus fromDb(String value) => UtilityStatus.values.firstWhere(
        (e) => e.dbValue == value,
        orElse: () => UtilityStatus.frequent,
      );
}

enum AttachmentKind {
  photo('photo', 'Foto Barang'),
  cover('cover', 'Sampul Buku'),
  receipt('receipt', 'Struk / Kwitansi'),
  warranty('warranty', 'Kartu Garansi'),
  manual('manual', 'Buku Manual'),
  docScanPdf('doc_scan_pdf', 'Scan Berkas PDF'),
  stnk('stnk', 'STNK'),
  bpkb('bpkb', 'BPKB'),
  insurance('insurance', 'Polis Asuransi');

  const AttachmentKind(this.dbValue, this.label);
  final String dbValue;
  final String label;

  bool get isDefaultSensitive =>
      this == AttachmentKind.stnk ||
      this == AttachmentKind.bpkb ||
      this == AttachmentKind.insurance ||
      this == AttachmentKind.docScanPdf;

  static AttachmentKind fromDb(String value) => AttachmentKind.values.firstWhere(
        (e) => e.dbValue == value,
        orElse: () => AttachmentKind.photo,
      );
}
