require File.dirname(__FILE__) + '/../../../../spec/spec_helper'

plugin_spec_dir = File.dirname(__FILE__)
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")

require File.join(plugin_spec_dir, '../lib/seed-fu/writer')

class SeededModel < ActiveRecord::Base
  validates_presence_of :title
end