self 					= this
window.App 				= window.App || {}
App.rootUrl 			= 'http://localhost:3000'
App.clientId 			= '?client_id=078932198103829020278292027898289223828' // TODO: Extract client_id out
window.App.sections 	= {}
window.App.utils    	= {}
window.App.models   	= {}
window.App.pages    	= {}
App.pages.discussions 	= function() {}
App.models.discover 	= {}
App.models.discover.url = '/v1/podcasts'
App.models.updates 		= {}
App.models.updates.url 	= '/v1/updates'
