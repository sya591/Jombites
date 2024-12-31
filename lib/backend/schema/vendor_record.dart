import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VendorRecord extends FirestoreRecord {
  VendorRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "VendorName" field.
  String? _vendorName;
  String get vendorName => _vendorName ?? '';
  bool hasVendorName() => _vendorName != null;

  // "PhoneNo" field.
  String? _phoneNo;
  String get phoneNo => _phoneNo ?? '';
  bool hasPhoneNo() => _phoneNo != null;

  // "OperatingHours" field.
  DateTime? _operatingHours;
  DateTime? get operatingHours => _operatingHours;
  bool hasOperatingHours() => _operatingHours != null;

  // "SocialMedia" field.
  String? _socialMedia;
  String get socialMedia => _socialMedia ?? '';
  bool hasSocialMedia() => _socialMedia != null;

  // "Geopoint" field.
  LatLng? _geopoint;
  LatLng? get geopoint => _geopoint;
  bool hasGeopoint() => _geopoint != null;

  // "Description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "Address" field.
  String? _address;
  String get address => _address ?? '';
  bool hasAddress() => _address != null;

  // "Ratings" field.
  List<int>? _ratings;
  List<int> get ratings => _ratings ?? const [];
  bool hasRatings() => _ratings != null;

  // "CategoryFood" field.
  List<String>? _categoryFood;
  List<String> get categoryFood => _categoryFood ?? const [];
  bool hasCategoryFood() => _categoryFood != null;

  // "ImageSlide1" field.
  String? _imageSlide1;
  String get imageSlide1 => _imageSlide1 ?? '';
  bool hasImageSlide1() => _imageSlide1 != null;

  // "ImageSlide2" field.
  String? _imageSlide2;
  String get imageSlide2 => _imageSlide2 ?? '';
  bool hasImageSlide2() => _imageSlide2 != null;

  // "ImageSlide3" field.
  String? _imageSlide3;
  String get imageSlide3 => _imageSlide3 ?? '';
  bool hasImageSlide3() => _imageSlide3 != null;

  // "Place" field.
  String? _place;
  String get place => _place ?? '';
  bool hasPlace() => _place != null;

  void _initializeFields() {
    _vendorName = snapshotData['VendorName'] as String?;
    _phoneNo = snapshotData['PhoneNo'] as String?;
    _operatingHours = snapshotData['OperatingHours'] as DateTime?;
    _socialMedia = snapshotData['SocialMedia'] as String?;
    _geopoint = snapshotData['Geopoint'] as LatLng?;
    _description = snapshotData['Description'] as String?;
    _address = snapshotData['Address'] as String?;
    _ratings = getDataList(snapshotData['Ratings']);
    _categoryFood = getDataList(snapshotData['CategoryFood']);
    _imageSlide1 = snapshotData['ImageSlide1'] as String?;
    _imageSlide2 = snapshotData['ImageSlide2'] as String?;
    _imageSlide3 = snapshotData['ImageSlide3'] as String?;
    _place = snapshotData['Place'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Vendor');

  static Stream<VendorRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => VendorRecord.fromSnapshot(s));

  static Future<VendorRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => VendorRecord.fromSnapshot(s));

  static VendorRecord fromSnapshot(DocumentSnapshot snapshot) => VendorRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static VendorRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      VendorRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'VendorRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is VendorRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createVendorRecordData({
  String? vendorName,
  String? phoneNo,
  DateTime? operatingHours,
  String? socialMedia,
  LatLng? geopoint,
  String? description,
  String? address,
  String? imageSlide1,
  String? imageSlide2,
  String? imageSlide3,
  String? place,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'VendorName': vendorName,
      'PhoneNo': phoneNo,
      'OperatingHours': operatingHours,
      'SocialMedia': socialMedia,
      'Geopoint': geopoint,
      'Description': description,
      'Address': address,
      'ImageSlide1': imageSlide1,
      'ImageSlide2': imageSlide2,
      'ImageSlide3': imageSlide3,
      'Place': place,
    }.withoutNulls,
  );

  return firestoreData;
}

class VendorRecordDocumentEquality implements Equality<VendorRecord> {
  const VendorRecordDocumentEquality();

  @override
  bool equals(VendorRecord? e1, VendorRecord? e2) {
    const listEquality = ListEquality();
    return e1?.vendorName == e2?.vendorName &&
        e1?.phoneNo == e2?.phoneNo &&
        e1?.operatingHours == e2?.operatingHours &&
        e1?.socialMedia == e2?.socialMedia &&
        e1?.geopoint == e2?.geopoint &&
        e1?.description == e2?.description &&
        e1?.address == e2?.address &&
        listEquality.equals(e1?.ratings, e2?.ratings) &&
        listEquality.equals(e1?.categoryFood, e2?.categoryFood) &&
        e1?.imageSlide1 == e2?.imageSlide1 &&
        e1?.imageSlide2 == e2?.imageSlide2 &&
        e1?.imageSlide3 == e2?.imageSlide3 &&
        e1?.place == e2?.place;
  }

  @override
  int hash(VendorRecord? e) => const ListEquality().hash([
        e?.vendorName,
        e?.phoneNo,
        e?.operatingHours,
        e?.socialMedia,
        e?.geopoint,
        e?.description,
        e?.address,
        e?.ratings,
        e?.categoryFood,
        e?.imageSlide1,
        e?.imageSlide2,
        e?.imageSlide3,
        e?.place
      ]);

  @override
  bool isValidKey(Object? o) => o is VendorRecord;
}
