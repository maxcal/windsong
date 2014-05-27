#= require jquery
#= require jquery_ujs
#= require foundation
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require windsong
#= require_tree ./

# for more details see: http://emberjs.com/guides/application/
@Windsong = Ember.Application.create()

# Document Ready
jQuery ->
  $(document).foundation()