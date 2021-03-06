module Transformable
  attr :transformations_count

  TRANSFORMATIONS = [
    (->(c) { c.transpose }),
    (->(c) { c.reverse }),
  ].freeze
  FULL_CYCLE_LENGTH = 8

  def init_transformations(after_hook = nil)
    @transformations_count = 0
    @after_hook = after_hook
  end

  def transform!
    @contents = TRANSFORMATIONS[@transformations_count].call(@contents)
    @transformations_count += 1
    @transformations_count = 0 if @transformations_count >= TRANSFORMATIONS.length
    self.send(@after_hook) if @after_hook
  end
end

class Tile
  include Transformable

  attr_reader :id, :borders

  def initialize(input)
    lines = input.split("\n").map(&:chomp).reject(&:empty?)
    @id = lines.first.gsub(/\D/, "").to_i
    @contents = lines[1..-1].map(&:chars)
    assign_borders
    @border_names = %i[top bottom left right]
    init_transformations(:assign_borders)
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
    FULL_CYCLE_LENGTH.times do
      return true if external_border == border(name)
      transform!
    end
    return false
  end

  def borderless
    @contents[1..-2].map { |l| l[1..-2] }
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
  include Transformable

  attr_reader :tiles

  def initialize(input)
    @tiles = input.split("\n\n").reject(&:empty?).map { |i| Tile.new(i) }
    @size = Math.sqrt(@tiles.size)
    @sea_monster = "                  # 
#    ##    ##    ###
 #  #  #  #  #  #   ".split("\n").map(&:chars)
    @monster_size = @sea_monster.inject(0) do |sum, l|
      sum + l.count("#")
    end
    init_transformations
  end

  def find_corners
    corner_tiles.inject(1) { |chk, tile| chk * tile.id }
  end

  def count_water_roughness!
    assemble!
    count_monsters = find_monster!
    @contents.inject(0) do |sum, l|
      sum + l.count("#")
    end - @monster_size * count_monsters
  end

  protected

  def corner_tiles
    tiles.select do |tile|
      borders = tiles.reject { |t| t.id == tile.id }.map { |t| tile.common_border(t) }.compact
      borders.length <= 2
    end
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
        tile = rest.detect { |t| t.fit_border!(:left, tile.border(:right)) }
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
end
