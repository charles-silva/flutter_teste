import 'package:flutter/material.dart';
import 'package:flutter_dev_test/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  App({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Dev Flutter Test',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routerConfig: _appRouter.buildRouter(),
      ),
    );
  }
}
