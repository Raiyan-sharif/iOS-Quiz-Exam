//
//  QuestionBank.swift
//  iOSQuizExam
//
//  Created by raiyan sharif on 4/5/23.
//

import Foundation

struct QuestionBank{
    let questions = [
        Question(text: "A protocol declares a programmatic interface that any class may choose to implement. Protocols make it possible for two classes distantly related by inheritance to communicate with each other to accomplish a certain goal.", anwser: true),
        Question(text: "#import ensures that a file is only ever included once so that you never have a problem with recursive includes.", anwser: true),
        Question(text: "objective-C does not support method overloading, so you have to use different method names.", anwser: true),
        Question(text: "Can you write setter method for a retain property?", anwser: true),
    ]
    var numQuestion = 0
    var score = 0
    
    mutating func checkAnswer(userAnswer: Bool) -> Bool{
        if userAnswer == questions[numQuestion].anwser {
            score += 1
            return true
        }else{
            return false
        }
    }
    
    func getScore()-> Int{
        return score
    }
    
    func getTextQuestion() -> String{
        return questions[numQuestion].text
    }
    
    func getProgress()-> Float{
        let progress = Float(numQuestion + 1) / Float(questions.count)
        return progress
    }
    
    func getAnswer() -> Bool{
        return questions[numQuestion].anwser
    }
    
    mutating func nextQuestion() -> Bool{
        if numQuestion + 1 < questions.count{
            numQuestion += 1
            return false
        }
        numQuestion = 0
        return true
    }
    
}
