import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/core/colors/app_colors.dart';
import 'package:flutter_dev_test/core/rest_client/dio/dio_rest_client.dart';
import 'package:flutter_dev_test/core/ui/components/app_buttom.dart';
import 'package:flutter_dev_test/core/ui/components/app_textfield_base.dart';
import 'package:flutter_dev_test/core/util/extensions/size_screen_extension.dart';
import 'package:flutter_dev_test/modules/auth/login/controller/login_bloc.dart';
import 'package:flutter_dev_test/modules/auth/login/controller/login_state.dart';
import 'package:flutter_dev_test/repositories/login/login_repository_impl.dart';
import 'package:flutter_dev_test/router/app_routers.dart';
import 'package:go_router/go_router.dart';

import '../controller/login_event.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Key formKey = GlobalKey<FormState>();
    //usando o DIO para fazer a requisição, poderia ser qualquer outro cliente http
    final controller = LoginBloc(repository: LoginRepositoryImpl(client: DioRestClient()));
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: controller,
      listener: (context, state) {
        if (state is LoginErrorState) {
          showSnackBar(context, state.message);
        } else if (state is LoginInvalidTotpCodState) {
          context.push(AppRoutes.verificationCode);
        } else if (state is LoginSuccessState) {
          context.pushReplacement(AppRoutes.home);
        }
      },
      builder: (context, state) {
        return _buildBody(
          context,
          formKey,
          controller,
          emailController,
          passwordController,
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    Key formKey,
    LoginBloc controller,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: SafeArea(
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(height: 60.h),
                          Image.asset(
                            'assets/images/logo.png',
                          ),
                          SizedBox(height: 30.h),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppTextfield(
                                  controller: emailController,
                                  hintText: 'E-mail',
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(height: 16.h),
                                AppTextfield(
                                  controller: passwordController,
                                  hintText: 'Senha',
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(height: 32.h),
                                AppButtom(
                                    label: const Text('Entrar'),
                                    onPressed: () {
                                      controller.add(LoginEventDoLogin(
                                        username: emailController.text,
                                        password: passwordController.text,
                                      ));
                                    }),
                                //const Spacer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text('Esqueci a senha',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.buttomColor,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: SizedBox(
        height: 30.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}
