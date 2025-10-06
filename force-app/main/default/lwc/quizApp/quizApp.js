import { LightningElement } from 'lwc';

export default class QuizApp extends LightningElement {

    selected = {};
    isSubmitted = false;
    questionsList = [
        {
        id: 'Question 1',
        question: 'Which is the capital  of India?',
        options: {
            a : 'New Delhi',
            b : 'Bangalore',
            c: 'Karnataka'
        },
        correctAnswer : 'a'
        },
        {
            id: 'Question 2',
            question: 'Which is the capital  of Australia?',
            options: {
                a : 'New Delhi',
                b : 'Melbourne',
                c: 'Karnataka'
            },
            correctAnswer : 'b'
        }

    ]

    correctAnswers = 0;
   get allnotquesAnswered() {
    return Object.keys(this.selected).length == this.questionsList.length ? false :true;
   }

   get isScoredFull(){
    return `slds-text-heading_large ${this.questionsList.length == this.correctAnswers ? 
        'slds-text-color_success' : 'slds-text-color_error'}` ;
   }

    changeHandler(event){
        const {name,value} = event.target;
        this.selected = {...this.selected , [name] : value};

    }

    submitForm(event){
        event.preventDefault();
        let correct = this.questionsList.filter(item => this.selected[item.id] == item.correctAnswer);
        console.log('Correct Answers' + JSON.stringify(correct));
        this.correctAnswers = correct.length;
        this.isSubmitted = true;

    }
    resetForm(){
        this.selected = {};
        this.correctAnswers = 0;
        this.isSubmitted = false;
    }
}