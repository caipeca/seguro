import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/insurance_policy_entity.dart';
class InsurancePolicyModel{
  final String id;
  final String type;
  final String insurerName;
  final DateTime expiryDate;
  final String userId;

  InsurancePolicyModel({required this.id, required this.type, required this.insurerName, required this.expiryDate, required this.userId});

  factory InsurancePolicyModel.fromFirestore(DocumentSnapshot doc){
    final data = doc.data() as Map<String, dynamic>;
    return InsurancePolicyModel(id: doc.id, type: data['type'], insurerName: data['insurerName'], expiryDate: (data['expiryDate'] as Timestamp).toDate(), userId: data['userId']?? '');
  }

  Map<String, dynamic> toMap(){
    return {
      'type': type,
      'insurerName': insurerName,
      'expiryDate': Timestamp.fromDate(expiryDate),
      'userId': userId,
    };
  }

  InsurancePolicyEntity toEntity() {
    return InsurancePolicyEntity(
      id: id,
      type: type,
      insurerName: insurerName,
      expiryDate: expiryDate,
      userId: userId,
    );
  }

// Factory para converter Entity -> Model
  factory InsurancePolicyModel.fromEntity(InsurancePolicyEntity entity) {
    return InsurancePolicyModel(
      id: entity.id,
      type: entity.type,
      insurerName: entity.insurerName,
      expiryDate: entity.expiryDate,
      userId: entity.userId,
    );
  }
}