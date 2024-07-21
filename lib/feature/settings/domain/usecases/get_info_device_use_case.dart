
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/use_case.dart';
import '../entities/info_device.dart';
import '../repositories/setting_repository.dart';

class GetInfoDeviceUseCase extends UseCase<InfoDevice, NoParams> {
  final SettingRepository settingRepository;

  GetInfoDeviceUseCase({required this.settingRepository});

  @override
  Future<Either<Failure, InfoDevice>> call(NoParams params,{Callback? callback}) 
  => settingRepository.getVersion();
}