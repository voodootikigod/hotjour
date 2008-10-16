require 'service_kind'
require 'gem_jour'
require 'git_jour'
require 'app_jour'
require 'paste_jour'


class BonjourWatcher 
	# 
	attr_accessor :servicekinds
	attr_accessor :status
	attr_accessor :announcer
	# 
	# ib_outlet :detail_view
	# ib_outlet :outline_view
	# 
	def initialize()
		super
		self.servicekinds  = []
		self.status = ''
		setup_known_services
		load_rc
		self
	end

	def servicekinds
		@servicekinds
	end


	def service(name,klazz)    
		srv = ServiceKind.new(name, klazz)
		@servicekinds << srv
	end

	def browse(&b)
		self.announcer = b
		@browsers = []
		servicekinds.each do |srv|
			browser = NSNetServiceBrowser.new
			browser.delegate = self
			browser.searchForServicesOfType(srv.service_type, inDomain:"")
			@browsers << browser
		end
		return self
	end

	def refresh_listing
		self.announcer.call(self.found_services)
	end

	def netServiceBrowserWillSearch(ns)
	end

	def netServiceBrowser(nsb, didNotSearch:errorDict)
		puts "We hit a wall: #{errorDict.to_ruby.inspect}"
	end

	def netServiceBrowser(nsb, didFindService:service, moreComing:more)
		puts "Found service."
		ServiceKind.found(service)
		refresh_listing
	end

	def netServiceBrowser(nsb,didRemoveService:service,moreComing:more)
		puts "Lost service #{service.name}"
		ServiceKind.lost(service)
		self.announcer.call(self.found_services)
	end


	def found_services
		a = self.servicekinds.collect{|srv| 
			srv.children.collect{|child|
				{:name=>child.service.name, :host=>child.service.hostName, :service=>srv.name} 
			}
		}.flatten
		return a
	end


protected
	def setup_known_services
		service('pastejour', PasteJour)
		service('http'     , AppJour  )
		service('git'      , GitJour  )
		service('rubygems' , GemJour  )
	end


	def load_rc
		rcfile = "#{ENV['HOME']}/.jourrc"
		if File.exist?(rcfile)
			instance_eval(File.read(rcfile))
		end
	end
end