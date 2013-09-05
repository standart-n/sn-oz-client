
require('jquery')

EjsEngine = 	require('EjsEngine')

module.exports = EjsEngine.extend

	adding: (collection) ->

		collection.on 'add', (model) =>

			if this.isFirst(collection,model) 
				this.prepend(model) 

			else 
				this.append(model)


	isLast: (collection, model) ->

		last = collection.last()

		if last? then last.get('id') is model.get('id') else true


	isFirst: (collection, model) ->

		firs = collection.first()

		if firs? then firs.get('id') is model.get('id') else true


	append: (model) ->

		this.$el.append this.ejs model.toJSON()


	prepend: (model) ->

		this.$el.prepend this.ejs model.toJSON()


