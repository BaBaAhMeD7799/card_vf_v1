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
    // 1. كارت الفكة الأساسي الشغال (مسجل بالسيرفر كـ 2.5)
    CardModel(
      id: '1',
      name: 'فكة (وحدات)',
      netCharge: '3.00',
      units: '45 وحدة',
      duration: 'حتى منتصف الليل',
      productId: 'Fakka_2.5_Unite', // الكود الذي كان يعمل معك سابقاً
    ),

    // 2. كارت فكة دقائق
    CardModel(
      id: '2',
      name: 'فكة (دقائق)',
      netCharge: '3.00',
      units: '45 دقيقة',
      duration: 'حتى منتصف الليل',
      productId: 'Fakka_2.5_Minute',
    ),

    // 3. فكة 5 دقائق
    CardModel(
      id: '3',
      name: 'فكة 6 (دقائق)',
      netCharge: '6.00',
      units: '225 دقيقة',
      duration: 'حتى منتصف الليل',
      productId: 'Fakka_5_Minute',
    ),

    // 4. مارد 7 دقائق
    CardModel(
      id: '4',
      name: 'مارد 7 (دقائق)',
      netCharge: '7.00',
      units: '300 دقيقة',
      duration: '3 أيام',
      productId: 'Mared_7_Minute',
    ),

    // 5. مارد 7 فليكسات
    CardModel(
      id: '5',
      name: 'مارد 7 (فليكس)',
      netCharge: '7.00',
      units: '300 فليكس',
      duration: '3 أيام',
      productId: 'Mared_7_Flex',
    ),

    // 6. مارد 10 دقائق
    CardModel(
      id: '6',
      name: 'مارد 10 (دقائق)',
      netCharge: '10.00',
      units: '450 دقيقة',
      duration: '7 أيام',
      productId: 'Mared_10_Minute',
    ),

    // 7. مارد 10 فليكسات
    CardModel(
      id: '7',
      name: 'مارد 10 (فليكس)',
      netCharge: '10.00',
      units: '450 فليكس',
      duration: '7 أيام',
      productId: 'Mared_10_Flex',
    ),

    // 8. كارت 15 الذي يعطي 550 دقيقة (حل المشكلة الأولى)
    CardModel(
      id: '8',
      name: 'فكة 15 (550 دقيقة)',
      netCharge: '15.00',
      units: '550 دقيقة',
      duration: '7 أيام',
      productId: 'Fakka_15_Minute', // هذا المعرف يعطي الـ 550 دقيقة
    ),

    // 9. كارت 15 الذي يعطي 300 وحدة لكل الشبكات
    CardModel(
      id: '9',
      name: 'فكة 15 (300 وحدة)',
      netCharge: '15.00',
      units: '300 وحدة',
      duration: '7 أيام',
      productId: 'Fakka_15_Unite', // الكود الشغال الذي كان يمنح 300 وحدة
    ),
  ];
}
