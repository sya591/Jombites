import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CategoryRecord extends FirestoreRecord {
  CategoryRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "CategoryName" field.
  String? _categoryName;
  String get categoryName => _categoryName ?? '';
  bool hasCategoryName() => _categoryName != null;

  void _initializeFields() {
    _categoryName = snapshotData['CategoryName'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Category');

  static Stream<CategoryRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CategoryRecord.fromSnapshot(s));

  static Future<CategoryRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CategoryRecord.fromSnapshot(s));

  static CategoryRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CategoryRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CategoryRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CategoryRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CategoryRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CategoryRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCategoryRecordData({
  String? categoryName,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'CategoryName': categoryName,
    }.withoutNulls,
  );

  return firestoreData;
}

class CategoryRecordDocumentEquality implements Equality<CategoryRecord> {
  const CategoryRecordDocumentEquality();

  @override
  bool equals(CategoryRecord? e1, CategoryRecord? e2) {
    return e1?.categoryName == e2?.categoryName;
  }

  @override
  int hash(CategoryRecord? e) => const ListEquality().hash([e?.categoryName]);

  @override
  bool isValidKey(Object? o) => o is CategoryRecord;
}
