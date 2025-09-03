import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PetInfoRecord extends FirestoreRecord {
  PetInfoRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "PetName" field.
  String? _petName;
  String get petName => _petName ?? '';
  bool hasPetName() => _petName != null;

  // "PetGender" field.
  String? _petGender;
  String get petGender => _petGender ?? '';
  bool hasPetGender() => _petGender != null;

  // "PetAge" field.
  int? _petAge;
  int get petAge => _petAge ?? 0;
  bool hasPetAge() => _petAge != null;

  // "PetHeartRate" field.
  int? _petHeartRate;
  int get petHeartRate => _petHeartRate ?? 0;
  bool hasPetHeartRate() => _petHeartRate != null;

  // "PetVOCPercent" field.
  double? _petVOCPercent;
  double get petVOCPercent => _petVOCPercent ?? 0.0;
  bool hasPetVOCPercent() => _petVOCPercent != null;

  // "PetSpeed" field.
  double? _petSpeed;
  double get petSpeed => _petSpeed ?? 0.0;
  bool hasPetSpeed() => _petSpeed != null;

  // "PetIsHealthy" field.
  bool? _petIsHealthy;
  bool get petIsHealthy => _petIsHealthy ?? false;
  bool hasPetIsHealthy() => _petIsHealthy != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _uid = snapshotData['uid'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _petName = snapshotData['PetName'] as String?;
    _petGender = snapshotData['PetGender'] as String?;
    _petAge = castToType<int>(snapshotData['PetAge']);
    _petHeartRate = castToType<int>(snapshotData['PetHeartRate']);
    _petVOCPercent = castToType<double>(snapshotData['PetVOCPercent']);
    _petSpeed = castToType<double>(snapshotData['PetSpeed']);
    _petIsHealthy = snapshotData['PetIsHealthy'] as bool?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('PetInfo');

  static Stream<PetInfoRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PetInfoRecord.fromSnapshot(s));

  static Future<PetInfoRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PetInfoRecord.fromSnapshot(s));

  static PetInfoRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PetInfoRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PetInfoRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PetInfoRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PetInfoRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PetInfoRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPetInfoRecordData({
  String? email,
  String? displayName,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  String? petName,
  String? petGender,
  int? petAge,
  int? petHeartRate,
  double? petVOCPercent,
  double? petSpeed,
  bool? petIsHealthy,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'display_name': displayName,
      'photo_url': photoUrl,
      'uid': uid,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'PetName': petName,
      'PetGender': petGender,
      'PetAge': petAge,
      'PetHeartRate': petHeartRate,
      'PetVOCPercent': petVOCPercent,
      'PetSpeed': petSpeed,
      'PetIsHealthy': petIsHealthy,
    }.withoutNulls,
  );

  return firestoreData;
}

class PetInfoRecordDocumentEquality implements Equality<PetInfoRecord> {
  const PetInfoRecordDocumentEquality();

  @override
  bool equals(PetInfoRecord? e1, PetInfoRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.uid == e2?.uid &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.petName == e2?.petName &&
        e1?.petGender == e2?.petGender &&
        e1?.petAge == e2?.petAge &&
        e1?.petHeartRate == e2?.petHeartRate &&
        e1?.petVOCPercent == e2?.petVOCPercent &&
        e1?.petSpeed == e2?.petSpeed &&
        e1?.petIsHealthy == e2?.petIsHealthy;
  }

  @override
  int hash(PetInfoRecord? e) => const ListEquality().hash([
        e?.email,
        e?.displayName,
        e?.photoUrl,
        e?.uid,
        e?.createdTime,
        e?.phoneNumber,
        e?.petName,
        e?.petGender,
        e?.petAge,
        e?.petHeartRate,
        e?.petVOCPercent,
        e?.petSpeed,
        e?.petIsHealthy
      ]);

  @override
  bool isValidKey(Object? o) => o is PetInfoRecord;
}
