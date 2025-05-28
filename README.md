# 🛡️ Age of War - Platoon Battle Optimizer

This Ruby script takes two sets of platoons — your own army and the enemy's — and tries all possible permutations to find the best order of attack. The goal is to **win at least 3 out of 5 matches** by using the advantage mapping between different platoon types.

---

## ⚔️ Problem Statement

Each side has 5 platoons defined in the format:  
`Type#Count;Type#Count;...`

Each platoon has a specific advantage over others. If a platoon has an advantage over the opponent, its effective power doubles. Based on that, we determine the result as `win`, `draw`, or `lose`.

---

## 🧠 Logic Summary

- We define each **Platoon** as a Ruby object with a type and count.
- We use a static **ADVANTAGE_MAP** to check type superiority.
- The script tries **every possible arrangement** of your platoons using Ruby’s `.permutation`.
- The first arrangement that results in 3 or more wins is returned.
- If no such permutation is found, we print: `"There is no chance of winning"`

---

## ✅ Example

```ruby
own = "Spearmen#10;Militia#30;FootArcher#20;LightCavalry#1000;HeavyCavalry#120"
enemy = "Militia#10;Spearmen#10;FootArcher#1000;LightCavalry#120;CavalryArcher#100"
puts find_winning_order(own, enemy)



## Test Scenarios

// You can test the program by modifying or running the following examples: //

# 1. Clear winning matchups
find_winning_order("Militia#50;Spearmen#40;FootArcher#90;LightCavalry#20;HeavyCavalry#70", 
                   "Spearmen#30;LightCavalry#20;CavalryArcher#40;FootArcher#60;Militia#10")

# 2. No chance of winning
find_winning_order("Militia#10;Militia#10;Militia#10;Militia#10;Militia#10", 
                   "HeavyCavalry#100;HeavyCavalry#100;HeavyCavalry#100;HeavyCavalry#100;HeavyCavalry#100")

