import 'package:equatable/equatable.dart';
import 'package:firebase_realtimedb_repository/firebase_realtimedb_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

import '../../../utils/utils.dart';

part 'transaction_history_event.dart';
part 'transaction_history_state.dart';

class TransactionHistoryBloc extends Bloc<TransactionHistoryEvent, TransactionHistoryState> {
  TransactionHistoryBloc({
    required FirebaseRealtimeDBRepository firebaseRepository,
  }) : _firebaseRepository = firebaseRepository,
  super(const TransactionHistoryState(status: Status.loading)) {
    on<TransactionHistoryLoaded>(_onTransactionHistoryLoaded);
    on<SearchTextFieldChanged>(_onSearchTextFieldChanged);
  }
  final FirebaseRealtimeDBRepository _firebaseRepository;

  void _onTransactionHistoryLoaded(TransactionHistoryLoaded event,  Emitter<TransactionHistoryState> emit) async {
    emit(state.copyWith(status: Status.loading));
    const limit = 20;
    await emit.forEach(
      _firebaseRepository.getTransactionHistoryListStream(event.accountID, limit + event.limit), // stream data from firebase database
      onData: (data) {
        List<TransactionHistory> filteredTransactions = data; // leave this non final
        final query = event.searchQuery.trim().toLowerCase(); // case insensitive
        final filter = event.filter.trim().toLowerCase(); // case insensitive

        if (event.filter.isNotEmpty) {
          if (filter == 'newest') {
            filteredTransactions.sort((a, b) => b.timeStamp!.compareTo(a.timeStamp!));
          } else if (filter == 'oldest') {
            filteredTransactions.sort((a, b) => a.timeStamp!.compareTo(b.timeStamp!));
          } else {
            filteredTransactions = filteredTransactions.where((trans) {
              return trans.accountType.trim().toLowerCase().contains(filter);
            }).toList();
          }
        }
        
        if (event.searchQuery.isNotEmpty) {
          filteredTransactions = filteredTransactions.where((trans) {
            return trans.details.toLowerCase().contains(query);
          }).toList();
        }
        
        if (filteredTransactions.isNotEmpty) {
          return state.copyWith(status: Status.success, transactionList: filteredTransactions);
        } else {
          return state.copyWith(status: Status.error, message: 'empty');
        }
      }, onError: (error, stackTrace) {
        return state.copyWith(status: Status.error, message: error.toString());
      }
    );
  }

  void _onSearchTextFieldChanged(SearchTextFieldChanged event, Emitter<TransactionHistoryState> emit) {
    final search = Search.dirty(event.searchQuery);
    emit(state.copyWith(searchQuery: search));
  }
}



// class TransactionHistoryBloc extends Bloc<TransactionHistoryEvent, TransactionHistoryState> {
//   TransactionHistoryBloc({
//     required FirebaseRealtimeDBRepository firebaseRepository,
//   }) : _realtimeDBRepository = firebaseRepository,
//   super(const TransactionHistoryState(status: Status.loading)) {
//     on<TransactionHistoryLoaded>(_onTransactionHistoryLoaded);
//     on<TransactionHistoryUpdated>(_onTransactionHistoryUpdated);
//     on<SearchTextFieldChanged>(_onSearchTextFieldChanged);
//   }
//   final FirebaseRealtimeDBRepository _realtimeDBRepository;
//   StreamSubscription<List<TransactionHistory>>? _streamSubscription;

//   void _onTransactionHistoryLoaded(TransactionHistoryLoaded event,  Emitter<TransactionHistoryState> emit) async {
//     _streamSubscription?.cancel;
//     _streamSubscription = _realtimeDBRepository.getTransactionHistoryListStream(event.account)
//     .listen((transactions) async {
//       List<TransactionHistory> filteredTransactions = transactions;
//       final query = event.searchQuery.trim().toLowerCase(); // case insensitive
//       final filter = event.filter.trim().toLowerCase(); // case insensitive

//       if (event.filter.isNotEmpty) {
//         if (filter == 'newest') {
//           filteredTransactions.sort((a, b) => b.timeStamp.compareTo(a.timeStamp));
//         } else if (filter == 'oldest') {
//           filteredTransactions.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
//         } else {
//           filteredTransactions = filteredTransactions.where((trans) {
//             return trans.accountType.trim().toLowerCase().contains(filter);
//           }).toList();
//         }
//       }
//       if (event.searchQuery.isNotEmpty) {
//         filteredTransactions = filteredTransactions.where((trans) {
//           return trans.details.toLowerCase().contains(query);
//         }).toList();
//       }

//       add(TransactionHistoryUpdated(filteredTransactions));
//     });
//   }

//   void _onTransactionHistoryUpdated(TransactionHistoryUpdated event, Emitter<TransactionHistoryState> emit) async {
//     if (event.transactions.isNotEmpty) {
//       emit(state.copyWith(status: Status.success, transactions: event.transactions));
//     } else {
//       emit(state.copyWith(status: Status.error, message: "empty"));
//     }
//   }

//   void _onSearchTextFieldChanged(SearchTextFieldChanged event, Emitter<TransactionHistoryState> emit) {
//     final search = Search.dirty(event.searchQuery);
//     emit(state.copyWith(searchQuery: search));
//   }

//   @override
//   Future<void> close() {
//     _streamSubscription?.cancel;
//     return super.close();
//   }
// }