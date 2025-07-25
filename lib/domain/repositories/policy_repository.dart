import '../entities/insurance_policy_entity.dart';

abstract class PolicyRepository{
  Future<List<InsurancePolicyEntity>> getPolicies(String userId);
  Future<void> addPolicy(InsurancePolicyEntity policy);
}