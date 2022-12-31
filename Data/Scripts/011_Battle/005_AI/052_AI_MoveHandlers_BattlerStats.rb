#===============================================================================
# TODO: This code can be called with a single target and with no targets. Make
#       sure it doesn't assume that there is a target.
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("RaiseUserAttack1",
  proc { |move, user, ai, battle|
    next true if move.statusMove? &&
                 !user.battler.pbCanRaiseStatStage?(move.move.statUp[0], user.battler, move.move)
  }
)
Battle::AI::Handlers::MoveEffectScore.add("RaiseUserAttack1",
  proc { |score, move, user, ai, battle|
    next ai.get_score_for_target_stat_raise(score, user, move.move.statUp)
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserAttack1",
                                            "RaiseUserAttack2")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAttack1",
                                           "RaiseUserAttack2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("RaiseUserAttack2IfTargetFaints",
  proc { |score, move, user, target, ai, battle|
    if move.rough_damage >= target.hp * 0.9
      next ai.get_score_for_target_stat_raise(score, user, move.move.statUp)
    end
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserAttack2",
                                            "RaiseUserAttack3")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAttack2",
                                           "RaiseUserAttack3")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("RaiseUserAttack2IfTargetFaints",
                                                        "RaiseUserAttack3IfTargetFaints")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("MaxUserAttackLoseHalfOfTotalHP",
  proc { |move, user, ai, battle|
    next true if user.hp <= [user.totalhp / 2, 1].max
    next true if !user.battler.pbCanRaiseStatStage?(:ATTACK, user.battler, move.move)
  }
)
Battle::AI::Handlers::MoveEffectScore.add("MaxUserAttackLoseHalfOfTotalHP",
  proc { |score, move, user, ai, battle|
    score = ai.get_score_for_target_stat_raise(score, user, move.move.statUp)
    # Don't prefer the lower the user's HP is
    score -= 80 * (1 - (user.hp.to_f / user.totalhp))   # 0 to -40
    next score
  }
)

#===============================================================================
# TODO: This code can be called with a single target and with no targets. Make
#       sure it doesn't assume that there is a target.
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserAttack1",
                                            "RaiseUserDefense1")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAttack1",
                                           "RaiseUserDefense1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserDefense1",
                                            "RaiseUserDefense1CurlUpUser")
Battle::AI::Handlers::MoveEffectScore.add("RaiseUserDefense1CurlUpUser",
  proc { |score, move, user, ai, battle|
    score = ai.get_score_for_target_stat_raise(score, user, move.move.statUp)
    if !user.effects[PBEffects::DefenseCurl] &&
       user.check_for_move { |m| m.function == "MultiTurnAttackPowersUpEachTurn" }
      score += 10
    end
    next score
  }
)

#===============================================================================
# TODO: This code can be called with multiple targets and with no targets. Make
#       sure it doesn't assume that there is a target.
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserDefense1",
                                            "RaiseUserDefense2")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserDefense1",
                                           "RaiseUserDefense2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserDefense1",
                                            "RaiseUserDefense3")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserDefense1",
                                           "RaiseUserDefense3")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserAttack1",
                                            "RaiseUserSpAtk1")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAttack1",
                                           "RaiseUserSpAtk1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserSpAtk1",
                                            "RaiseUserSpAtk2")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserSpAtk1",
                                           "RaiseUserSpAtk2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserSpAtk1",
                                            "RaiseUserSpAtk3")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserSpAtk1",
                                           "RaiseUserSpAtk3")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserDefense1",
                                            "RaiseUserSpDef1")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserDefense1",
                                           "RaiseUserSpDef1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserSpDef1",
                                            "RaiseUserSpDef1PowerUpElectricMove")
Battle::AI::Handlers::MoveEffectScore.add("RaiseUserSpDef1PowerUpElectricMove",
  proc { |score, move, user, ai, battle|
    score = ai.get_score_for_target_stat_raise(score, user, move.move.statUp)
    if user.check_for_move { |m| m.damagingMove? && m.type == :ELECTRIC }
      score += 10
    end
    next score
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserSpDef1",
                                            "RaiseUserSpDef2")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserSpDef1",
                                           "RaiseUserSpDef2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserSpDef1",
                                            "RaiseUserSpDef3")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserSpDef1",
                                           "RaiseUserSpDef3")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserSpDef1",
                                            "RaiseUserSpeed1")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserSpDef1",
                                           "RaiseUserSpeed1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserSpeed1",
                                            "RaiseUserSpeed2")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserSpeed1",
                                           "RaiseUserSpeed2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserSpeed2",
                                            "RaiseUserSpeed2LowerUserWeight")
