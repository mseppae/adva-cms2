require 'adva'

module Adva
  class Static
    module Rack
      PURGE_HEADER = 'rack-cache.purge'
      STORE_HEADER = 'rack-static.store'

      autoload :Request, 'adva/static/rack/request'
      autoload :Export,  'adva/static/rack/export'
      autoload :Static,  'adva/static/rack/static'
      autoload :Watch, 'adva/static/rack/watch'
    end
  end
end
