import '../../../shared/app_router.dart';
import '../presentation/pages/setting_page.dart';

initSetting() {
  AppRouter.appRouter
    .define(
      routePath: SettingPage.id,
      handler: AppRouteHandler(
        handlerFunc: (_) {
          return  const SettingPage();
        },
      ),
    );
}