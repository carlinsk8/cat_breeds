import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/setting_repository.dart';

class GetDarkModeUseCase extends UseCase<bool, NoParams> {
  final SettingRepository settingRepository;

  GetDarkModeUseCase({required this.settingRepository});

  @override
  Future<Either<Failure, bool>> call(NoParams params,{Callback? callback}) 
  => settingRepository.getDarkMode();
}