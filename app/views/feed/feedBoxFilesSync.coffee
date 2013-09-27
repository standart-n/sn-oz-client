
Sync = 										require('Sync')

module.exports = Sync.extend


	startSync: () ->

		if this.files?

			this.adding()

			this.removing()


	adding: () ->

		this.files.on 'add', (file) =>

			if this.isFirst(this.files,file) 
				this.prepend(file) 

			else 
				this.append(file)


	removing: () ->

		# this.files.on 'remove', (file) =>

		# 	$file = 	this.$el.find("[data-file-id=\"#{file.get('id')}\"]")

		# 	$file.remove()

