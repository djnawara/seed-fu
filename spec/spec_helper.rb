plugin_spec_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require "rubygems"
require "active_record"
require "seed-fu"

ActiveRecord::Base.establish_connection({
  :adapter => :mysql,
  :host => "localhost",
  :user => "root",
  :database => "seed_fu_test"
})
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")

require File.join(plugin_spec_dir, '../lib/seed-fu/writer')

class SeededModel < ActiveRecord::Base
  validates_presence_of :title
end

Spec::Runner.configure do |config|
  config.before do
    SeededModel.delete_all
  end
end
