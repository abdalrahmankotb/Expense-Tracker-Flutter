class Addmodel {
  String ? id;
  String title;
  String subtitle;
  String place;
  String way;
  String image;
  num price;
  DateTime date;

  Addmodel({
   this.id,
    required this.title,
    required this.subtitle,
    required this.place,
    required this.way,
    required this.image,
    required this.price,
    required this.date,
  });

  factory Addmodel.fromMap(Map<String, dynamic> data, {required String id}) {
    return Addmodel(
      id: id,
      title: data['title'] ?? '',
      subtitle: data['subtitle'] ?? '',
      place: data['place'] ?? '',
      way: data['way'] ?? '',
      image: data['image'] ?? '',
      price: data['price'] ?? 0,
      date: (data['date'] != null)
          ? DateTime.tryParse(data['date'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

 Map<String, dynamic> toMap() {
  return {
    'title': title,
    'subtitle': subtitle,
    'place': place,
    'way': way,
    'image': image,
    'price': price,
    'date': date.toIso8601String(),
  };
}

}
