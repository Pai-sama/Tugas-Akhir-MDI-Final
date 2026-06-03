import 'dart:io';
import 'lib/data/app_data_id.dart';
import 'lib/data/app_data_en.dart';
import 'lib/models/village.dart';
import 'lib/models/quiz.dart';
import 'dart:math';

void main() {
  StringBuffer out = StringBuffer();
  out.writeln("import '../models/quiz.dart';");
  out.writeln();

  // Generate ID Village Quizzes
  out.writeln('final Map<String, List<QuizQuestion>> villageQuizzesId = {');
  for (var v in villagesId) {
    out.writeln("  '${v.id}': [");
    out.write(generateVillageQuestions(v, true));
    out.writeln("  ],");
  }
  out.writeln('};');
  out.writeln();

  // Generate EN Village Quizzes
  out.writeln('final Map<String, List<QuizQuestion>> villageQuizzesEn = {');
  for (var v in villagesEn) {
    out.writeln("  '${v.id}': [");
    out.write(generateVillageQuestions(v, false));
    out.writeln("  ],");
  }
  out.writeln('};');
  out.writeln();

  // Generate Global Quiz ID
  out.writeln('final List<QuizQuestion> globalQuizId = [');
  out.write(generateGlobalQuiz(villagesId, true));
  out.writeln('];');
  out.writeln();

  // Generate Global Quiz EN
  out.writeln('final List<QuizQuestion> globalQuizEn = [');
  out.write(generateGlobalQuiz(villagesEn, false));
  out.writeln('];');
  out.writeln();

  File('lib/data/quiz_data.dart').writeAsStringSync(out.toString());
  print('quiz_data.dart generated successfully.');
}

String generateVillageQuestions(Village v, bool isId) {
  StringBuffer sb = StringBuffer();
  
  // Create exactly 10 questions based on village properties
  var rand = Random(int.parse(v.id));

  // Q1: Location
  String q1 = isId ? 'Dimanakah lokasi dari ${v.name}?' : 'Where is ${v.name} located?';
  String q1Exp = isId ? '${v.name} berlokasi di ${v.location}.' : '${v.name} is located in ${v.location}.';
  sb.write(createQuestion(v, 'q1_${v.id}', q1, v.location, ['Jakarta', 'Surabaya', 'Bandung'], q1Exp));

  // Q2: Province
  String q2 = isId ? 'Provinsi apa yang menjadi tempat berdirinya ${v.name}?' : 'In which province is ${v.name} located?';
  String q2Exp = isId ? '${v.name} berada di provinsi ${v.province}.' : '${v.name} is in the province of ${v.province}.';
  sb.write(createQuestion(v, 'q2_${v.id}', q2, v.province, ['Jawa Timur', 'Sumatera Barat', 'Papua'], q2Exp));

  // Q3: Category
  String q3 = isId ? 'Termasuk dalam kategori apakah ${v.name}?' : 'What category does ${v.name} belong to?';
  String q3Exp = isId ? 'Kategori dari desa ini adalah ${v.category}.' : 'The category of this village is ${v.category}.';
  sb.write(createQuestion(v, 'q3_${v.id}', q3, v.category, ['Wisata Modern', 'Pusat Perbelanjaan', 'Kawasan Industri'], q3Exp));

  // Q4: Rating
  String q4 = isId ? 'Berapa rating dari ${v.name}?' : 'What is the rating of ${v.name}?';
  String q4Exp = isId ? 'Rating desa ini adalah ${v.rating}.' : 'The rating of this village is ${v.rating}.';
  sb.write(createQuestion(v, 'q4_${v.id}', q4, v.rating.toString(), ['3.0', '2.5', '1.0'], q4Exp));

  // Q5: Tags
  String q5 = isId ? 'Salah satu daya tarik (tag) dari ${v.name} adalah...' : 'One of the attractions (tags) of ${v.name} is...';
  String q5Ans = v.tags.isNotEmpty ? v.tags.first : 'Tidak ada';
  String q5Exp = isId ? 'Desa ini sangat dikenal dengan $q5Ans.' : 'This village is well-known for $q5Ans.';
  sb.write(createQuestion(v, 'q5_${v.id}', q5, q5Ans, ['Pantai', 'Gedung Pencakar Langit', 'Jalan Tol'], q5Exp));


  return sb.toString();
}

String createQuestion(Village v, String qid, String question, String correctAns, List<String> wrongAns, String exp) {
  var options = [correctAns, ...wrongAns];
  options.shuffle(Random(question.hashCode));
  int correctIdx = options.indexOf(correctAns);

  return """
    QuizQuestion(
      id: '$qid',
      question: '${escapeString(question)}',
      imagePath: '${escapeString(v.imagePath)}',
      options: [
        '${escapeString(options[0])}',
        '${escapeString(options[1])}',
        '${escapeString(options[2])}',
        '${escapeString(options[3])}',
      ],
      correctOptionIndex: $correctIdx,
      explanation: '${escapeString(exp)}',
    ),
""";
}

String generateGlobalQuiz(List<Village> villages, bool isId) {
  StringBuffer sb = StringBuffer();
  // Generate 20 questions, take 1 from 20 distinct villages
  // We have 21 villages, so we'll take the first 20.
  for (int i = 0; i < 20 && i < villages.length; i++) {
    var v = villages[i];
    String q = isId ? 'Provinsi manakah yang menjadi lokasi dari ${v.name}?' : 'In which province is ${v.name} located?';
    String exp = isId ? '${v.name} berada di ${v.province}.' : '${v.name} is in ${v.province}.';
    sb.write(createQuestion(v, 'global_$i', q, v.province, ['Jawa Timur', 'Sumatera Barat', 'Papua'], exp));
  }
  return sb.toString();
}

String escapeString(String s) {
  return s.replaceAll("'", "\\'").replaceAll("\\n", " ").replaceAll("\n", " ");
}
