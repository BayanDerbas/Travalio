import 'package:bloc/bloc.dart';
import '../../../../core/networks/failures.dart';
import '../../domain/usecases/auth_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;

  AuthBloc({required this.registerUseCase,required this.loginUseCase}) : super(const AuthState()) {
    on<AuthEmailChanged>((event, emit) =>
        emit(state.copyWith(email: event.email)));

    on<AuthPasswordChanged>((event, emit) =>
        emit(state.copyWith(password: event.password)));

    on<AuthFullNameChanged>((event, emit) =>
        emit(state.copyWith(fullName: event.name)));

    on<AuthBirthDateChanged>((event, emit) =>
        emit(state.copyWith(birthDate: event.birthDate)));

    on<AuthTogglePasswordVisibility>((event, emit) =>
        emit(state.copyWith(obscurePassword: !state.obscurePassword)));

    on<AuthToggleConfirmPasswordVisibility>((event, emit) =>
        emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword)));

    on<AuthUsernameChanged>((event, emit) =>
        emit(state.copyWith(username: event.username)));

    on<AuthSubmit>(_onSubmit);
  }

  Future<void> _onSubmit(AuthSubmit event, Emitter<AuthState> emit) async {
    print("🔔 _onSubmit triggered, isLogin: ${event.isLogin}");

    if (!event.isLogin && !isValidEmail(state.email)) {
      emit(state.copyWith(
        failure: serverFailure("البريد الإلكتروني غير صالح"),
        isSubmitting: false,
        isSuccess: false,
        isLoginSuccess: event.isLogin,
      ));
      return;
    }

    emit(state.copyWith(isSubmitting: true, failure: null, isSuccess: false));

    if (event.isLogin) {
      print("🔑 Starting login process");
      final body = {
        'username': state.username,
        'password': state.password,
      };

      print('🔐 Sending login request: $body');

      final result = await loginUseCase(body);

      result.fold(
            (failure) {
          print('❌ Login failed: ${failure.err_message}');
          emit(state.copyWith(
            isSubmitting: false,
            failure: failure,
            isSuccess: false,
            isLoginSuccess: true, // تأكد إن القيمة صحيحة حتى في الفشل
          ));
        },
            (user) {
          print('✅ Login success: ${user.toString()}');
          emit(state.copyWith(
            isSubmitting: false,
            user: user,
            isSuccess: true,
            failure: null,
            isLoginSuccess: true, // حدّث isLoginSuccess لتسجيل الدخول
          ));
        },
      );

      print("🔑 Finished login process");
    } else {
      print("📝 Starting register process");

      final body = event.body ?? {
        'username': state.email.split('@')[0],
        'email': state.email,
        'password': state.password,
        'first_name': state.fullName.split(' ').first,
        'last_name': state.fullName.split(' ').length > 1
            ? state.fullName.split(' ').last
            : '',
      };

      print('📤 Body to Register: $body');

      final result = await registerUseCase(body);
      result.fold(
            (failure) {
          print('❌ Register failed: ${failure.err_message}');
          emit(state.copyWith(
            isSubmitting: false,
            failure: failure,
            isSuccess: false,
            isLoginSuccess: false,
          ));
        },
            (user) {
          print('✅ Register success: ${user.toString()}');
          emit(state.copyWith(
            isSubmitting: false,
            user: user,
            isSuccess: true,
            failure: null,
            isLoginSuccess: false,
          ));
        },
      );

      print("📝 Finished register process");
    }
  }
}
bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

bool isStrongPassword(String password) {
  // Password at least 8 chars, contains upper, lower, digit
  final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$');
  return passwordRegex.hasMatch(password);
}