module Utils
  class Parser
    def self.parse(value)
      return [] unless value
      value.split(',').flat_map do |part|
        if part.include?('-')
          start_val, end_val = part.split('-').map(&:strip).map { |v| normalize(v) }
          (start_val.to_i..end_val.to_i).to_a
        else
          [normalize(part.strip)]
        end
      end.compact
    end

    def self.pick(values)
      values.is_a?(Array) ? values.sample : values
    end

    def self.normalize(val)
      return nil unless val
      case val
      when /^(\d+(?:\.\d+)?)$/
        val.to_f
      when /^(\d+(?:\.\d+)?)K$/i
        (val.to_f * 1024).to_i
      when /^(\d+(?:\.\d+)?)M$/i
        (val.to_f * 1024**2).to_i
      when /^(\d+(?:\.\d+)?)G$/i
        (val.to_f * 1024**3).to_i
      else
        val.to_i
      end
    end
  end
end
