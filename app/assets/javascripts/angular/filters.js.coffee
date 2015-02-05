"use strict"

angular.module("japaneseLearningApp.filters", []).filter "interpolate", [
  "version"
  (version) ->
    return (text) ->
      String(text).replace /\%VERSION\%/g, version
]