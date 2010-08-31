require 'adva'
require 'globalize'

module Adva
  class Cnet < ::Rails::Engine
    autoload :Connection,  'adva/cnet/connection'
    autoload :Connections, 'adva/cnet/connections'
    autoload :Downloader,  'adva/cnet/downloader'
    autoload :Extractor,   'adva/cnet/extractor'
    autoload :Finalizer,   'adva/cnet/finalizer'
    autoload :Importer,    'adva/cnet/importer'
    autoload :Logger,      'adva/cnet/logger'
    autoload :Fixtures,    'adva/cnet/fixtures'
    autoload :Prepare,     'adva/cnet/prepare'
    autoload :Sql,         'adva/cnet/sql'

    include Adva::Engine

    class << self
      def normalize_path(path)
        path.to_s.include?('/') ? path : root.join("db/cnet/#{path}")
      end
    end
  end
end