module HashExt
  def to_s
    strings = []
    self.each do |k,v|
      if v.kind_of?(Hash)
        v.extend(HashExt)
        strings << "{ :#{k} => { #{v} } }"
      else
        strings << ":#{k} => %{#{v}}"
      end
    end
    strings.join(", ")
  end
end
