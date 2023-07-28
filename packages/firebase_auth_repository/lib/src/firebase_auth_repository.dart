import 'dart:async';

import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth_repository/firebase_auth_repository.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

class FirebaseAuthRepository {
  FirebaseAuthRepository({
    CacheClient? cache,
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn
  }): _cache = cache ?? CacheClient(),
      _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
      _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  @visibleForTesting
  bool isWeb = kIsWeb;

  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  // realtime user data caching
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  // get current_user from cache
  User get currentUser {
    return _cache.read<User>(key: userCacheKey) ?? User.empty;
  }

  // sign-up/register
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      verifyEmail();
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  // login email & password
  Future<firebase_auth.UserCredential?> logInWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return credential;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  // email verification
  Future<void> verifyEmail() async {
    final user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      return await user.sendEmailVerification();
    }
  }

  // phone auth/phone login
  Future<String?> signInWithPhone({required String phoneNumber}) async {
    try {
      String? otp;
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (firebase_auth.PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) => throw Exception(error.message),
        codeSent: (verificationId, resendToken) async {
          otp = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {}
      );
      return otp;
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }
  
  // OTP verification
  void verifyOtp({required String verificationId, required String userOtp}) async {
    try {
      firebase_auth.PhoneAuthCredential credential = firebase_auth.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOtp
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  // login google
  Future<void> logInWithGoogle() async {
    try {
      late final firebase_auth.AuthCredential credential;
      if (isWeb) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
        );
      }
      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithGoogleFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithGoogleFailure();
    }
  }

  // logout
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut()
      ]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

// extension for firebase auth caching
extension on firebase_auth.User {
  User get toUser {
    return User(
      uid: uid,
      email: email,
      isVerified: emailVerified
    );
  }
}

// EXCEPTIONS ==================================================================
// =============================================================================
class SignUpWithEmailAndPasswordFailure implements Exception {
  const SignUpWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.'
  ]);
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.'
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.'
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          'An account already exists for that email.'
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          'Operation is not allowed.  Please contact support.'
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          'Please enter a stronger password.'
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
  final String message;
}

class LogInWithEmailAndPasswordFailure implements Exception {
  const LogInWithEmailAndPasswordFailure([
    this.message = 'An unknown exception occurred.'
  ]);
  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not valid or badly formatted.'
        );
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
          'This user has been disabled. Please contact support for help.'
        );
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email is not found, please create an account.'
        );
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
          'Incorrect password, please try again.'
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
  final String message;
}

class LogInWithGoogleFailure implements Exception {
  const LogInWithGoogleFailure([
    this.message = 'An unknown exception occurred.'
  ]);
  factory LogInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const LogInWithGoogleFailure(
          'Account exists with different credentials.'
        );
      case 'invalid-credential':
        return const LogInWithGoogleFailure(
          'The credential received is malformed or has expired.'
        );
      case 'operation-not-allowed':
        return const LogInWithGoogleFailure(
          'Operation is not allowed.  Please contact support.'
        );
      case 'user-disabled':
        return const LogInWithGoogleFailure(
          'This user has been disabled. Please contact support for help.'
        );
      case 'user-not-found':
        return const LogInWithGoogleFailure(
          'Email is not found, please create an account.'
        );
      case 'wrong-password':
        return const LogInWithGoogleFailure(
          'Incorrect password, please try again.'
        );
      case 'invalid-verification-code':
        return const LogInWithGoogleFailure(
          'The credential verification code received is invalid.'
        );
      case 'invalid-verification-id':
        return const LogInWithGoogleFailure(
          'The credential verification ID received is invalid.'
        );
      default:
        return const LogInWithGoogleFailure();
    }
  }
  final String message;
}

class LogOutFailure implements Exception {}