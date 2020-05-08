function closeForm() {
  $(".body").css("display", "none");
  $("#container").css("display", "none");
}

$(document).ready(function(){
  // Mouse Controls
  var documentWidth = document.documentElement.clientWidth;
  var documentHeight = document.documentElement.clientHeight;
  var cursor = $('#cursor');
  var cursorX = documentWidth / 2;
  var cursorY = documentHeight / 2;
  var selected = false;

  //question variables
  var questionNumber = 1;
  var count = 1;
  var userAnswer = [];
  var goodAnswer = [];
  var questionUsed = [];
  var nbQuestionToAnswer = 12; // don't forget to change the progress bar max value in html
  var nbAnswerNeeded = 9; // out of nbQuestionToAnswer
  var nbPossibleQuestions = 12; //number of questions in database questions.js
  /*
  var nbQuestionToAnswer = 10; // don't forget to change the progress bar max value in html
  var nbAnswerNeeded = 8; // out of nbQuestionToAnswer
  var nbPossibleQuestions = 15; //number of questions in database questions.js
*/

  function resetValues() {
    questionNumber = 1;
    count = 1;
    userAnswer = [];
    goodAnswer = [];
    questionUsed = [];
    nbQuestionToAnswer = 12; // don't forget to change the progress bar max value in html
    nbAnswerNeeded = 9; // out of nbQuestionToAnswer
    nbPossibleQuestions = 12; //number of questions in database questions.js
  }

  function getRandomQuestion() {
    var continuer = true;
    var random;
    while (continuer){
      continuer=false; // do not continue loop
      random = Math.floor(Math.random() * nbPossibleQuestions) ; // number of possible questions
      if(questionNumber==1){
        return random;
      }
      for(i=0; i<questionNumber-1; i++){
        if (random == questionUsed[i]) {
          continuer=true; // continue loop only if random is already used
        }
      }
    }
    questionUsed.push(random);
    count++;
    return random;
  }

  function UpdateCursorPos() {
      $('#cursor').css('left', cursorX);
      $('#cursor').css('top', cursorY);
  }

  function triggerClick(x, y) {
      var element = $(document.elementFromPoint(x, y));
      element.focus().click();
      return true;
  }

  // Partial Functions
  function closeMain() {
    $(".home").css("display", "none");
  }
  function openMain() {
    $(".home").css("display", "block");

    $('#wrong').css("display", "none");
    $(".questionnaire-container").css("display", "none");
    $(".progress-bar").css("display", "none");
    $(".resultGood").css("display", "none");
    $(".resultBad").css("display", "none");
    $('.square').removeClass("btn-complete");

  }
  function closeAll() {
    $('.home').css("display", "none");
    // $(".body").css("display", "none");
  }

 
  
  function openQuestionnaire() {

    // Display elements
    $('.home').css("display", "none");
    $(".questionnaire-container").css("display", "block");
    $(".progress-bar").css("display", "block");
    $('#wrong').css("display", "none");

    selected = false;

    // Get random questions
    var randomQuestion = getRandomQuestion();

    $("#questionNumero").html("Pregunta : " + questionNumber);
    $("#question").html(tableauQuestion[randomQuestion].question);
    $(".answerA").html(tableauQuestion[randomQuestion].propositionA);
    $(".answerB").html(tableauQuestion[randomQuestion].propositionB);
    $(".answerC").html(tableauQuestion[randomQuestion].propositionC);
    $(".answerD").html(tableauQuestion[randomQuestion].propositionD);
    $('input[name=question]').attr('checked',false);
    goodAnswer.push(tableauQuestion[randomQuestion].reponse);

    console.log(goodAnswer);
    $(".questionnaire-container .progression").val(questionNumber-1);

    
   
  }
  function openResultGood() {
    $(".resultGood").css("display", "block");
    $(".questionnaire-container").css("display", "none");
    $(".progress-bar").css("display", "none");
  }

  function openResultBad() {
    $(".resultBad").css("display", "block");
    $(".questionnaire-container").css("display", "none");
    $(".progress-bar").css("display", "none");
  }

  function openContainer() {

    resetValues(); // Al abrir el formulario reseteamos las variables

    $(".question-container").css("display", "block");
    $("#cursor").css("display", "block");
  }
  function closeContainer() {
    $(".question-container").css("display", "none");
    $("#cursor").css("display", "none");
  }
  
  // Listen for NUI Events
  window.addEventListener('message', function(event){
    var item = event.data;
    // Open & Close main gang window
    if(item.openQuestion == true) {
      openContainer();
      openMain();
    }
    if(item.openQuestion == false) {
      closeContainer();
      closeMain();
    }
    // Open sub-windows / partials
    if(item.openSection == "question") {
      //closeAll();
      console.log("CLIENT");
      openQuestionnaire();
    }
    if (item.type == "click") {
        triggerClick(cursorX - 1, cursorY - 1);
    }
  });

  $(document).mousemove(function(event) {
    cursorX = event.pageX;
    cursorY = event.pageY;
    UpdateCursorPos();
  });

  // Handle Button Presses
  $(".btnQuestion").click(function(){
      $.post('http://dmvschool/question', JSON.stringify({}));
  });
  $(".btnClose").click(function(){
      $.post('http://dmvschool/close', JSON.stringify({}));
  });
  $(".btnKick").click(function(){
      $.post('http://dmvschool/kick', JSON.stringify({}));
  });
 

 // Handle Form Submits

 $("input[name='question']").change(function(){
    selected = true;
  });


  $("#question-form").submit(function(e) {
    e.preventDefault();

    console.log(selected);

    if (selected == true) {
      if(questionNumber!=nbQuestionToAnswer){

        userAnswer.push($('input[name="question"]:checked').val());
        questionNumber++;
        
        $('#wrong').css("display", "none");
        selected = false;
  
        // Add class btn complete
        $('#square' + count).addClass("btn-complete");
  
        console.log("SELECTTT");
        openQuestionnaire(); 
      } else {
          // question 10 : comparing arrays and sending number of good answers
          userAnswer.push($('input[name="question"]:checked').val());

          var nbGoodAnswer = 0;
          for (i = 0; i < nbQuestionToAnswer; i++) {
            if (userAnswer[i] == goodAnswer[i]) {
              nbGoodAnswer++;
            }
          }
  
          // Result values
          $('.totalQ').text(nbQuestionToAnswer);
          $('.okQ').text(nbGoodAnswer);
          $('.errorQ').text(nbQuestionToAnswer - nbGoodAnswer);
  
  
  
          if(nbGoodAnswer >= nbAnswerNeeded) {
            openResultGood();
          }
          else{
            openResultBad();
          }
        }
    } else {
      $('#wrong').css("display", "block");
    }

     
    
    
    


  });
});
