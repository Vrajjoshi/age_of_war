# Represents a platoon with type and count
class Platoon
  attr_reader :type, :count

  ADVANTAGE_MAP = {
    "Militia"        => ["Spearmen", "LightCavalry"],
    "Spearmen"       => ["LightCavalry", "HeavyCavalry"],
    "LightCavalry"   => ["FootArcher", "CavalryArcher"],
    "HeavyCavalry"   => ["Militia", "FootArcher", "LightCavalry"],
    "CavalryArcher"  => ["Spearmen", "HeavyCavalry"],
    "FootArcher"     => ["Militia", "CavalryArcher"]
  }

  def initialize(type, count)
    @type = type
    @count = count.to_i
  end

  def beats?(opponent)
    multiplier = ADVANTAGE_MAP[type]&.include?(opponent.type) ? 2 : 1
    power = count * multiplier

    return :win  if power > opponent.count
    return :draw if power == opponent.count

    :lose
  end

  def to_s
    "#{type}##{count}"
  end
end

# Parses a semicolon-separated list of platoons into Platoon objects
def parse_platoons(line)
  line.split(";").map do |entry|
    type, count = entry.strip.split("#")
    Platoon.new(type, count)
  end
end

# Finds an arrangement of own platoons that beats the enemy
def find_winning_order(own_line, enemy_line)
  own_platoons   = parse_platoons(own_line)
  enemy_platoons = parse_platoons(enemy_line)

  own_platoons.permutation.each do |order|
    result = order.zip(enemy_platoons).map { |own, enemy| own.beats?(enemy) }
    return order.map(&:to_s).join(";") if result.count(:win) >= 3
  end

  "There is no chance of winning"
end

# Sample input
own   = "Spearmen#10;Militia#30;FootArcher#20;LightCavalry#1000;HeavyCavalry#120"
enemy = "Militia#10;Spearmen#10;FootArcher#1000;LightCavalry#120;CavalryArcher#100"

puts find_winning_order(own, enemy)
