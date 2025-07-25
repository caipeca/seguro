import 'package:seguro/domain/entities/insurance_policy_entity.dart';
import 'package:seguro/domain/repositories/policy_repository.dart';
import 'package:fpdart/fpdart.dart';

abstract class AddPolicyError{}
class InvalidPolicyError implements AddPolicyError{}
class FirestoreError implements AddPolicyError{}

class AddPolicy{
  final PolicyRepository repository;

  AddPolicy(this.repository);

  Future<Either<AddPolicyError, void>> call(InsurancePolicyEntity policy) async {
    try{
      if(policy.type.isEmpty || policy.insurerName.isEmpty){
        return left(InvalidPolicyError());
      }
      await repository.addPolicy(policy);
      return right(null) ;
    }catch (e){
      return left(FirestoreError());
    }
  }
}