import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String phone;
  LoginRequested(this.phone);
  @override
  List<Object?> get props => [phone];
}

class VerifyOTPRequested extends AuthEvent {
  final String otp;
  VerifyOTPRequested(this.otp);
  @override
  List<Object?> get props => [otp];
}

class LogoutRequested extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthUnauthenticated extends AuthState {}
class AuthOTPSent extends AuthState {
  final String phone;
  AuthOTPSent(this.phone);
  @override
  List<Object?> get props => [phone];
}
class AuthAuthenticated extends AuthState {
  final String userRole; // 'buyer', 'supplier', 'admin'
  AuthAuthenticated(this.userRole);
  @override
  List<Object?> get props => [userRole];
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(AuthOTPSent(event.phone));
    });

    on<VerifyOTPRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(seconds: 1));
      if (event.otp == '111111') {
        emit(AuthAuthenticated('supplier'));
      } else if (event.otp == '222222') {
        emit(AuthAuthenticated('admin'));
      } else {
        emit(AuthAuthenticated('buyer'));
      }
    });

    on<LogoutRequested>((event, emit) {
      emit(AuthUnauthenticated());
    });
  }
}
