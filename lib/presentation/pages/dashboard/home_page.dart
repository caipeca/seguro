import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/policy_bloc.dart';
import '../../widgets/policy_card.dart';

// lib/home/presentation/pages/home_page.dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Seguros"),
        actions: [
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add-policy'),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: BlocBuilder<PolicyBloc, PolicyState>(
        builder: (context, state) {
          if (state is PolicyLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is PolicyFailure) {
            return Center(child: Text("Erro ao carregar apólices"));
          }
          if (state is PolicyLoaded) {
            return ListView.builder(
              itemCount: state.policies.length,
              itemBuilder: (context, index) {
                return PolicyCard(policy: state.policies[index]);
              },
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.warning), label: "Alertas"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}
