import 'package:app_flutter/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:app_flutter/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    final context = this.context;
    Future.delayed(Duration(seconds: 2),(){
      if(context.mounted){
        final authCubit = context.read<AuthCubit>();
        authCubit.checkUserLogged();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) => _listenAuthCubit(context,state),
        child: Center(
          child: CircularProgressIndicator(),
        )
      ),
    );
  }

  void _listenAuthCubit(BuildContext context, AuthState state){
    if(state is AuthCheckUserLoggedSuccessState){
      Navigator.pushNamedAndRemoveUntil(context, 'ecommerce/catalog/list', (route) => false);
    }
    if(state is AuthCheckUserLoggedFailState){
      Navigator.pushNamedAndRemoveUntil(context, 'ecommerce/catalog/list', (route) => false);
    }
  }
}
