module ParamParser
  def self.parse(input, type = :int, default: nil)
    return default unless input

    candidates = input.split(',').flat_map do |part|
      if part.include?('-')
        bounds = part.split('-').map { |v| convert(v, type) }
        (bounds[0]..bounds[1]).to_a
      else
        [convert(part, type)]
      end
    end

    candidates.sample
  rescue
    default
  end

  def self.convert(val, type)
    val = val.strip.upcase
    multiplier = case val[-1]
                 when 'K' then 1024
                 when 'M' then 1024**2
                 when 'G' then 1024**3
                 else 1
                 end

    num = val.gsub(/[KMG]/, '').to_f
    num *= multiplier

    case type
    when :int then num.to_i
    when :float then num.to_f
    else num
    end
  end
end
