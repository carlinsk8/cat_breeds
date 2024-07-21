import '../../../shared/app_router.dart';
import '../presentation/pages/breeds_page.dart';
import '../presentation/pages/detail_breed_page.dart';

initBreeds() {
  AppRouter.appRouter
    ..define(
      routePath: BreedsPage.id,
      handler: AppRouteHandler(
        handlerFunc: (_) {
          return  const BreedsPage();
        },
      ),
    )..define(
      routePath: DetailBreedPage.id,
      handler: AppRouteHandler(
        handlerFunc: (args) {
          final params = args as DetailBreedPageParams;
          return  DetailBreedPage(
            params: params,
          );
        },
      ),
    );
}