Windsong.PostsRoute = Ember.Route.extend({
  model: ->
    Windsong.User.find()
})