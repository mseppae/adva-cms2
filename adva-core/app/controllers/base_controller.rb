require 'inherited_resources'
require 'inherited_resources/helpers'
require 'simple_table'

ActionView::Base.send(:include, SimpleTable) # TODO should be in simple_table

class BaseController < InheritedResources::Base
  begin_of_association_chain :site
  tracks :resource, :resources, :site => %w(.title .name)

  layout 'default'
  helper_method :account, :site
  delegate :account, :to => :site

  def self.responder
    Adva::Responder
  end

  def site
    @site ||= Site.count == 1 ? Site.first : Site.find_by_host(request.host_with_port)
  end
end