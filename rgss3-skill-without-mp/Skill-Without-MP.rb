#==============================================================================#
#                      | Lose HP Using Skill Without MP |                      #
#------------------------------------------------------------------------------#
# To : everdrive                By : DeadMaker               Date : 22/08/2013 #
#==============================================================================#
# O script permite o personagem usar magias mesmo que não tenha MP, nesse caso #
# a quantidade restante necessária para usar a skill e retirada do HP do herói #
# com dano multiplicado de acordo com suas configurações logo abaixo.          #
#==============================================================================#

#==============================================================================
# ■ Module MCDH
#------------------------------------------------------------------------------
# Todas configurações do script se encontram aqui :
#==============================================================================
module MCDH
 
#============================================================================
# O comando abaixo funciona da seguinte maneira :
#  - Quanto MP a habilidade ainda precisa para ser utilizada * Damage_HP
#  - Então o resultado acima irá ser o valor a se retirar do HP do player
#----------------------------------------------------------------------------
#  - Ex : Caso tenha 10 de MP e a Habilidade precisa de 40.
#  - O MP do personagem enfim se torna 0 e o seguinte cálculo ocorre :
#
#    x = 40 - 10
#    z = x * Damage_HP (No caso é igual a 60)
#
#  - Então o personagem vai perder quantidade de vida igual a "z"
#============================================================================
 
  Damage_HP = 2
 
#============================================================================
# Abaixo você define se só será possível usar magias de recuperação com MP.
#----------------------------------------------------------------------------
#  - true = Usar somente MP / false = Usar MP e se preciso HP
#============================================================================
 
  Recover_Only_MP = true
 
end
#==============================================================================#
#                              | Fim do Script |                               #
#==============================================================================#

#==============================================================================
# ** Game_BattlerBase
#------------------------------------------------------------------------------
#  Esta classe gerencia os battlers. Contém os principais método de
# cálculo da características especiais.
# Esta classe é usada como superclasse da classe Game_Battler.
#==============================================================================
class Game_BattlerBase

  def skill_cost_payable?(skill)
    if skill.damage.recover? and MCDH::Recover_Only_MP == true
      tp >= skill_tp_cost(skill) && mp >= skill_mp_cost(skill)
    else
      if tp >= skill_tp_cost(skill)
        if mp < skill_mp_cost(skill)
          adjust = skill_mp_cost(skill) - mp
        else
          adjust = skill_mp_cost(skill)
        end
        if mp > 0 and mp < skill_mp_cost(skill)
          hp + mp > (adjust * MCDH::Damage_HP) + mp
        else
          mp >= adjust or hp > adjust * MCDH::Damage_HP
        end
      end
    end
  end
 
  alias mp_cost_damage_hp pay_skill_cost
 
  def pay_skill_cost(*args)
    if skill_mp_cost(args[0]) > self.mp
      adjust = skill_mp_cost(args[0]) - self.mp
    end
    mp_cost_damage_hp(*args)
    self.hp -= adjust * MCDH::Damage_HP if adjust != nil
  end
 
end
#==============================================================================#
#                              | Fim do Script |                               #
#==============================================================================#
