"use strict"

angular.module("japaneseLearningApp.directives", []).directive "appVersion", [
  "version"
  (version) ->
    return (scope, elm, attrs) ->
      elm.text version
      return
]