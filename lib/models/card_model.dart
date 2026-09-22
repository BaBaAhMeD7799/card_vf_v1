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
      name: 'فكة 3',
      netCharge: '3.00',
      units: '45 وحدة',
      duration: 'حتى منتصف الليل',
      productId: 'Fakka_3_Unite',
    ),
    CardModel(
      id: '2',
      name: 'فكة 6',
      netCharge: '6.00',
      units: '225 وحدة',
      duration: 'حتى منتصف الليل',
      productId: 'Fakka_6_Unite',
    ),
    CardModel(
      id: '3',
      name: 'فكة 8.5',
      netCharge: '8.50',
      units: '300 وحدة',
      duration: '3 أيام',
      productId: 'Fakka_8.5_Unite',
    ),
    CardModel(
      id: '4',
      name: 'فكة 10.5',
      netCharge: '10.50',
      units: '400 وحدة',
      duration: '4 أيام',
      productId: 'Fakka_10.5_Unite',
    ),
    CardModel(
      id: '5',
      name: 'فكة 11.5',
      netCharge: '11.50',
      units: '450 وحدة',
      duration: '7 أيام',
      productId: 'Fakka_11.5_Unite',
    ),
    CardModel(
      id: '6',
      name: 'فكة 15.5',
      netCharge: '15.50',
      units: '550 وحدة',
      duration: '7 أيام',
      productId: 'Fakka_15.5_Unite',
    ),
    CardModel(
      id: '7',
      name: 'فكة 17.5',
      netCharge: '17.50',
      units: '650 وحدة',
      duration: '10 أيام',
      productId: 'Fakka_17.5_Unite',
    ),
    CardModel(
      id: '8',
      name: 'فكة 21.5',
      netCharge: '21.50',
      units: '750 وحدة',
      duration: '10 أيام',
      productId: 'Fakka_21.5_Unite',
    ),
    CardModel(
      id: '9',
      name: 'فكة 29',
      netCharge: '29.00',
      units: '1100 وحدة',
      duration: '14 يوم',
      productId: 'Fakka_29_Unite',
    ),
    CardModel(
      id: '10',
      name: 'فكة 35',
      netCharge: '35.00',
      units: '1300 وحدة',
      duration: '14 يوم',
      productId: 'Fakka_35_Unite',
    ),
  ];
}
