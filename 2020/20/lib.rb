class Tile
  attr_reader :id, :borders

  def initialize(input)
    lines = input.split("\n").map(&:chomp).reject(&:empty?)
    @id = lines.first.gsub(/\D/, "").to_i
    @contents = lines[1..-1].map(&:chars)
    assign_borders
    @border_names = %i[top bottom left right]
    @transformations = [
      (->(c) { c.transpose }),
      (->(c) { c.map(&:reverse) }),
    ] * 4
    @trans_index = 0
  end

  def common_border(tile)
    borders.detect do |border|
      tile.borders.include?(border) || tile.borders.include?(border.reverse)
    end
  end

  def border(name)
    borders[@border_names.index(name)]
  end

  def fit_border!(name, external_border)
    @transformations.length.times do
      return true if external_border == border(name)
      transform!
    end
    return false
  end

  def borderless
    @contents[1..-2].map { |l| l[1..-2] }
  end

  def transform!
    @contents = @transformations[@trans_index].call(@contents)
    assign_borders
    @trans_index += 1
    @trans_index = 0 if @trans_index >= @transformations.length
  end

  protected

  def assign_borders
    @borders = [
      @contents.first.dup,
      @contents.last.dup,
      @contents.map(&:first),
      @contents.map(&:last),
    ]
  end
end

class TileSet
  attr_reader :tiles

  def initialize(input)
    @tiles = input.split("\n\n").reject(&:empty?).map { |i| Tile.new(i) }
    @size = Math.sqrt(@tiles.size)
    @transformations = [
      (->(c) { c.transpose }),
      (->(c) { c.map(&:reverse) }),
    ] * 4
    @trans_index = 0
    @sea_monster = "                  # 
#    ##    ##    ###
 #  #  #  #  #  #   ".split("\n").map(&:chars)
    @monster_count = @sea_monster.inject(0) do |sum, l|
      sum + l.count("#")
    end
  end

  def find_corners
    corner_tiles.inject(1) { |chk, tile| chk * tile.id }
  end

  def assemble!
    tile = corner_tiles.first
    rest = tiles.reject { |t| t.id == tile.id }
    outer_borders = tile.borders.reject do |b|
      rest.any? do |t|
        b == tile.common_border(t)
      end
    end
    while !outer_borders.all? { |b| [tile.border(:top), tile.border(:top).reverse, tile.border(:left), tile.border(:left).reverse].include?(b) } do
      tile.transform!
    end
    @contents = tile.borderless
    x = 1
    y = 0
    while y < @size do
      bottom_border = tile.border(:bottom).dup
      while x < @size do
        tiles_s = rest.select { |t| t.fit_border!(:left, tile.border(:right)) }
        tile = tiles_s.first
        new_contents = tile.borderless
        new_contents.each_with_index do |tile_line, i|
          @contents[y*new_contents.length + i] += tile_line
        end
        rest.reject! { |t| t.id == tile.id }
        x += 1
      end
      break if rest.length.zero?
      tile = rest.detect { |t| t.fit_border!(:top, bottom_border) }
      @contents += tile.borderless
      rest.reject! { |t| t.id == tile.id }
      y += 1
      x = 1
    end
  end

  def find_monster!
    monster_count = 0
    while monster_count == 0 do
      (0..(@contents.length-@sea_monster.length)).each do |y|
        (0..(@contents[y].length-@sea_monster.first.length)).each do |x|
          monster = @sea_monster.each_with_index.all? do |l, my|
            l.each_with_index.all? do |c, mx|
              c == " " || (c == "#" && @contents[y+my][x+mx] == "#")
            end
          end
          monster_count += 1 if monster
        end
      end
      transform! if monster_count == 0
    end
    monster_count
  end

  def count_water_roughness!
    assemble!
    cnt = find_monster!
    @contents.inject(0) do |sum, l|
      sum + l.count("#")
    end - @monster_count * cnt
  end

  def transform!
    @contents = @transformations[@trans_index].call(@contents)
    @trans_index += 1
    @trans_index = 0 if @trans_index >= @transformations.length
  end

  protected

  def corner_tiles
    tiles.select do |tile|
      borders = tiles.reject { |t| t.id == tile.id }.map { |t| tile.common_border(t) }.compact
      # puts borders.inspect
      borders.length <= 2
    end
  end
end
