"use strict"

japaneseLearningApp = angular.module("japaneseLearningApp", ["japaneseLearningApp.services"])
japaneseLearningApp.controller "learnCtrl", [
  '$scope', 'LearnedWord',
  ($scope, LearnedWord) ->
    $scope.course = window.course
    $scope.current_question = "start"
    $scope.alert = {}
    questions = ["new", "first", "second", "third", "fourth", "fifth"]

    $scope.LearnedWord = LearnedWord.query(course_id: $scope.course.id).then((learned_words) ->
      $scope.course_items = learned_words
      set_progress(item) for item in $scope.course_items
      item.errors = 0 for item in $scope.course_items
      $scope.words = $scope.course_items
    )

    set_progress = (item) ->
      if item.isNew
        item.progress = 0
      else
        item.progress = 1

    #PREPARING QUESTION##########################################################

    $scope.next_question = ->
      $scope.current_word = choose_word()
      $scope.current_question = questions[$scope.current_word.progress]
      prepare_answers()

    choose_word = ->
      random_index = Math.floor(Math.random() * $scope.course_items.length)
      end_course() if $scope.course_items.length == 0
      $scope.course_items[random_index]

    prepare_answers = ->
      count = 4 if $scope.current_question == "first" || $scope.current_question == "second"
      count = 8 if $scope.current_question == "third" || $scope.current_question == "fourth"
      prepare_answers_array(count) 

    prepare_answers_array = (count) ->
      answers = allowed_answers()
      $scope.answers = [$scope.current_word, answers[0], answers[1], answers[2]] if count == 4

      $scope.answers = [$scope.current_word, answers[0], answers[1], answers[2],
                        answers[3], answers[4], answers[5], answers[6]] if count == 8
      if $scope.answers
        shuffle $scope.answers
        $scope.answers = $scope.answers.filter (answer) -> answer?

    allowed_answers = ->
      words = $scope.words
      words.filter (word) -> word != $scope.current_word

    #END QUESTION################################################################

    $scope.end_new = (word) ->
      $scope.alert = {}
      word.progress = 1 if word.progress == 0
      $scope.next_question()

    $scope.end_radio_question = (word, selected_answer_id) ->
      if word.id == selected_answer_id
        right_answer(word)
      else
        wrong_answer(word)

    $scope.end_text_question = (word, answer_text) ->
      if word.romaji == answer_text
        right_answer(word)
      else
        wrong_answer(word)

    right_answer = (word) ->
      $scope.selected_answer_id = null
      word.progress = word.progress + 1
      $scope.alert.message = "Right!"
      $scope.alert.class = "alert-success"
      if word.progress == 6
        end_learning(word)
        $scope.next_question()
      else
        $scope.next_question()

    wrong_answer = (word) ->
      $scope.selected_answer_id = null
      word.errors = word.errors + 1
      $scope.alert.message = "Wrong!"
      $scope.alert.class = "alert-danger"
      $scope.current_word = word
      $scope.current_question = "new"

    #END WORD LEARNING###########################################################

    end_learning = (word) ->
      set_times_repeated(word)
      set_next_learning_date(word)
      update_word(word)
      $scope.course_items = remove_word(word.id)

    set_times_repeated = (word) ->
      if word.errors < 2
        count = 2
      else if word.errors < 4
        count = 1
      else
        count = 0
      word.timesRepeated = word.timesRepeated + count
      word.completed = true if word.times_repeated >= 10

    set_next_learning_date = (word) ->
      if word.isNew
        days = 3
        word.isNew = false
      else
        days = 6

    update_word = (word) ->
      resolved = ->
        console.log "updated"
      rejected = ->
        console.log "error"
      word.update().then(resolved, rejected)

    remove_word = (id) ->
      $scope.course_items = $scope.course_items.filter (item) -> item.id isnt id

    #END COURSE##################################################################

    end_course = ->
      console.log "end"
      $scope.current_question = "end"

    #HELPERS#####################################################################

    shuffle = (a) ->
      for i in [a.length-1..1]
        j = Math.floor Math.random() * (i + 1)
        [a[i], a[j]] = [a[j], a[i]]
      a
]