Battle::AI::Handlers::MoveEffectScore.add("RaiseUserSpeed2LowerUserWeight",
  proc { |score, move, user, ai, battle|
    score = ai.get_score_for_target_stat_raise(score, user, move.move.statUp)
    if ai.trainer.medium_skill?
      # TODO: Take into account weight-modifying items/abilities? This "> 1"
      #       line can probably ignore them, but these moves' powers will change
      #       because of those modifiers, and the score changes may need to be
      #       different accordingly.
      if user.battler.pokemon.weight - user.effects[PBEffects::WeightChange] > 1
        if user.check_for_move { |m| m.function == "PowerHigherWithUserHeavierThanTarget" }
          score -= 10
        end
        ai.each_foe_battler(user.side) do |b, i|
          if b.check_for_move { |m| m.function == "PowerHigherWithUserHeavierThanTarget" }
            score -= 10
          end
          if b.check_for_move { |m| m.function == "PowerHigherWithTargetWeight" }
            score += 10
          end
          # TODO: Check foes for Sky Drop and whether the user is too heavy for it
          #       but the weight reduction will make it susceptible.
        end
      end
    end
    next score
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserSpeed1",
                                            "RaiseUserSpeed3")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserSpeed1",
                                           "RaiseUserSpeed3")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserSpeed1",
                                            "RaiseUserAccuracy1")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserSpeed1",
                                           "RaiseUserAccuracy1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserAccuracy1",
                                            "RaiseUserAccuracy2")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAccuracy1",
                                           "RaiseUserAccuracy2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserAccuracy1",
                                            "RaiseUserAccuracy3")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAccuracy1",
                                           "RaiseUserAccuracy3")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserAccuracy1",
                                            "RaiseUserEvasion1")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAccuracy1",
                                           "RaiseUserEvasion1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserEvasion1",
                                            "RaiseUserEvasion2")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserEvasion1",
                                           "RaiseUserEvasion2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserEvasion2",
                                            "RaiseUserEvasion2MinimizeUser")
Battle::AI::Handlers::MoveEffectScore.add("RaiseUserEvasion2MinimizeUser",
  proc { |score, move, user, ai, battle|
    score = ai.get_score_for_target_stat_raise(score, user, move.move.statUp)
    if ai.trainer.medium_skill? && !user.effects[PBEffects::Minimize]
      ai.each_foe_battler(user.side) do |b, i|
        # Moves that do double damage and (in Gen 6+) have perfect accuracy
        if b.check_for_move { |m| m.tramplesMinimize? }
          score -= (Settings::MECHANICS_GENERATION >= 6) ? 15 : 10
        end
      end
    end
    next score
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserEvasion2",
                                            "RaiseUserEvasion3")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserEvasion2",
                                           "RaiseUserEvasion3")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("RaiseUserCriticalHitRate2",
  proc { |move, user, ai, battle|
    next true if user.effects[PBEffects::FocusEnergy] >= 2
  }
)
Battle::AI::Handlers::MoveEffectScore.add("RaiseUserCriticalHitRate2",
  proc { |score, move, user, ai, battle|
    next Battle::AI::MOVE_USELESS_SCORE if !user.check_for_move { |m| m.damagingMove? }
    score += 15
    if ai.trainer.medium_skill?
      # Other effects that raise the critical hit rate
      if user.item_active?
        if [:RAZORCLAW, :SCOPELENS].include?(user.item_id) ||
           (user.item_id == :LUCKYPUNCH && user.battler.isSpecies?(:CHANSEY)) ||
           ([:LEEK, :STICK].include?(user.item_id) &&
           (user.battler.isSpecies?(:FARFETCHD) || user.battler.isSpecies?(:SIRFETCHD)))
          score += 10
        end
      end
      # Critical hits do more damage
      score += 10 if user.has_active_ability?(:SNIPER)
    end
    next score
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("RaiseUserAtkDef1",
  proc { |move, user, ai, battle|
    if move.statusMove?
      will_fail = true
      (move.move.statUp.length / 2).times do |i|
        next if !user.battler.pbCanRaiseStatStage?(move.move.statUp[i * 2], user.battler, move.move)
        will_fail = false
        break
      end
      next will_fail
    end
  }
)
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAttack1",
                                           "RaiseUserAtkDef1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserAtkDef1",
                                            "RaiseUserAtkDefAcc1")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAtkDef1",
                                           "RaiseUserAtkDefAcc1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserAtkDef1",
                                            "RaiseUserAtkSpAtk1")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAtkDef1",
                                           "RaiseUserAtkSpAtk1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserAtkSpAtk1",
                                            "RaiseUserAtkSpAtk1Or2InSun")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAtkSpAtk1",
                                           "RaiseUserAtkSpAtk1Or2InSun")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("LowerUserDefSpDef1RaiseUserAtkSpAtkSpd2",
  proc { |move, user, ai, battle|
    will_fail = true
    (move.move.statUp.length / 2).times do |i|
      next if !user.battler.pbCanRaiseStatStage?(move.move.statUp[i * 2], user.battler, move.move)
      will_fail = false
      break
    end
    (move.move.statDown.length / 2).times do |i|
      next if !user.battler.pbCanLowerStatStage?(move.move.statDown[i * 2], user.battler, move.move)
      will_fail = false
      break
    end
    next will_fail
  }
)
Battle::AI::Handlers::MoveEffectScore.add("LowerUserDefSpDef1RaiseUserAtkSpAtkSpd2",
  proc { |score, move, user, ai, battle|
    score = ai.get_score_for_target_stat_raise(score, user, move.move.statUp)
    next score if score == Battle::AI::MOVE_USELESS_SCORE
    next ai.get_score_for_target_stat_drop(score, user, move.move.statDown, false)
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserAtkSpAtk1",
                                            "RaiseUserAtkSpd1")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAtkSpAtk1",
                                           "RaiseUserAtkSpd1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserAtkSpAtk1",
                                            "RaiseUserAtk1Spd2")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAtkSpAtk1",
                                           "RaiseUserAtk1Spd2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserAtkSpAtk1",
                                            "RaiseUserAtkAcc1")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAtkSpAtk1",
                                           "RaiseUserAtkAcc1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserAtkSpAtk1",
                                            "RaiseUserDefSpDef1")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAtkSpAtk1",
                                           "RaiseUserDefSpDef1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserAtkSpAtk1",
                                            "RaiseUserSpAtkSpDef1")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAtkSpAtk1",
                                           "RaiseUserSpAtkSpDef1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserAtkSpAtk1",
                                            "RaiseUserSpAtkSpDefSpd1")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAtkSpAtk1",
                                           "RaiseUserSpAtkSpDefSpd1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.copy("RaiseUserAtkSpAtk1",
                                            "RaiseUserMainStats1")
