import 'package:flutter_bloc/flutter_bloc.dart';

// Các sự kiện cho ProfileBloc
abstract class ProfileEvent {}
class FetchProfile extends ProfileEvent {}
class UpdateProfile extends ProfileEvent {
  final String username;
  UpdateProfile(this.username);
}

abstract class ProfileState {}
class ProfileLoading extends ProfileState {}
class ProfileLoaded extends ProfileState {
  final String username;
  ProfileLoaded(this.username);
}
class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoading()){
    on<FetchProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        await Future.delayed(const Duration(seconds: 2));
        emit(ProfileLoaded("Duy Cường"));
      } catch (e) {
        emit(ProfileError("Lỗi tải pro5"));
      }
    });

    on<UpdateProfile>((event, emit) async {
      emit(ProfileLoaded(event.username));
    });
  }

}
