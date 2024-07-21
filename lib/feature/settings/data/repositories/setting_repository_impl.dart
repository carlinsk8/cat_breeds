import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/info_device.dart';
import '../../domain/repositories/setting_repository.dart';
import '../datasources/setting_local_data_sources.dart';
import '../models/info_device_model.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingLocalDatasource settingLocalDatasource;

  SettingRepositoryImpl({required this.settingLocalDatasource});
  @override
  Future<Either<Failure, InfoDevice>> getVersion() async {
    try {
      final result = await settingLocalDatasource.getInfoDevice();
      final data = InfoDeviceModel.fromJson(result.data);
      return Right(data);
    } catch (e) {
      return const Left(UnexpectedFailure());
    }
  }
  
  @override
  Future<Either<Failure, bool>> getDarkMode() async {
    try {
      final result = await settingLocalDatasource.getDardMode();
      return Right(result.data);
    } catch (e) {
      return const Left(UnexpectedFailure());
    }
  }
  
  @override
  Future<Either<Failure, bool>> setDarkMode(bool value) async {
    try {
      final result = await settingLocalDatasource.setDardMode(value);
      return Right(result.data);
    } catch (e) {
      return const Left(UnexpectedFailure());
    }
  }
}