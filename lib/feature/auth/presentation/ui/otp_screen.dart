import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/feature/auth/presentation/cubit/cubit/authcubit_cubit.dart';
import 'package:bookia/feature/auth/presentation/ui/wedgit/otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  late final String email;
  final List<TextEditingController> _otpControllers =
      List.generate(5, (_) => TextEditingController());

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    email = (args is String && args.isNotEmpty) ? args : '';
  }

  @override
  void dispose() {
    for (final c in _otpControllers) {
      c.dispose();
    }
    super.dispose();
  }

  String get _otpCode =>
      _otpControllers.map((c) => c.text).join();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthcubitCubit(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: BlocConsumer<AuthcubitCubit, AuthcubitState>(
            listener: (context, state) {
              if (state is CheckOtpLoadingState) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const AlertDialog(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    content: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                );
              } else if (state is CheckOtpSuccessState) {
                Navigator.pop(context); 
                Navigator.pushNamed(
                  context,
                  AppRoutes.createNewPassword,
                  arguments: email,
                );
              } else if (state is CheckOtpErrorState) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return OtpWidget(
                controllers: _otpControllers,
                onVerify: () {
                  final code = _otpCode;
                  if (code.length < 5) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter the full 5-digit code'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                    return;
                  }
                  context.read<AuthcubitCubit>().checkForgetPassword(
                        email: email,
                        code: code,
                      );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
