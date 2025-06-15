import 'package:cloud_firestore/cloud_firestore.dart';

class Response {
  String intro;
  String bioOne;
  String bioTwo;
  String bioThree;

  Response({
    required this.intro,
    required this.bioOne,
    required this.bioTwo,
    required this.bioThree,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'intro': intro,
      'bioOne': bioOne,
      'bioTwo': bioTwo,
      'bioThree': bioThree,
    };
  }

  factory Response.fromMap(Map<String, dynamic> map) {
    return Response(
      intro: map['intro'] ?? '',
      bioOne: map['bioOne'] ?? '',
      bioTwo: map['bioTwo'] ?? '',
      bioThree: map['bioThree'] ?? '',
    );
  }

  factory Response.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw StateError('Missing data for messageId: ${doc.id}');
    }

    return Response(
      intro: data['intro'] ?? '',
      bioOne: data['bioOne'] ?? '',
      bioTwo: data['bioTwo'] ?? '',
      bioThree: data['bioThree'] ?? '',
    );
  }
}
