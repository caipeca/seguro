
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seguro/data/models/insurance_policy_model.dart';

class PolicyRemoteDataSource{
  final FirebaseFirestore _firestore;

  PolicyRemoteDataSource(this._firestore);

  Future<List<InsurancePolicyModel>> getPolicies(String userId) async {
    final snapshot = await _firestore
        .collection('policies')
        .where('userId', isEqualTo: userId)
        .get();
    return snapshot.docs.map((doc)=> InsurancePolicyModel.fromFirestore(doc)).toList();
  }

  Future<void> addPolicy(InsurancePolicyModel policy) async {
    await _firestore.collection('policies').add(policy.toMap());
  }
}