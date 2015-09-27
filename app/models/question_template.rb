class QuestionTemplate < ActiveRecord::Base
  QUESTIONS = [
    "If your mentee have to work on a simple feature of your project, how likely you think he/she can make it in time?",
    "On a scale from 1 to 10, how much do you think his/her understanding of his/her current project is?",
    "Imagine a situation that, your mentee is assigned to a client project tomorrow, how confident are you that he/she can make that client happy?",
    "How much do you agree with me if I say that your mentee is competence in the technology that he/she is working on currently?",
    "On a scale of 1>10 (1 being completely useless and 10 being fabulous), how do you find your mentee?",
    "If your mentee would leave your company tomorrow, how much would you like to have his/her again in your team?",
    "If the company is in a crisis, and you have to fire someone, how likely he/she will stay?",
    'The company is so lucky to have you onboard. I’m very happy to work with you.” How likely will you say that to your mentee now?',
    "On a scale of 1-10, how would you rate your mentee's commitment to getting things done today? ",
    "How effective is HIS/HER in tackling a technical challenges on a scale of 1-10?"
  ]
end
