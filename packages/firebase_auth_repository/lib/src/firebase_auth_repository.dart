import 'dart:async';

import 'package:cache/cache.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import '../firebase_auth_repository.dart';

class FirebaseAuthRepository {
  FirebaseAuthRepository({
    CacheClient? cache,
    auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn
  }): _cache = cache ?? CacheClient(),
      _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance,
      _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final CacheClient _cache;
  final auth.FirebaseAuth _firebaseAuth;
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

  // GET current_user FROM cache
  User get currentUser => _cache.read<User>(key: userCacheKey) ?? User.empty;

  // SIGNUP WITH EMAIL & PASSWORD
  Future<auth.UserCredential?> signUpWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
    } on auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationFailure.fromAuthException(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  // SIGNIN WITH EMAIL & PASSWORD
  Future<auth.UserCredential?> logInWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
    } on auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationFailure.fromAuthException(e);
    } catch(e) {
      throw Exception(e); 
    }
  }

  // EMAIL AND PASSWORD CREDENTIAL
  auth.AuthCredential emailAndPasswordAuthCredential({
    required String email,
    required String password
  }) {
    try {
      return auth.EmailAuthProvider.credential(email: email, password: password);
    } on auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationFailure.fromAuthException(e);
    } catch (e) {
      throw Exception(e);
    }
  }
 
  // PHONE AUTH
  Future<void> phoneAuthentication({
    required String phoneNumber,
    required void Function(String, int?) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
    required void Function(auth.PhoneAuthCredential) verificationCompleted,
    required void Function(auth.FirebaseAuthException) verificationFailed,
    int? forceResendingToken,
    Duration timeout = const Duration(seconds: 60),
    auth.PhoneMultiFactorInfo? multiFactorInfo,
    auth.MultiFactorSession? multiFactorSession
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      verificationCompleted: verificationCompleted,
      codeSent: codeSent,
      verificationFailed: verificationFailed,
      forceResendingToken: forceResendingToken,
      timeout: timeout,
      multiFactorInfo: multiFactorInfo,
      multiFactorSession: multiFactorSession
    );
  }

  // LINK WITH AUTH CREDENTIAL
  Future<auth.UserCredential?> linkWithCredential({
    required auth.AuthCredential authCredential,
  }) async {
    try {
      return await _firebaseAuth.currentUser!.linkWithCredential(authCredential);
    } on auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationFailure.fromAuthException(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  // SIGNIN WITH AUTH CREDENTIAL
  Future<auth.UserCredential?> signInWithAuthCredential({
    required auth.AuthCredential authCredential,
  }) async {
    try {
      return await _firebaseAuth.signInWithCredential(authCredential);
    } on auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationFailure.fromAuthException(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  // PHONE AUTH CREDENTIAL
  auth.PhoneAuthCredential createPhoneAuthCredential({
    required String verificationId,
    required String smsCode
  }) {
    try {
      return auth.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode
      );
    } on auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationFailure.fromAuthException(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  // MFA INITIATE
  Future<void> multiFactorAuthInitiate({
    String? phoneNumber,
    required void Function(String, int?) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
    required void Function(auth.PhoneAuthCredential) verificationCompleted,
    required void Function(auth.FirebaseAuthException) verificationFailed
  }) async {
    try {
      final session = await _firebaseAuth.currentUser!.multiFactor.getSession();
      await _firebaseAuth.verifyPhoneNumber(
        multiFactorSession: session,
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        verificationFailed: verificationFailed,
      );
    } on auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationFailure.fromAuthException(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  // MFA ENROLL
  Future<void> multiFactorAuthEnroll({
    required auth.PhoneAuthCredential phoneAuthCredential,
  }) async {
    try {
      await _firebaseAuth.currentUser!.multiFactor.enroll(
        auth.PhoneMultiFactorGenerator.getAssertion(phoneAuthCredential)
      );
    } on auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationFailure.fromAuthException(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  // MFA VERIFIER
  Future<void> multiFactorAuthHandler({
    required void Function(String, int?) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
    required auth.FirebaseAuthMultiFactorException exception,
    required void Function(auth.PhoneAuthCredential) verificationCompleted,
    required void Function(auth.FirebaseAuthException) verificationFailed
  }) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        multiFactorSession: exception.resolver.session,
        verificationCompleted: verificationCompleted,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        codeSent: codeSent,
        verificationFailed: verificationFailed
      );
    } on auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationFailure.fromAuthException(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  // MFA SIGNIN
  Future<auth.UserCredential?> multiFactorAuthSignIn({
    required auth.FirebaseAuthMultiFactorException exception,
    required auth.PhoneAuthCredential phoneAuthCredential,
  }) async {
    try {
      return await exception.resolver.resolveSignIn(
        auth.PhoneMultiFactorGenerator.getAssertion(phoneAuthCredential)
      );
    } on auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationFailure.fromAuthException(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  // LOGIN WITH GOOGLE
  Future<void> logInWithGoogle() async {
    try {
      late final auth.AuthCredential credential;
      if (isWeb) {
        final googleProvider = auth.GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
        );
      }
      await _firebaseAuth.signInWithCredential(credential);
    } on auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationFailure.fromAuthException(e);
    } catch(e) {
      throw Exception(e); 
    }
  }

  // EMAIL VERIFY
  Future<void> verifyEmail() async {
    final user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      return await user.sendEmailVerification();
    }
  }

  // REQUEST RESET PASSWORD
  Future<void> requestResetPassword({
    required String email
  }) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email)
      .catchError((e) => throw Exception(e));
    } on auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationFailure.fromAuthException(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<auth.UserCredential?> reauthenticateUserWithCredential({
    required String password,
    required String email
  }) async {
    try {
      return await _firebaseAuth.currentUser?.reauthenticateWithCredential(
        auth.EmailAuthProvider.credential(email: email, password: password)
      );
    } on auth.FirebaseAuthException catch (e) {
      throw FirebaseAuthenticationFailure.fromAuthException(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  // 

  // LOGOUT
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

// EXTENTION FOR USER CACHING
extension on auth.User {
  User get toUser {
    return User(
      uid: uid,
      email: email,
      isVerified: emailVerified
    );
  }
}

class FirebaseAuthenticationFailure implements Exception {
  const FirebaseAuthenticationFailure([
    this.message = 'An error occurred. Please try again later.',
  ]);

  factory FirebaseAuthenticationFailure.fromAuthException(auth.FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return const FirebaseAuthenticationFailure(
          'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const FirebaseAuthenticationFailure(
          'This user has been disabled. Please contact support for assistance.',
        );
      case 'user-not-found':
        return const FirebaseAuthenticationFailure(
          'User not found, please create an account.',
        );
      case 'wrong-password':
        return const FirebaseAuthenticationFailure(
          'Incorrect password, please try again.',
        );
      case 'weak-password':
        return const FirebaseAuthenticationFailure(
          'The password provided is too weak.',
        );
      case 'email-already-in-use':
        return const FirebaseAuthenticationFailure(
          'An account already exists for that email.',
        );
      case 'operation-not-allowed':
        return const FirebaseAuthenticationFailure(
          'Operation is not allowed. Please contact support.',
        );
      case 'user-mismatch':
        return const FirebaseAuthenticationFailure(
          'User mismatch. Please verify your credentials and try again.',
        );
      case 'invalid-credential':
        return const FirebaseAuthenticationFailure(
          'Invalid email or password. Please try again.',
        );
      case 'invalid-verification-code':
        return const FirebaseAuthenticationFailure(
          'Invalid verification code. Please double-check and try again.',
        );
      case 'invalid-verification-id':
        return const FirebaseAuthenticationFailure(
          'Invalid verification ID. Please try again.',
        );
      case 'account-exists-with-different-credential':
        return const FirebaseAuthenticationFailure(
          'An account with different credentials already exists. Please sign in using those credentials or contact support for assistance.',
        );
      case 'invalid-phone-number':
        return const FirebaseAuthenticationFailure(
          'The phone number entered is invalid!',
        );
      case 'provider-already-linked':
        return const FirebaseAuthenticationFailure(
          'The provider has already been linked to the user.'
        );
      case 'captcha-check-failed':
        return const FirebaseAuthenticationFailure(
          'The reCAPTCHA response token was invalid, expired, or if this method was called from a non-whitelisted domain.'
        );
      case 'quota-exceeded':
        return const FirebaseAuthenticationFailure(
          'The SMS quota has been exceeded.'
        );
      default:
        return e.message != null && e.message!.isNotEmpty
        ? FirebaseAuthenticationFailure(e.message!)
        : const FirebaseAuthenticationFailure();
    }
  }
  final String message;
}

class LogOutFailure implements Exception {}