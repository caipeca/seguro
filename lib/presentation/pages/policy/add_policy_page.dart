import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/insurance_policy_entity.dart';
import '../../../domain/repositories/policy_repository.dart';
import '../../../domain/usecases/policy/add_policy.dart';
import '../../bloc/auth_bloc.dart';

class AddPolicyPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  final _insurerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Apólice')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Tipo (ex: auto, saúde)'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _insurerController,
                decoration: const InputDecoration(labelText: 'Seguradora'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final authState = context.read<AuthBloc>().state;
                    if (authState is! AuthSuccess || authState.user == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Usuário não autenticado')),
                      );
                      return;
                    }

                    final newPolicy = InsurancePolicyEntity(
                      type: _typeController.text,
                      insurerName: _insurerController.text,
                      expiryDate: DateTime.now().add(const Duration(days: 365)),
                      userId: authState.user.id,
                    );

                    final result = await AddPolicy(
                      context.read<PolicyRepository>(),
                    ).call(newPolicy);

                    result.fold(
                          (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro: $error')),
                        );
                      },
                          (_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Apólice adicionada com sucesso!')),
                        );
                        Navigator.pop(context);
                      },
                    );
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}