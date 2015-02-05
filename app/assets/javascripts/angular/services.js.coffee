"use strict"

angular.module "japaneseLearningApp.services", ["rails"]
angular.module("japaneseLearningApp.services").factory "LearnedWord", [
  "railsResourceFactory"
  (railsResourceFactory) ->
    return railsResourceFactory(
      url: "/learned_words"
      name: "learned_word"
    )
]