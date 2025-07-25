import 'package:seguro/data/datasources/policy_data_source.dart';
import 'package:seguro/data/models/insurance_policy_model.dart';
import 'package:seguro/domain/entities/insurance_policy_entity.dart';
import 'package:seguro/domain/repositories/policy_repository.dart';

class PolicyRepositoryImpl implements PolicyRepository{
  final PolicyRemoteDataSource remoteDataSource;

  PolicyRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addPolicy(InsurancePolicyEntity policy) {
    // TODO: implement addPolicy
    return remoteDataSource.addPolicy(InsurancePolicyModel.fromEntity(policy));
  }

  @override
  Future<List<InsurancePolicyEntity>> getPolicies(String userId) async {
    // TODO: implement getPolicies
    final policies = await remoteDataSource.getPolicies(userId);
    return policies.map((model)=> model.toEntity()).toList();
  }
}