import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/core/colors/app_colors.dart';
import 'package:flutter_dev_test/core/rest_client/dio/dio_rest_client.dart';
import 'package:flutter_dev_test/core/ui/components/app_buttom.dart';
import 'package:flutter_dev_test/core/ui/components/app_snackbar.dart';
import 'package:flutter_dev_test/core/util/extensions/size_screen_extension.dart';
import 'package:flutter_dev_test/modules/auth/verification/controller/verification_bloc.dart';
import 'package:flutter_dev_test/modules/auth/verification/controller/verification_event.dart';
import 'package:flutter_dev_test/repositories/verification/verification_repository_impl.dart';
import 'package:flutter_dev_test/router/app_routers.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../controller/verification_state.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final defaultPinTheme = PinTheme(
    width: 54.w,
    height: 56.h,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      color: AppColors.textInputColor,
      border: Border.all(color: Colors.grey[400]!),
      borderRadius: BorderRadius.circular(5),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final pinController = TextEditingController();
    final controller = VerificationBloc(repository: VerificationRepositoryImpl(client: DioRestClient()));
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<VerificationBloc, VerificationState>(
        bloc: controller,
        listener: (context, state) {
          if (state is VerificationErrorState) {
            AppSnackbar.showSnackBar(context, state.message);
          } else if (state is VerificationSuccessState) {
            context.go(AppRoutes.home);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Verificação',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.6,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Insira o código que foi enviado:',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 80.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pinput(
                      controller: pinController,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.buttomColor),
                        ),
                      ),
                      length: 6,
                      onChanged: (value) => controller.add(VerificationButtomEvent(value.length == 6)),
                    )
                  ],
                ),
                SizedBox(height: 32.h),
                AppButtom(
                  onPressed: state is VerificationButtomState && state.isEnable
                      ? () {
                          controller.add(VerificationRecoveryCodeEvent(code: pinController.text));
                        }
                      : null,
                  label: const Text('Confirmar'),
                ),
                SizedBox(height: 50.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8.w,
                  children: [
                    Image.asset(
                      'assets/icons/ic_message_question.png',
                      width: 20.w,
                      height: 20.h,
                    ),
                    Text(
                      'Não recebi o código',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