Battle::AI::Handlers::MoveEffectScore.copy("RaiseUserAtkSpAtk1",
                                           "RaiseUserMainStats1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("RaiseUserMainStats1LoseThirdOfTotalHP",
  proc { |move, user, ai, battle|
    next true if user.hp <= [user.totalhp / 3, 1].max
    will_fail = true
    (move.move.statUp.length / 2).times do |i|
      next if !user.battler.pbCanRaiseStatStage?(move.move.statUp[i * 2], user.battler, move.move)
      will_fail = false
      break
    end
    next will_fail
  }
)
Battle::AI::Handlers::MoveEffectScore.add("RaiseUserMainStats1LoseThirdOfTotalHP",
  proc { |score, move, user, ai, battle|
    # Score for stat increase
    score = ai.get_score_for_target_stat_raise(score, user, move.move.statUp)
    next score if score == Battle::AI::MOVE_USELESS_SCORE
    # Score for losing HP
    if user.hp <= user.totalhp * 0.75
      score -= 30 * (user.totalhp - user.hp) / user.totalhp
    end
    next score
  }
)

#===============================================================================
# TODO: Review score modifiers.
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("RaiseUserMainStats1TrapUserInBattle",
  proc { |move, user, ai, battle|
    next true if user.effects[PBEffects::NoRetreat]
    will_fail = true
    (move.move.statUp.length / 2).times do |i|
      next if !user.battler.pbCanRaiseStatStage?(move.move.statUp[i * 2], user.battler, move.move)
      will_fail = false
      break
    end
    next will_fail
  }
)
Battle::AI::Handlers::MoveEffectScore.add("RaiseUserMainStats1TrapUserInBattle",
  proc { |score, move, user, ai, battle|
    # Score for stat increase
    score = ai.get_score_for_target_stat_raise(score, user, move.move.statUp)
    # Score for trapping user in battle
    if ai.trainer.medium_skill? && !user.battler.trappedInBattle?
      score -= 10 if user.hp <= user.totalhp / 2
    end
    next score
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectScore.add("StartRaiseUserAtk1WhenDamaged",
  proc { |score, move, user, ai, battle|
    # Ignore the stat-raising effect if user is at a low HP and likely won't
    # benefit from it
    next score if user.hp < user.totalhp / 3
    # TODO: Check whether any foe has damaging moves that will trigger the stat
    #       raise?
    # Prefer if user benefits from a raised Attack stat
    if user.check_for_move { |m| m.physicalMove?(m.type) &&
                                 m.function != "UseUserDefenseInsteadOfUserAttack" &&
                                 m.function != "UseTargetAttackInsteadOfUserAttack" }
      score += 8
    elsif user.check_for_move { |m| m.function == "PowerHigherWithUserPositiveStatStages" }
      score += 4
    end
    next score
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectScore.add("LowerUserAttack1",
  proc { |score, move, user, ai, battle|
    next ai.get_score_for_target_stat_drop(score, user, move.move.statDown)
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectScore.copy("LowerUserAttack1",
                                           "LowerUserAttack2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectScore.copy("LowerUserAttack1",
                                           "LowerUserDefense1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectScore.copy("LowerUserDefense1",
                                           "LowerUserDefense2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectScore.copy("LowerUserAttack1",
                                           "LowerUserSpAtk1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectScore.copy("LowerUserSpAtk1",
                                           "LowerUserSpAtk2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectScore.copy("LowerUserDefense1",
                                           "LowerUserSpDef1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectScore.copy("LowerUserSpDef1",
                                           "LowerUserSpDef2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectScore.copy("LowerUserAttack1",
                                           "LowerUserSpeed1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectScore.copy("LowerUserSpeed1",
                                           "LowerUserSpeed2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectScore.copy("LowerUserAttack1",
                                           "LowerUserAtkDef1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectScore.copy("LowerUserAttack1",
                                           "LowerUserDefSpDef1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectScore.copy("LowerUserAttack1",
                                           "LowerUserDefSpDefSpd1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("RaiseTargetAttack1",
  proc { |move, user, target, ai, battle|
    next true if move.statusMove? &&
                 !target.battler.pbCanRaiseStatStage?(:ATTACK, user.battler, move.move)
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("RaiseTargetAttack1",
  proc { |score, move, user, target, ai, battle|
    next ai.get_score_for_target_stat_raise(score, target, [:ATTACK, 1])
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("RaiseTargetAttack2ConfuseTarget",
  proc { |move, user, target, ai, battle|
    next true if !target.battler.pbCanRaiseStatStage?(:ATTACK, user.battler, move.move) &&
                 !target.battler.pbCanConfuse?(user.battler, false, move.move)
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("RaiseTargetAttack2ConfuseTarget",
  proc { |score, move, user, target, ai, battle|
    if !target.has_active_ability?(:CONTRARY) || @battle.moldBreaker
      next Battle::AI::MOVE_USELESS_SCORE if !target.battler.pbCanConfuse?(user.battler, false, move.move)
    end
    # Score for stat raise
    score = ai.get_score_for_target_stat_raise(score, target, [:ATTACK, 2], false)
    # Score for confusing the target
    next Battle::AI::Handlers.apply_move_effect_against_target_score(
       "ConfuseTarget", score, move, user, target, ai, battle)
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("RaiseTargetSpAtk1ConfuseTarget",
  proc { |move, user, target, ai, battle|
    next true if !target.battler.pbCanRaiseStatStage?(:SPECIAL_ATTACK, user.battler, move.move) &&
                 !target.battler.pbCanConfuse?(user.battler, false, move.move)
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("RaiseTargetSpAtk1ConfuseTarget",
  proc { |score, move, user, target, ai, battle|
    if !target.has_active_ability?(:CONTRARY) || @battle.moldBreaker
      next Battle::AI::MOVE_USELESS_SCORE if !target.battler.pbCanConfuse?(user.battler, false, move.move)
    end
    # Score for stat raise
    score = ai.get_score_for_target_stat_raise(score, target, [:SPECIAL_ATTACK, 1], false)
    # Score for confusing the target
    next Battle::AI::Handlers.apply_move_effect_against_target_score(
       "ConfuseTarget", score, move, user, target, ai, battle)
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("RaiseTargetSpDef1",
  proc { |move, user, target, ai, battle|
    next true if !target.battler.pbCanRaiseStatStage?(:SPECIAL_DEFENSE, user.battler, move.move)
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("RaiseTargetSpDef1",
  proc { |score, move, user, target, ai, battle|
    next ai.get_score_for_target_stat_raise(score, target, [:SPECIAL_DEFENSE, 1])
  }
)

#===============================================================================
# TODO: Review score modifiers.
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("RaiseTargetRandomStat2",
  proc { |move, user, target, ai, battle|
    will_fail = true
    GameData::Stat.each_battle do |s|
      next if !target.battler.pbCanRaiseStatStage?(s.id, user.battler, move.move)
      will_fail = false
    end
    next will_fail
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("RaiseTargetRandomStat2",
  proc { |score, move, user, target, ai, battle|
    avgStat = 0
    GameData::Stat.each_battle do |s|
      avgStat -= target.stages[s.id] if !target.statStageAtMax?(s.id)
    end
    avgStat = avgStat / 2 if avgStat < 0   # More chance of getting even better
    next + avgStat * 10
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("RaiseTargetAtkSpAtk2",
  proc { |move, user, target, ai, battle|
    next true if !target.battler.pbCanRaiseStatStage?(:ATTACK, user.battler, move.move) &&
                 !target.battler.pbCanRaiseStatStage?(:SPECIAL_ATTACK, user.battler, move.move)
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("RaiseTargetAtkSpAtk2",
  proc { |score, move, user, target, ai, battle|
    next Battle::AI::MOVE_USELESS_SCORE if target.opposes?(user)
    next ai.get_score_for_target_stat_raise(score, target, [:ATTACK, 2, :SPECIAL_ATTACK, 2])
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("LowerTargetAttack1",
  proc { |move, user, target, ai, battle|
    next true if move.statusMove? &&
                 !target.battler.pbCanLowerStatStage?(move.move.statDown[0], user.battler, move.move)
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("LowerTargetAttack1",
  proc { |score, move, user, target, ai, battle|
    next ai.get_score_for_target_stat_drop(score, target, move.move.statDown)
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetAttack1",
                                                         "LowerTargetAttack1BypassSubstitute")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetAttack1",
                                                        "LowerTargetAttack1BypassSubstitute")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetAttack1",
                                                         "LowerTargetAttack2")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetAttack1",
                                                        "LowerTargetAttack2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetAttack2",
                                                         "LowerTargetAttack3")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetAttack2",
                                                        "LowerTargetAttack3")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetAttack1",
                                                         "LowerTargetDefense1")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetAttack1",
                                                        "LowerTargetDefense1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetDefense1",
                                                         "LowerTargetDefense1PowersUpInGravity")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetDefense1",
                                                        "LowerTargetDefense1PowersUpInGravity")
Battle::AI::Handlers::MoveBasePower.add("LowerTargetDefense1PowersUpInGravity",
  proc { |power, move, user, target, ai, battle|
    next move.move.pbBaseDamage(power, user.battler, target.battler)
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetDefense1",
                                                         "LowerTargetDefense2")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetDefense1",
                                                        "LowerTargetDefense2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetDefense2",
                                                         "LowerTargetDefense3")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetDefense2",
                                                        "LowerTargetDefense3")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetAttack1",
                                                         "LowerTargetSpAtk1")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetAttack1",
                                                        "LowerTargetSpAtk1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetSpAtk1",
                                                         "LowerTargetSpAtk2")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetSpAtk1",
                                                        "LowerTargetSpAtk2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("LowerTargetSpAtk2IfCanAttract",
  proc { |move, user, target, ai, battle|
    next true if move.statusMove? &&
                 !target.battler.pbCanLowerStatStage?(move.move.statDown[0], user.battler, move.move)
    next true if user.gender == 2 || target.gender == 2 || user.gender == target.gender
    next true if !battle.moldBreaker && target.has_active_ability?(:OBLIVIOUS)
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetSpAtk2",
                                                        "LowerTargetSpAtk2IfCanAttract")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetSpAtk2",
                                                         "LowerTargetSpAtk3")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetSpAtk2",
                                                        "LowerTargetSpAtk3")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetDefense1",
                                                         "LowerTargetSpDef1")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetDefense1",
                                                        "LowerTargetSpDef1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetSpDef1",
                                                         "LowerTargetSpDef2")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetSpDef1",
                                                        "LowerTargetSpDef2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetSpDef2",
                                                         "LowerTargetSpDef3")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetSpDef2",
                                                        "LowerTargetSpDef3")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetSpDef1",
                                                         "LowerTargetSpeed1")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetSpDef1",
                                                        "LowerTargetSpeed1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetSpeed1",
                                                         "LowerTargetSpeed1WeakerInGrassyTerrain")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetSpeed1",
                                                        "LowerTargetSpeed1WeakerInGrassyTerrain")
Battle::AI::Handlers::MoveBasePower.add("LowerTargetSpeed1WeakerInGrassyTerrain",
  proc { |power, move, user, target, ai, battle|
    next move.move.pbBaseDamage(power, user.battler, target.battler)
  }
)

#===============================================================================
# TODO: Review score modifiers.
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("LowerTargetSpeed1MakeTargetWeakerToFire",
  proc { |move, user, target, ai, battle|
    if !target.effects[PBEffects::TarShot]
      next true if move.statusMove? &&
                   !target.battler.pbCanLowerStatStage?(move.move.statDown[0], user.battler, move.move)
    end
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("LowerTargetSpeed1MakeTargetWeakerToFire",
  proc { |score, move, user, target, ai, battle|
    # Score for stat drop
    score = ai.get_score_for_target_stat_drop(score, target, move.move.statDown)
    # Score for adding weakness to Fire
    if !target.effects[PBEffects::TarShot]
      score += 20 if user.battler.moves.any? { |m| m.damagingMove? && m.pbCalcType(user.battler) == :FIRE }
    end
    next score
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetSpeed1",
                                                         "LowerTargetSpeed2")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetSpeed1",
                                                        "LowerTargetSpeed2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetSpeed2",
                                                         "LowerTargetSpeed3")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetSpeed2",
                                                        "LowerTargetSpeed3")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetSpeed1",
                                                         "LowerTargetAccuracy1")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetSpeed1",
                                                        "LowerTargetAccuracy1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetAccuracy1",
                                                         "LowerTargetAccuracy2")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetAccuracy1",
                                                        "LowerTargetAccuracy2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetAccuracy2",
                                                         "LowerTargetAccuracy3")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetAccuracy2",
                                                        "LowerTargetAccuracy3")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetAccuracy1",
                                                         "LowerTargetEvasion1")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetAccuracy1",
                                                        "LowerTargetEvasion1")

#===============================================================================
# TODO: Review score modifiers.
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("LowerTargetEvasion1RemoveSideEffects",
  proc { |move, user, target, ai, battle|
    target_side = target.pbOwnSide
    target_opposing_side = target.pbOpposingSide
    next false if target_side.effects[PBEffects::AuroraVeil] > 0 ||
                  target_side.effects[PBEffects::LightScreen] > 0 ||
                  target_side.effects[PBEffects::Reflect] > 0 ||
                  target_side.effects[PBEffects::Mist] > 0 ||
                  target_side.effects[PBEffects::Safeguard] > 0
    next false if target_side.effects[PBEffects::StealthRock] ||
                  target_side.effects[PBEffects::Spikes] > 0 ||
                  target_side.effects[PBEffects::ToxicSpikes] > 0 ||
                  target_side.effects[PBEffects::StickyWeb]
    next false if Settings::MECHANICS_GENERATION >= 6 &&
                  (target_opposing_side.effects[PBEffects::StealthRock] ||
                  target_opposing_side.effects[PBEffects::Spikes] > 0 ||
                  target_opposing_side.effects[PBEffects::ToxicSpikes] > 0 ||
                  target_opposing_side.effects[PBEffects::StickyWeb])
    next false if Settings::MECHANICS_GENERATION >= 8 && battle.field.terrain != :None
    next true if move.statusMove? &&
                 !target.battler.pbCanLowerStatStage?(move.move.statDown[0], user.battler, move.move)
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("LowerTargetEvasion1RemoveSideEffects",
  proc { |score, move, user, target, ai, battle|
    # Score for stat drop
    score = ai.get_score_for_target_stat_drop(score, target, move.move.statDown)
    # Score for removing side effects/terrain
    score += 30 if target.pbOwnSide.effects[PBEffects::AuroraVeil] > 0 ||
                   target.pbOwnSide.effects[PBEffects::Reflect] > 0 ||
                   target.pbOwnSide.effects[PBEffects::LightScreen] > 0 ||
                   target.pbOwnSide.effects[PBEffects::Mist] > 0 ||
                   target.pbOwnSide.effects[PBEffects::Safeguard] > 0
    score -= 30 if target.pbOwnSide.effects[PBEffects::Spikes] > 0 ||
                   target.pbOwnSide.effects[PBEffects::ToxicSpikes] > 0 ||
                   target.pbOwnSide.effects[PBEffects::StealthRock]
    next score
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetEvasion1",
                                                         "LowerTargetEvasion2")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetEvasion1",
                                                        "LowerTargetEvasion2")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetEvasion2",
                                                         "LowerTargetEvasion3")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetEvasion2",
                                                        "LowerTargetEvasion3")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("LowerTargetAtkDef1",
  proc { |move, user, target, ai, battle|
    next false if !move.statusMove?
    will_fail = true
    (move.move.statDown.length / 2).times do |i|
      next if !target.battler.pbCanLowerStatStage?(move.move.statDown[i * 2], user.battler, move.move)
      will_fail = false
      break
    end
    next will_fail
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetAttack1",
                                                        "LowerTargetAtkDef1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.copy("LowerTargetAtkDef1",
                                                         "LowerTargetAtkSpAtk1")
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetAtkDef1",
                                                        "LowerTargetAtkSpAtk1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("LowerPoisonedTargetAtkSpAtkSpd1",
  proc { |move, user, target, ai, battle|
    next true if !target.battler.poisoned?
    next Battle::AI::Handlers.move_will_fail_against_target?("LowerTargetAtkSpAtk1",
                                                             move, user, target, ai, battle)
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.copy("LowerTargetAtkSpAtk1",
                                                        "LowerPoisonedTargetAtkSpAtkSpd1")

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("RaiseAlliesAtkDef1",
  proc { |move, user, target, ai, battle|
    next !target.battler.pbCanRaiseStatStage?(:ATTACK, user.battler, move.move) &&
         !target.battler.pbCanRaiseStatStage?(:DEFENSE, user.battler, move.move)
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("RaiseAlliesAtkDef1",
  proc { |score, move, user, target, ai, battle|
    next ai.get_score_for_target_stat_raise(score, target, [:ATTACK, 1, :DEFENSE, 1])
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("RaisePlusMinusUserAndAlliesAtkSpAtk1",
  proc { |move, user, ai, battle|
    will_fail = true
    ai.each_same_side_battler(user.side) do |b, i|
      next if !b.has_active_ability?([:MINUS, :PLUS])
      next if !b.battler.pbCanRaiseStatStage?(:ATTACK, user.battler, move.move) &&
              !b.battler.pbCanRaiseStatStage?(:SPECIAL_ATTACK, user.battler, move.move)
      will_fail = false
      break
    end
    next will_fail
  }
)
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("RaisePlusMinusUserAndAlliesAtkSpAtk1",
  proc { |move, user, target, ai, battle|
    next true if !target.hasActiveAbility?([:MINUS, :PLUS])
    next !target.battler.pbCanRaiseStatStage?(:ATTACK, user.battler, move.move) &&
         !target.battler.pbCanRaiseStatStage?(:SPECIAL_ATTACK, user.battler, move.move)
  }
)
Battle::AI::Handlers::MoveEffectScore.add("RaisePlusMinusUserAndAlliesAtkSpAtk1",
  proc { |score, move, user, ai, battle|
    next score if move.pbTarget(user.battler) != :UserSide
    ai.each_same_side_battler(user.side) do |b, i|
      score = ai.get_score_for_target_stat_raise(score, b, [:ATTACK, 1, :SPECIAL_ATTACK, 1], false)
    end
    next score
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("RaisePlusMinusUserAndAlliesAtkSpAtk1",
  proc { |score, move, user, target, ai, battle|
    next ai.get_score_for_target_stat_raise(score, target, [:ATTACK, 1, :SPECIAL_ATTACK, 1])
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("RaisePlusMinusUserAndAlliesDefSpDef1",
  proc { |move, user, ai, battle|
    will_fail = true
    ai.each_same_side_battler(user.side) do |b, i|
      next if !b.has_active_ability?([:MINUS, :PLUS])
      next if !b.battler.pbCanRaiseStatStage?(:DEFENSE, user.battler, move.move) &&
              !b.battler.pbCanRaiseStatStage?(:SPECIAL_DEFENSE, user.battler, move.move)
      will_fail = false
      break
    end
    next will_fail
  }
)
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("RaisePlusMinusUserAndAlliesDefSpDef1",
  proc { |move, user, target, ai, battle|
    next true if !target.hasActiveAbility?([:MINUS, :PLUS])
    next !target.battler.pbCanRaiseStatStage?(:DEFENSE, user.battler, move.move) &&
         !target.battler.pbCanRaiseStatStage?(:SPECIAL_DEFENSE, user.battler, move.move)
  }
)
Battle::AI::Handlers::MoveEffectScore.add("RaisePlusMinusUserAndAlliesDefSpDef1",
  proc { |score, move, user, ai, battle|
    next score if move.pbTarget(user.battler) != :UserSide
    ai.each_same_side_battler(user.side) do |b, i|
      score = ai.get_score_for_target_stat_raise(score, b, [:DEFENSE, 1, :SPECIAL_DEFENSE, 1], false)
    end
    next score
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("RaisePlusMinusUserAndAlliesDefSpDef1",
  proc { |score, move, user, target, ai, battle|
    next ai.get_score_for_target_stat_raise(score, target, [:DEFENSE, 1, :SPECIAL_DEFENSE, 1])
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("RaiseGroundedGrassBattlersAtkSpAtk1",
  proc { |move, user, target, ai, battle|
    next true if !b.pbHasType?(:GRASS) || b.airborne? || b.semiInvulnerable?
    next !target.battler.pbCanRaiseStatStage?(:ATTACK, user.battler, move.move) &&
         !target.battler.pbCanRaiseStatStage?(:SPECIAL_ATTACK, user.battler, move.move)
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("RaiseGroundedGrassBattlersAtkSpAtk1",
  proc { |score, move, user, target, ai, battle|
    next ai.get_score_for_target_stat_raise(score, target, [:ATTACK, 1, :SPECIAL_ATTACK, 1])
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("RaiseGrassBattlersDef1",
  proc { |move, user, target, ai, battle|
    next true if !b.pbHasType?(:GRASS) || b.semiInvulnerable?
    next !target.battler.pbCanRaiseStatStage?(:DEFENSE, user.battler, move.move)
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("RaiseGrassBattlersDef1",
  proc { |score, move, user, target, ai, battle|
    next ai.get_score_for_target_stat_raise(score, target, [:DEFENSE, 1])
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("UserTargetSwapAtkSpAtkStages",
  proc { |score, move, user, target, ai, battle|
    user_attack = user.stages[:ATTACK]
    user_spatk = user.stages[:SPECIAL_ATTACK]
    target_attack = target.stages[:ATTACK]
    target_spatk = target.stages[:SPECIAL_ATTACK]
    # Useless if both of the user's stats are already higher than the target's
    next Battle::AI::MOVE_USELESS_SCORE if user_attack >= target_attack && user_spatk >= target_spatk
    # Useless if neither the user nor the target make use of these stats
    useless_attack = !user.check_for_move { |m| m.physicalMove?(m.type) &&
                                                m.function != "UseUserDefenseInsteadOfUserAttack" &&
                                                m.function != "UseTargetAttackInsteadOfUserAttack" }
    useless_attack = false if useless_attack &&
                              target.check_for_move { |m| m.physicalMove?(m.type) &&
                                                          m.function != "UseUserDefenseInsteadOfUserAttack" &&
                                                          m.function != "UseTargetAttackInsteadOfUserAttack" }
    useless_spatk = !user.check_for_move { |m| m.specialMove?(m.type) }
    useless_spatk = false if useless_spatk && target.check_for_move { |m| m.specialMove?(m.type) }
    next Battle::AI::MOVE_USELESS_SCORE if useless_attack && useless_spatk
    # Apply score modifiers
    score += (target_attack - user_attack) * 5 if !useless_attack
    score += (target_spatk - user_spatk) * 5 if !useless_spatk
    next score
  }
)

#===============================================================================
# TODO: Review score modifiers.
# TODO: target should probably be treated as an enemy when deciding the score,
#       since the score will be inverted elsewhere due to the target being an
#       ally.
#===============================================================================
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("UserTargetSwapDefSpDefStages",
  proc { |score, move, user, target, ai, battle|
    user_def = user.stages[:DEFENSE]
    user_spdef = user.stages[:SPECIAL_DEFENSE]
    target_def = target.stages[:DEFENSE]
    target_spdef = target.stages[:SPECIAL_DEFENSE]
    next Battle::AI::MOVE_USELESS_SCORE if user_def >= target_def && user_spdef >= target_spdef
    next score - 20 if user_def + user_spdef >= target_def + target_spdef
    # TODO: Check whether the target has physical/special moves that will be
    #       more resisted after the swap, and vice versa for the user?
    score += (target_def - user_def) * 5
    score += (target_spdef - user_spdef) * 5
    next score
  }
)

#===============================================================================
# TODO: Review score modifiers.
# TODO: target should probably be treated as an enemy when deciding the score,
#       since the score will be inverted elsewhere due to the target being an
#       ally.
#===============================================================================
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("UserTargetSwapStatStages",
  proc { |score, move, user, target, ai, battle|
    user_stages = 0
    target_stages = 0
    target_stage_better = false
    GameData::Stat.each_battle do |s|
      user_stages   += user.stages[s.id]
      target_stages += target.stages[s.id]
      target_stage_better = true if target.stages[s.id] > user.stages[s.id]
    end
    next Battle::AI::MOVE_USELESS_SCORE if !target_stage_better
    score += (target_stages - user_stages) * 10
    next score
  }
)

#===============================================================================
# TODO: Review score modifiers.
# TODO: target should probably be treated as an enemy when deciding the score,
#       since the score will be inverted elsewhere due to the target being an
#       ally.
#===============================================================================
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("UserCopyTargetStatStages",
  proc { |score, move, user, target, ai, battle|
    equal = true
    GameData::Stat.each_battle do |s|
      stagediff = target.stages[s.id] - user.stages[s.id]
      score += stagediff * 10
      equal = false if stagediff != 0
    end
    next Battle::AI::MOVE_USELESS_SCORE if equal   # No stat changes
    next score
  }
)

#===============================================================================
# TODO: Review score modifiers.
# TODO: Account for stat theft before damage calculation.
# TODO: target should probably be treated as an enemy when deciding the score,
#       since the score will be inverted elsewhere due to the target being an
#       ally.
#===============================================================================
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("UserStealTargetPositiveStatStages",
  proc { |score, move, user, target, ai, battle|
    num_stages = 0
    GameData::Stat.each_battle do |s|
      num_stages += target.stages[s.id] if target.stages[s.id] > 0
    end
    if num_stages > 0
      next Battle::AI::MOVE_USELESS_SCORE if user.has_active_ability?(:CONTRARY)
      score += num_stages * 5
    end
    next score
  }
)

#===============================================================================
# TODO: target should probably be treated as an enemy when deciding the score,
#       since the score will be inverted elsewhere due to the target being an
#       ally.
#===============================================================================
Battle::AI::Handlers::MoveFailureAgainstTargetCheck.add("InvertTargetStatStages",
  proc { |move, user, target, ai, battle|
    next true if !target.battler.hasAlteredStatStages?
  }
)
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("InvertTargetStatStages",
  proc { |score, move, user, target, ai, battle|
    pos_stages = 0
    neg_stages = 0
    GameData::Stat.each_battle do |s|
      pos_stages += target.stages[s.id] if target.stages[s.id] > 0
      neg_stages += target.stages[s.id] if target.stages[s.id] < 0
    end
    next Battle::AI::MOVE_USELESS_SCORE if pos_stages == 0
    next score + (pos_stages - neg_stages) * 10
  }
)

#===============================================================================
# TODO: Review score modifiers.
# TODO: target should probably be treated as an enemy when deciding the score,
#       since the score will be inverted elsewhere due to the target being an
#       ally.
#===============================================================================
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("ResetTargetStatStages",
  proc { |score, move, user, target, ai, battle|
    avg = 0
    pos_change = false
    any_change = false
    GameData::Stat.each_battle do |s|
      next if target.stages[s.id] == 0
      avg += target.stages[s.id]
      pos_change = true if target.stages[s.id] > 0
      any_change = true
    end
    next Battle::AI::MOVE_USELESS_SCORE if !any_change || !pos_change
    next score + avg * 5
  }
)

#===============================================================================
# TODO: Review score modifiers.
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("ResetAllBattlersStatStages",
  proc { |move, user, ai, battle|
    next true if battle.allBattlers.none? { |b| b.hasAlteredStatStages? }
  }
)
Battle::AI::Handlers::MoveEffectScore.add("ResetAllBattlersStatStages",
  proc { |score, move, user, ai, battle|
    stages = 0
    battle.allBattlers.each do |b|
      totalStages = 0
      GameData::Stat.each_battle { |s| totalStages += b.stages[s.id] }
      if b.opposes?(user.battler)
        stages += totalStages
      else
        stages -= totalStages
      end
    end
    next score + stages * 10
  }
)

#===============================================================================
# TODO: Review score modifiers.
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("StartUserSideImmunityToStatStageLowering",
  proc { |move, user, ai, battle|
    next true if user.pbOwnSide.effects[PBEffects::Mist] > 0
  }
)

#===============================================================================
# TODO: Review score modifiers.
#===============================================================================
Battle::AI::Handlers::MoveEffectScore.add("UserSwapBaseAtkDef",
  proc { |score, move, user, ai, battle|
    aatk = user.rough_stat(:ATTACK)
    adef = user.rough_stat(:DEFENSE)
    next Battle::AI::MOVE_USELESS_SCORE if aatk == adef || user.effects[PBEffects::PowerTrick]   # No flip-flopping
    if adef > aatk   # Prefer a higher Attack
      score += 20
    else
      score -= 20
    end
    next score
  }
)

#===============================================================================
# TODO: Review score modifiers.
# TODO: target should probably be treated as an enemy when deciding the score,
#       since the score will be inverted elsewhere due to the target being an
#       ally.
#===============================================================================
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("UserTargetSwapBaseSpeed",
  proc { |score, move, user, target, ai, battle|
    if user.speed > target.speed
      score += 25
    else
      score -= 25
    end
    next score
  }
)

#===============================================================================
# TODO: Review score modifiers.
# TODO: target should probably be treated as an enemy when deciding the score,
#       since the score will be inverted elsewhere due to the target being an
#       ally.
#===============================================================================
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("UserTargetAverageBaseAtkSpAtk",
  proc { |score, move, user, target, ai, battle|
    user_atk     = user.battler.attack
    user_spatk   = user.battler.spatk
    target_atk   = target.battler.attack
    target_spatk = target.battler.spatk
    next Battle::AI::MOVE_USELESS_SCORE if user_atk > target_atk && user_spatk > target_spatk
    if user_atk + user_spatk < target_atk + target_spatk
      score += 20
    else
      score -= 20
    end
    next score
  }
)

#===============================================================================
# TODO: Review score modifiers.
# TODO: target should probably be treated as an enemy when deciding the score,
#       since the score will be inverted elsewhere due to the target being an
#       ally.
#===============================================================================
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("UserTargetAverageBaseDefSpDef",
  proc { |score, move, user, target, ai, battle|
    user_def   = user.rough_stat(:DEFENSE)
    user_spdef = user.rough_stat(:SPECIAL_DEFENSE)
    target_def   = target.rough_stat(:DEFENSE)
    target_spdef = target.rough_stat(:SPECIAL_DEFENSE)
    next Battle::AI::MOVE_USELESS_SCORE if user_def > target_def && user_spdef > target_spdef
    if user_def + user_spdef < target_def + target_spdef
      score += 20
    else
      score -= 20
    end
    next score
  }
)

#===============================================================================
#
#===============================================================================
Battle::AI::Handlers::MoveEffectAgainstTargetScore.add("UserTargetAverageHP",
  proc { |score, move, user, target, ai, battle|
    next Battle::AI::MOVE_USELESS_SCORE if user.hp >= (user.hp + target.hp) / 2
    mult = (user.hp + target.hp) / (2.0 * user.hp)
    score += 10 * mult if mult >= 1.2
    next score
  }
)

#===============================================================================
# TODO: Review score modifiers.
#===============================================================================
Battle::AI::Handlers::MoveFailureCheck.add("StartUserSideDoubleSpeed",
  proc { |move, user, ai, battle|
    next true if user.pbOwnSide.effects[PBEffects::Tailwind] > 0
  }
)

#===============================================================================
# TODO: Review score modifiers.
# TODO: This code shouldn't make use of target.
#===============================================================================
# StartSwapAllBattlersBaseDefensiveStats
