import Foundation

struct QuestionManager {
    let questionURL = "https://opentdb.com/api.php?amount=5&type=multiple"
    
    func fetchQuestions(_ difficulty: String, completion: @escaping ([Question]) -> Void) {
        let urlString = "\(questionURL)&difficulty=\(difficulty)"
        performRequest(urlString: urlString, completion: completion)
    }
    
    private func performRequest(urlString: String, completion: @escaping ([Question]) -> Void) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    completion([])
                    return
                }
                
                if let safeData = data {
                    if let question = self.parseJSON(questionData: safeData) {
                        completion(question)
                    } else {
                        completion([])
                    }
                } else {
                    completion([])
                }
            }
            
            task.resume()
        } else {
            completion([])
        }
    }
    
    private func parseJSON(questionData: Data) -> [Question]? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(APIResponse.self, from: questionData)
            let rawQuestions = decodedData.results
            let simplifiedQuestions = convertToSimplifiedGameQuestions(from: rawQuestions)
            return simplifiedQuestions
        } catch {
            print(error)
            return nil
        }
    }
    
    private func convertToSimplifiedGameQuestions(from rawQuestions: [QuestionData]) -> [Question] {
        var simplifiedQuestionModal: [Question] = []
        for item in rawQuestions {
            let correct = item.correct_answer.htmlDecoded
            let incorrect = item.incorrect_answers.map { $0.htmlDecoded }
            let allAnswers = ([correct] + incorrect).shuffled()

            let question = Question(
                question: item.question.htmlDecoded,
                answers: allAnswers,
                correctAnswer: correct
            )

            simplifiedQuestionModal.append(question)
        }
        return simplifiedQuestionModal
    }

}

extension String {
    var htmlDecoded: String {
        guard let data = self.data(using: .utf8) else { return self }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html
        ]
        return (try? NSAttributedString(data: data, options: options, documentAttributes: nil))?.string ?? self
    }
}
