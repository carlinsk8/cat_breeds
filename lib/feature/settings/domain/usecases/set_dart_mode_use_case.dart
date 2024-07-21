import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';
import '../repositories/setting_repository.dart';

class SetDarkModeUseCase extends UseCase<bool, bool> {
  final SettingRepository settingRepository;

  SetDarkModeUseCase({required this.settingRepository});

  @override
  Future<Either<Failure, bool>> call(bool params,{Callback? callback}) 
  => settingRepository.setDarkMode(params);
}