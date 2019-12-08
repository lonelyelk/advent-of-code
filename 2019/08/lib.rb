class Image
  attr_reader :layers, :width, :height

  def initialize(data:, width:, height:)
    @width = width
    @height = height
    @layers = data.each_slice(width * height).to_a
  end

  def check_num
    layer0 = layers.min_by { |layer| layer.count { |pixel| pixel == 0 } }
    layer0.count { |pixel| pixel == 1 } * layer0.count { |pixel| pixel == 2 }
  end

  def merged_layer
    @merged_layer ||= layers.reverse.inject do |m, l|
      l.map.with_index { |pixel, i| pixel == 2 ? m[i] : pixel }
    end
  end

  def render
    (0...height).each do |y|
      puts (merged_layer[y*width...(y+1)*width].map do |pixel|
        case pixel
        when 0
          " "
        when 1
          "*"
        else
          "."
        end
      end.join)
    end
  end

  def self.read(buffer:, width:, height:)
    new(data: buffer.chars.map(&:to_i), width: width, height: height)
  end
end
