class CardModel {
  final String id;
  final String name;
  final String netCharge;
  final String units;
  final String duration;
  final String productId;

  CardModel({
    required this.id,
    required this.name,
    required this.netCharge,
    required this.units,
    required this.duration,
    required this.productId,
  });

  static List<CardModel> getAll() => [
    CardModel(
      id: '1',
      name: 'فكة 2.5',
      netCharge: '2.50',
      units: '45 دقيقة / وحدة',
      duration: 'حتى نهاية اليوم',
      productId: 'Fakka_2.5_Unite',
    ),
    CardModel(
      id: '2',
      name: 'فكة 5',
      netCharge: '5.00',
      units: '225 دقيقة / وحدة',
      duration: 'حتى نهاية اليوم',
      productId: 'NewFakka_5_Unite',
    ),
    CardModel(
      id: '3',
      name: 'فكة 15 (الجديد)',
      netCharge: '15.00',
      units: '550 دقيقة / وحدة',
      duration: '7 أيام',
      productId: 'Fakka_15_Unite_v2', // يمنح الـ 550 وحدة كاملة
    ),
    CardModel(
      id: '4',
      name: 'فكة 19',
      netCharge: '19.00',
      units: '650 دقيقة / وحدة',
      duration: '7 أيام',
      productId: 'Fakka_19_Unite',
    ),
    CardModel(
      id: '5',
      name: 'فكة 22.5 (750 وحدة)',
      netCharge: '22.50',
      units: '750 دقيقة / وحدة',
      duration: '10 أيام',
      productId: 'Fakka_22.5_Unite', // كارت الـ 750 وحدة المعتمد بالسيرفر
    ),
    CardModel(
      id: '6',
      name: 'فكة 29',
      netCharge: '29.00',
      units: '900 دقيقة / وحدة',
      duration: '14 يوماً',
      productId: 'FakkaCard_29_Summer26',
    ),
    CardModel(
      id: '7',
      name: 'فكة 30',
      netCharge: '30.00',
      units: '1000 دقيقة / وحدة',
      duration: '14 يوماً',
      productId: 'Fakka_30_Unite',
    ),
  ];
}
