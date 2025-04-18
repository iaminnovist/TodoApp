import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F7),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: authProvider.signupFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD86628),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'TO-DO',
                          style: TextStyle(
                            color: Color(0xFFD86628),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          style: IconButton.styleFrom(
                            foregroundColor: const Color(0xFF1D1517),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1D1517),
                          ),
                        ),
                        Row(
                          children: [
                            const Text(
                              'Already have an account? ',
                              style: TextStyle(
                                color: Color(0xFF7B6F72),
                                fontSize: 14,
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Color(0xFFD86628),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: authProvider.fullNameController,
                          validator: authProvider.validateFullName,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            hintText: 'John Doe',
                            filled: true,
                            fillColor: const Color(0xFFF7F8F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            labelStyle: const TextStyle(color: Color(0xFF7B6F72)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: authProvider.emailController,
                          validator: authProvider.validateEmail,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'johndoe@gmail.com',
                            filled: true,
                            fillColor: const Color(0xFFF7F8F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            labelStyle: const TextStyle(color: Color(0xFF7B6F72)),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: authProvider.dateOfBirthController,
                          validator: authProvider.validateDateOfBirth,
                          decoration: InputDecoration(
                            labelText: 'Date of birth',
                            hintText: '18/03/2024',
                            filled: true,
                            fillColor: const Color(0xFFF7F8F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            labelStyle: const TextStyle(color: Color(0xFF7B6F72)),
                            suffixIcon: IconButton(
                              icon: const Icon(
                                Icons.calendar_today_outlined,
                                color: Color(0xFF7B6F72),
                              ),
                              onPressed: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (date != null) {
                                  authProvider.dateOfBirthController.text =
                                      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
                                }
                              },
                            ),
                          ),
                          readOnly: true,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: authProvider.phoneController,
                          validator: authProvider.validatePhone,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            hintText: '(+91) 85726-05920',
                            filled: true,
                            fillColor: const Color(0xFFF7F8F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            labelStyle: const TextStyle(color: Color(0xFF7B6F72)),
                            // prefixIcon: Container(
                            //   padding: const EdgeInsets.all(16),
                            //   child: Image.asset(
                            //     'assets/images/india_flag.png',
                            //     width: 24,
                            //     height: 24,
                            //   ),
                            // ),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: authProvider.passwordController,
                          validator: authProvider.validatePassword,
                          obscureText: !authProvider.isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: 'Set Password',
                            filled: true,
                            fillColor: const Color(0xFFF7F8F8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            labelStyle: const TextStyle(color: Color(0xFF7B6F72)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                authProvider.isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color(0xFF7B6F72),
                              ),
                              onPressed: () => authProvider.togglePasswordVisibility(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => authProvider.signUp(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD86628),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            child: authProvider.isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Register',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 