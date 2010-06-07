require File.expand_path('../../test_helper', __FILE__)
require 'site'
require 'section'

class SiteTest < Test::Unit::TestCase
  attr_reader :site_params
  
  def setup
    @site_params = {
      :name  => 'Site 1',
      :title => 'Site title',
      :host  => 'localhost:3000',
      :sections_attributes => [ { :type => 'Page', :title => 'Home' } ]
    }
  end
  
  test "site creation" do
    assert Site.create(site_params).valid?
  end

  test "site accepts nested attributes for :section" do
    assert !Site.create(site_params).sections.first.new_record?
  end

  test "site validates presence of :name" do
    site_params.delete(:name)
    assert_equal "can't be blank", Site.create(site_params).errors.values.flatten.first
  end

  test "site validates presence of :title" do
    site_params.delete(:title)
    assert_equal "can't be blank", Site.create(site_params).errors.values.flatten.first
  end

  test "site validates presence of :host" do
    site_params.delete(:host)
    assert_equal "can't be blank", Site.create(site_params).errors.values.flatten.first
  end
end