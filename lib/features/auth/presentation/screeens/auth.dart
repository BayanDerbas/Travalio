import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travalio/core/constants/app_images.dart';
import '../../../../core/routes/app_routes.dart';
import '../../domain/usecases/auth_usecase.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class AuthScreen extends StatelessWidget {
  final GoRouterState routeState;

  const AuthScreen({super.key, required this.routeState});

  @override
  Widget build(BuildContext context) {
    final isLogin = routeState.uri.path == AppRoutes.login;
    final confirmPasswordController = TextEditingController();

    return BlocProvider(
      create: (_) => AuthBloc(
        registerUseCase: context.read<RegisterUseCase>(),
        loginUseCase: context.read<LoginUseCase>(),
      ),
      child: Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isLogin ? 'Login successful!' : 'Registration successful!'),
                ),
              );
              context.go('/home');
            } else if (state.failure != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.failure!.err_message)),
              );
            }
          },
          builder: (context, state) {
            final bloc = context.read<AuthBloc>();

            return Stack(
              children: [
                SizedBox(
                  height: 350,
                  width: double.infinity,
                  child: Image.asset(
                    isLogin ? 'assets/images/egypt.jpg' : 'assets/images/paris.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 620,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Tabs
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.deepOrange),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => context.go(AppRoutes.login),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeInOut,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        color: isLogin ? Colors.deepOrange : Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: isLogin ? Colors.white : Colors.deepOrange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => context.go(AppRoutes.register),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 250),
                                      curve: Curves.easeInOut,
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        color: !isLogin ? Colors.deepOrange : Colors.white,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Register',
                                        style: TextStyle(
                                          color: !isLogin ? Colors.white : Colors.deepOrange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          // FORM FIELDS
                          if (isLogin) ...[
                            _buildLabeledTextField(
                              label: 'Username',
                              icon: Icons.account_circle,
                              onChanged: (value) {
                                context.read<AuthBloc>().add(AuthUsernameChanged(value));
                              },                            ),
                            const SizedBox(height: 10),
                            _buildLabeledTextField(
                              label: 'Account Password',
                              icon: Icons.lock,
                              onChanged: (v) => bloc.add(AuthPasswordChanged(v)),
                              obscureText: state.obscureConfirmPassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.obscureConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.deepOrange,
                                ),
                                onPressed: () =>
                                    bloc.add(AuthToggleConfirmPasswordVisibility()),
                              ),
                              controller: confirmPasswordController,
                            ),
                          ] else ...[
                            _buildLabeledTextField(
                              label: 'Full Name',
                              icon: Icons.person,
                              onChanged: (v) => bloc.add(AuthFullNameChanged(v)),
                            ),
                            const SizedBox(height: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Your Birthday',
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                const SizedBox(height: 6),
                                GestureDetector(
                                  onTap: () async {
                                    final date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime(2000),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime.now(),
                                      builder: (BuildContext context, Widget? child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: const ColorScheme.light(
                                              primary: Colors.deepOrange,
                                              onPrimary: Colors.white,
                                              onSurface: Colors.black,
                                            ),
                                            textButtonTheme: TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.deepOrange,
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (date != null) {
                                      bloc.add(AuthBirthDateChanged(date));
                                    }
                                  },
                                  child: AbsorbPointer(
                                    child: TextField(
                                      controller: TextEditingController(
                                        text: state.birthDate == null
                                            ? ''
                                            : '${state.birthDate!.month}/${state.birthDate!.day}/${state.birthDate!.year}',
                                      ),
                                      decoration: InputDecoration(
                                        prefixIcon:
                                        const Icon(Icons.calendar_today, color: Colors.deepOrange),
                                        suffixIcon: const Icon(Icons.arrow_drop_down),
                                        hintText: 'Select your birth date',
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          borderSide: BorderSide(color: Colors.grey[300]!),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(25),
                                          borderSide: const BorderSide(color: Colors.deepOrange),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            _buildLabeledTextField(
                              label: 'Account Password',
                              icon: Icons.lock,
                              obscureText: state.obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.deepOrange,
                                ),
                                onPressed: () => bloc.add(AuthTogglePasswordVisibility()),
                              ),
                              onChanged: (v) => bloc.add(AuthPasswordChanged(v)),
                            ),
                            const SizedBox(height: 10),
                            _buildLabeledTextField(
                              label: 'Confirm Your Password',
                              icon: Icons.lock_outline,
                              obscureText: state.obscureConfirmPassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  state.obscureConfirmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.deepOrange,
                                ),
                                onPressed: () =>
                                    bloc.add(AuthToggleConfirmPasswordVisibility()),
                              ),
                              controller: confirmPasswordController,
                            ),
                            const SizedBox(height: 10),
                            _buildLabeledTextField(
                              label: 'Email',
                              icon: Icons.email,
                              onChanged: (v) => bloc.add(AuthEmailChanged(v)),
                            ),
                          ],
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (!isLogin) {
                                if (state.password != confirmPasswordController.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Passwords do not match!'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                              }

                              bloc.add(AuthSubmit(isLogin: isLogin));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: state.isSubmitting
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                              isLogin ? 'Login' : 'Register',
                              style: const TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            isLogin ? 'Or login with' : 'Or Sign up with',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          OutlinedButton.icon(
                            icon: Image.asset(AppImages.google, height: 35),
                            label: const Text('Google'),
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLabeledTextField({
    required String label,
    required IconData icon,
    bool obscureText = false,
    String? hintText,
    Function(String)? onChanged,
    TextEditingController? controller,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon, color: Colors.deepOrange),
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.deepOrange),
            ),
          ),
        ),
      ],
    );
  }
}