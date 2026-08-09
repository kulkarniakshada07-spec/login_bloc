import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_app/login_screen_bloc/login_bloc.dart';
import 'package:login_app/login_screen_bloc/login_event.dart';
import 'package:login_app/login_screen_bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),

      child: Scaffold(
        backgroundColor: const Color(0xFFF1F7FF),

        body: SafeArea(
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              // Show error
              if (state.status == LoginStatus.error) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage),
                      backgroundColor: Colors.red,
                    ),
                  );
              }

              if (state.status == LoginStatus.success) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Login Successful'),
                      backgroundColor: Colors.green,
                    ),
                  );
              }
            },

            builder: (context, state) {
              final bool isLoading =
                  state.status == LoginStatus.loading;

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),

                child: Column(
                  children: [

                    const SizedBox(height: 20),

                    Container(
                      height: 190,
                      width: double.infinity,

                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F2FF),
                        borderRadius: BorderRadius.circular(25),
                      ),

                      child: const Icon(
                        Icons.computer,
                        size: 100,
                        color: Color(0xFF287BEF),
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF101828),
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Login to continue',
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 35),

                    TextField(
                      controller: emailController,

                      keyboardType:
                      TextInputType.emailAddress,

                      onChanged: (value) {
                        context.read<LoginBloc>().add(
                          EmailChanged(value),
                        );
                      },

                      decoration: InputDecoration(
                        hintText: 'Email',

                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Color(0xFF287BEF),
                        ),

                        filled: true,
                        fillColor: Colors.white,

                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),

                        contentPadding:
                        const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: passwordController,

                      obscureText: !isPasswordVisible,

                      onChanged: (value) {
                        context.read<LoginBloc>().add(
                          PasswordChanged(value),
                        );
                      },

                      decoration: InputDecoration(
                        hintText: 'Password',

                        prefixIcon: const Icon(
                          Icons.lock_outline,
                          color: Color(0xFF287BEF),
                        ),

                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible =
                              !isPasswordVisible;
                            });
                          },

                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),

                        filled: true,
                        fillColor: Colors.white,

                        border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),

                        contentPadding:
                        const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,

                      child: TextButton(
                        onPressed: () {},

                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Color(0xFF287BEF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 5),

                    SizedBox(
                      width: double.infinity,
                      height: 58,

                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                          context
                              .read<LoginBloc>()
                              .add(
                            LoginButtonPressed(),
                          );
                        },

                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          const Color(0xFF287BEF),

                          disabledBackgroundColor:
                          const Color(0xFF287BEF),

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(14),
                          ),
                        ),

                        child: isLoading
                            ? const SizedBox(
                          height: 25,
                          width: 25,

                          child:
                          CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                            : const Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,

                          children: [
                            Icon(
                              Icons.login,
                              color: Colors.white,
                            ),

                            SizedBox(width: 10),

                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight:
                                FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300,
                          ),
                        ),

                        const Padding(
                          padding:
                          EdgeInsets.symmetric(
                            horizontal: 15,
                          ),

                          child: Text(
                            'or continue with',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [

                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},

                            style:
                            OutlinedButton.styleFrom(
                              backgroundColor:
                              Colors.white,

                              padding:
                              const EdgeInsets
                                  .symmetric(
                                vertical: 15,
                              ),

                              side: BorderSide.none,

                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                  14,
                                ),
                              ),
                            ),

                            child: const Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,

                              children: [
                                Text(
                                  'G',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight:
                                    FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),

                                SizedBox(width: 10),

                                Text(
                                  'Google',
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 15),

                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},

                            style:
                            OutlinedButton.styleFrom(
                              backgroundColor:
                              Colors.white,

                              padding:
                              const EdgeInsets
                                  .symmetric(
                                vertical: 15,
                              ),

                              side: BorderSide.none,

                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(
                                  14,
                                ),
                              ),
                            ),

                            child: const Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,

                              children: [
                                Icon(
                                  Icons.facebook,
                                  color:
                                  Color(0xFF1877F2),
                                ),

                                SizedBox(width: 8),

                                Text(
                                  'Facebook',
                                  style: TextStyle(
                                    fontWeight:
                                    FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),


                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,

                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {},

                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color(0xFF287BEF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 25),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}