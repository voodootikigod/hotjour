class ServiceKind
  
	attr_accessor :name
	attr_accessor :klass
	attr_accessor :children
	
	def leaf; false end
	def self.service_lookup
		@service_lookup ||= {}	    
	end
	
	def initialize(name, clazz)
		# super
		puts "service kind #{name} with #{clazz}"
		self.name  = name
		self.klass = clazz
		self.children = []
		self.class.service_lookup[name] = self
		@jours = {}
		self
	end
  
  def text
    begin
      @klass.service_name
    rescue
      @name
    end.upcase
  end
  
  def service_key(service)
	  service.name + service.type()
	end
	
	def self.service_basename(service)
	  service.type[/_([^\.]+)\._tcp/,1]
  end
  
  def service_type
    "_#{name}._tcp"
  end
  
  def self.resolve_path(sc_index,jour_index)
    
  end
  
  def self.found(service)
    puts "found service #{service.name} #{service.type}"
    
    if srv = service_lookup[service_basename(service)]
      srv.found(service)
    end
  end
  
  def found(service)
    puts "lets go"

    if jour = klass.newWithService(service)
      service.delegate = jour
      service.resolveWithTimeout(60)

      @children << jour
      @jours[service_key(service)] = jour
    end
  end
  
  def self.lost(service)
    srv.lost(service) if srv = service_lookup[service_basename(service)]
  end
  
  def lost(service)
    @children.delete(jour) if jour = @jours[service_key(service)]
  end
end
