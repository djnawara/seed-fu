module SeedFu

  module Writer

    class SeedOnce < Abstract
      def add_seed(hash, seed_by=nil)
        seed_by ||= config[:seed_by]
        seed_cols = seed_by.collect{|s| ":#{s}"}.join(',')
        seed_handle.syswrite("#{config[:seed_model]}.seed_once(#{seed_cols}) { |s|\n")

        hash.stringify_keys!
        hash.keys.sort.each do |key|
          value = hash[key]
          if value =~ /\n/
            seed_handle.syswrite("  s.#{key} = <<SEED_DATA_VALUE\n")
            seed_handle.syswrite("#{value}\nSEED_DATA_VALUE\n")
          else
            seed_handle.syswrite("  s.#{key} = #{value.to_s.dump}\n")
          end
        end
        seed_handle.syswrite("}\n")
        super(hash)
      end
    end
  end
end