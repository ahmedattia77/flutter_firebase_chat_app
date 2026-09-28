part of 'chat_cubit.dart';

@immutable
sealed class ChatState {
  const ChatState();
}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatSuccess extends ChatState {
  final List<MessageModel> messages;

  const ChatSuccess(this.messages);
}

final class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);
}
