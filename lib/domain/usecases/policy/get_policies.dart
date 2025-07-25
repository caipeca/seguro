import 'package:seguro/domain/entities/insurance_policy_entity.dart';
import 'package:seguro/domain/repositories/policy_repository.dart';

class GetPolicies{
  final PolicyRepository repository;

  GetPolicies(this.repository);

  Future<List<InsurancePolicyEntity>> call(String userId) async{
    return await repository.getPolicies(userId);
  }
}