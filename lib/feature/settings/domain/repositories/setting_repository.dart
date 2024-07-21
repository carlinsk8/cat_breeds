import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/info_device.dart';

abstract class SettingRepository {
  Future<Either<Failure, InfoDevice>> getVersion();
  Future<Either<Failure, bool>> getDarkMode();
  Future<Either<Failure, bool>> setDarkMode(bool value);
}