import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/insurance_policy_entity.dart';
import '../../bloc/auth_bloc.dart';
import '../../bloc/policy_bloc.dart';
import '../../widgets/policy_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String? _userId;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkAuthChanges();
  }

  void _initializeData() {
    _userId = _getUserId();
    _loadPolicies();
  }

  void _checkAuthChanges() {
    final newUserId = _getUserId();
    if (newUserId != _userId) {
      setState(() {
        _userId = newUserId;
      });
      _loadPolicies();
    }
  }

  String? _getUserId() {
    final authState = context.read<AuthBloc>().state;
    return authState is AuthSuccess ? authState.user.id : null;
  }

  void _loadPolicies() {
    if (_userId != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<PolicyBloc>().add(LoadPolicies(_userId!));
      });
    }
  }

  Future<void> _handleRefresh() async {
    setState(() => _isRefreshing = true);
    if (_userId != null) {
      context.read<PolicyBloc>().add(LoadPolicies(_userId!));
    }
    setState(() => _isRefreshing = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        title: const Center(child: Text("Meus Seguros")),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () => _showNotifications(context),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddPolicy(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<PolicyBloc, PolicyState>(
      listener: (context, state) {
        if (state is PolicyFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        if (_isRefreshing && state is! PolicyLoading) {
          state = PolicyLoading(); // Força mostrar loading durante refresh
        }

        if (state is PolicyLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is PolicyLoaded) {
          if (state.policies.isEmpty) {
            return _buildEmptyState();
          }
          return _buildPolicyList(state.policies);
        }
        return _buildInitialState();
      },
    );
  }

  Widget _buildPolicyList(List<InsurancePolicyEntity> policies) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: policies.length,
        itemBuilder: (context, index) => PolicyCard(
          policy: policies[index],
          onTap: () => _showPolicyDetails(context, policies[index]),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.assignment, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            "Nenhuma apólice cadastrada",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => _navigateToAddPolicy(context),
            child: const Text("Adicionar primeira apólice"),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return const Center(child: Text("Carregando..."));
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.warning), label: "Alertas"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
      ],
    );
  }

  void _showPolicyDetails(BuildContext context, InsurancePolicyEntity policy) {
    Navigator.pushNamed(
      context,
      '/policy-details',
      arguments: policy,
    );
  }

  void _navigateToAddPolicy(BuildContext context) {
    Navigator.pushNamed(context, '/add-policy');
  }

  void _showNotifications(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Funcionalidade em desenvolvimento")),
    );
  }
}