
class FaqModel{
  static const QUESTION = 'question';
  static const ANSWER = 'answer';

  String _question;
  String _answer;

  String get question => _question;
  String get answer => _answer;

  FaqModel.fromJson(Map<String, dynamic> data) {
    _question = data[QUESTION];
    _answer = data[ANSWER];
  }
}