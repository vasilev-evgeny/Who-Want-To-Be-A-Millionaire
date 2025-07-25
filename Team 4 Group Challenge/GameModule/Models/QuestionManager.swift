//
//  QuestionManager.swift
//  Team 4 Group Challenge
//
//  Created by Mariia on 24.07.2025.
//

import Foundation

protocol QuestionManagerDelegate {
    func didUpdateQuestion(question: [QuestionModal])
}

struct QuestionManager {
    let questionURL = "https://opentdb.com/api.php?amount=5&type=multiple"
    
    var delegate: QuestionManagerDelegate?
    
    func fetchQuestions(_ difficulty: String) {
        let urlString = "\(questionURL)&difficulty=\(difficulty)"
        
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let question = self.parseJSON(questionData: safeData) {
                        self.delegate?.didUpdateQuestion(question: question)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(questionData: Data) -> [QuestionModal]? {
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
    
    func convertToSimplifiedGameQuestions(from rawQuestions: [QuestionData]) -> [QuestionModal] {
        var simplifiedQuestionModal: [QuestionModal] = []
          for item in rawQuestions {
              let correct = item.correct_answer
              let incorrect = item.incorrect_answers
              let allAnswers = ([correct] + incorrect).shuffled()

              let question = QuestionModal(
                  question: item.question,
                  answers: allAnswers,
                  correctAnswer: correct
              )
              
              simplifiedQuestionModal.append(question)
            }
          
        return simplifiedQuestionModal
    }
}
