#= require jquery
#= require jquery_ujs
#= require foundation
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require windsong

# for more details see: http://emberjs.com/guides/application/
window.Windsong = Ember.Application.create()

# Document Ready
jQuery ->
  $(document).foundation()