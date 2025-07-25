import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seguro/domain/entities/insurance_policy_entity.dart';

import '../../domain/usecases/policy/add_policy.dart';
import '../../domain/usecases/policy/get_policies.dart';

abstract class PolicyEvent{}
class LoadPolicies extends PolicyEvent{
  final String userId;
  LoadPolicies(this.userId);
}
class AddPolicyEvent extends PolicyEvent{
  final InsurancePolicyEntity policy;

  AddPolicyEvent(this.policy);
}

abstract class PolicyState{}
class PolicyAddedSuccess extends PolicyState{}
class PolicyInitial extends PolicyState{}
class PolicyLoading extends PolicyState{}
class PolicyLoaded extends PolicyState{
  final List<InsurancePolicyEntity> policies;

  PolicyLoaded(this.policies);
}
class PolicyFailure extends PolicyState{
  final String error;

  PolicyFailure(this.error);

}

class PolicyBloc extends Bloc<PolicyEvent,PolicyState>{
  final GetPolicies getPolicies;
  final AddPolicy addPolicy;

  PolicyBloc({required this.addPolicy,required this.getPolicies}): super(PolicyInitial()){
    on<LoadPolicies>((event, emit) async{
      emit(PolicyLoading());
      try {
        final policies = await getPolicies(event.userId);
        emit (PolicyLoaded(policies));
      }catch(e){
        emit(PolicyFailure(e.toString()));
      }
    });
    on<AddPolicyEvent>((event, emit) async {
      emit(PolicyLoading());
      final result = await addPolicy(event.policy);
      result.fold((error) => emit(PolicyFailure(error.toString())), (_) => emit(PolicyAddedSuccess()));
    });
  }
}