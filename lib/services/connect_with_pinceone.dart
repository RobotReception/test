import 'dart:convert';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
import 'package:pinecone/pinecone.dart';

class FindMatching {
  final client = PineconeClient(
    apiKey: 'eb457224-95f8-4881-a32d-b28bcf8adb23',
  );
  final embeddings = OpenAIEmbeddings(
      apiKey: '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');

  Future<String> getMatching(String arguments) async {
    final res = await embeddings.embedQuery(arguments);

    QueryResponse queryResponse = await client.queryVectors(
      indexName: 'fir',
      projectId: 'd655552',
      environment: 'us-west4-gcp-free',
      request: QueryRequest(
        vector: res,
      ),
    );

    return gettext([
      queryResponse.matches[0].id,
      queryResponse.matches[2].id,
      queryResponse.matches[1].id,
  
    ]);
  }

  Future<String> gettext(var id) async {
    FetchResponse fetchResponse = await client.fetchVectors(
      indexName: 'fir',
      projectId: 'd655552',
      environment: 'us-west4-gcp-free',
      ids: id,
    );
    var res_id = fetchResponse.vectors.keys.toList();
    String text = '';
    for (int i = 0; i < res_id.length; i++) {
      text += utf8.decode(
          fetchResponse.vectors[res_id[i]]?.metadata?['text'].codeUnits);
    }
    return text;
  }

  Future<String> respons(String query) async {
    final chat = ChatOpenAI(
        apiKey: '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',
        model: "gpt-3.5-turbo-16k-0613",
        temperature: 0.8);

    final match_context = await getMatching(query);
    print(match_context);
    const template =
        'أجب على السؤال بأكبر قدر ممكن من الصدق باستخدام السياق المتوفر هذا النص كامل   {input_language} ، وأريد الإجابة كلها باللغة العربية وإذا لم تكن الإجابة موجودة في النص أدناه ،  " اجب بطريقة مخصرة من عندك" واذا تم سؤال من انت قول انا روبوت دردشة معتمد على بيانات سابقة تم تدريبي عليها';
    final systemMessagePrompt =
        SystemChatMessagePromptTemplate.fromTemplate(template);
    const humanTemplate = '{text}';
    final humanMessagePrompt =
        HumanChatMessagePromptTemplate.fromTemplate(humanTemplate);
    final chatPrompt = ChatPromptTemplate.fromPromptMessages(
        [systemMessagePrompt, humanMessagePrompt]);
    final formattedPrompt = chatPrompt.formatPrompt({
      'text': '$query',
      'input_language': '$match_context',
    }).toChatMessages();

    final chatRes = await chat(formattedPrompt);
    return chatRes.content;
  }
}

