import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../config/routes.dart/routes.dart';
import '../../../../core/utils/input_validator.dart';
import '../../../blocs/auth/auth_bloc.dart';
import '../../../blocs/auth/auth_event.dart';
import '../../../blocs/auth/auth_state.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(LoginEvent(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        elevation: 0,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AuthSuccess) {
            // Navigate to home page after successful login
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return _buildLoginForm();
        },
      ),
    );
  }

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo or app name
            const SizedBox(height: 40),
            Image.asset(
              'assets/images/logo.png',
              height: 120,
            ),
            const SizedBox(height: 40),

            // Email field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              validator: MultiValidator([
                RequiredValidator(errorText: 'Email is required'),
                EmailValidator(errorText: 'Enter a valid email address'),
              ]),
            ),
            const SizedBox(height: 16),

            // Password field
            TextFormField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),

            // Remember me & Forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                    ),
                    const Text('Remember me'),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    //Navigator.pushNamed(context, AppRoutes.forgotPassword);
                  },
                  child: const Text('Forgot Password?'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Login button
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'LOGIN',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),

            // Social login options
            Row(
              children: [
                const Expanded(child: Divider()),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Or login with'),
                ),
                const Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialLoginButton(
                  icon: 'assets/icons/google.png',
                  onTap: () => _handleSocialLogin('google'),
                ),
                const SizedBox(width: 24),
                _socialLoginButton(
                  icon: 'assets/icons/facebook.png',
                  onTap: () => _handleSocialLogin('facebook'),
                ),
                const SizedBox(width: 24),
                _socialLoginButton(
                  icon: 'assets/icons/apple.png',
                  onTap: () => _handleSocialLogin('apple'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Register link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.register);
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialLoginButton({required String icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(
          icon,
          height: 24,
          width: 24,
        ),
      ),
    );
  }

  void _handleSocialLogin(String provider) {
    // Implement social login logic here
    // This would typically involve authentication using a plugin
    // and then dispatching a SocialLoginEvent to the BLoC

    // Example (pseudo-code):
    // final token = await SocialLoginService.login(provider);
    // if (token != null) {
    //   context.read<AuthBloc>().add(SocialLoginEvent(provider: provider, token: token));
    // }
  }
}