require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SeedFu::Writer::SeedOnce do
  describe "initialize" do

    def build_instance
      @seed_file_name = 'stubseed.rb'
      @output = StringIO.new
      File.expects(:new).with(@seed_file_name, 'w').returns(@output)

      SeedFu::Writer::SeedOnce.new(
        :seed_file  => @seed_file_name,
        :seed_model => SeededModel,
        :seed_by    => [:title]
      )
    end

    it "should contain a comment regarding what writer was used" do
      build_instance
      @output.string.should include_text('# Using SeedFu::Writer::SeedOnce to seed SeededModel')
    end

    it "should output a formatted seed-value" do
      writer = build_instance
      writer.add_seed(
        :title => "Peon",
        :login => "bob", 
        :first_name => "Steve"
      )
      writer.finish

      expected_seed = <<SEED_END
SeededModel.seed_once(:title) { |s|
  s.first_name = 'Steve'
  s.title = 'Peon'
  s.login = 'bob'
}
SEED_END
      @output.string.should include_text(expected_seed)
    end
  end
end