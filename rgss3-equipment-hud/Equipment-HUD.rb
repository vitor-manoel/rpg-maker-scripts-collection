#==============================================================================#
#                           VMS - Armors In Map                           #
#------------------------------------------------------------------------------#
# To : CRM                      By : DeadMaker               Date : 16/04/2012 #
#==============================================================================#
#           Janela responsável por todas funções gráficas do script.           #
#==============================================================================#

class Vms_Equip_In_Map < Window_Base
 
include Vms_Equip_In_Map_EQP
 
  def initialize
    @cond = Hori_Vert.downcase
    super(Position_X_Y[0],Position_X_Y[1],544,544)
    self.opacity = Window_Opacity
    self.back_opacity = Window_Opacity
    self.contents.font.name = Font_Name
    self.contents.font.size = Font_Size
    self.arrows_visible = false
    self.width = 0 ; self.height = 0 ; $vms_equip_i_map_sctp = @act = 0
    Graphics.update
    Graphics.transition
    refresh
  end
 
  def refresh
    self.contents.clear
    @act = $vms_equip_i_map_sctp ; actor = $game_party.members[@act]
    armors = [[actor.equips[0], actor.equips[1], actor.equips[2],
    actor.equips[3], actor.equips[4]],[0,1,2,3,4]]
    tbl = armors[1] ; tbz = armors[0] ; ip = Icon_Position
    if Has_Switche == nil or $game_switches[Has_Switche] == true
    self.opacity = Window_Opacity
    if Window_Picture == "Picture"
      for n in 0..4
        op = Cache.picture("Equipament_Hud")
        opw = op.width
        oph = op.height
        op_rect = Rect.new(0,0,opw,oph)
        if @cond == "vertical"
          xz = 0 ; yz = (n * oph) + (Space_Base * n)
        else
          xz = (n * opw) + (Space_Base * n) ; yz = 0
        end
        self.contents.blt(xz,yz,op,op_rect)
      end
      if @cond == "vertical"
        plus = [opw + (12 * 2),(5 * oph) + (12 * 2)]
      else
        plus = [(5 * opw) + (12 * 2),oph + (12 * 2)]
      end
    else
      if @cond == "vertical"
        plus = [24 + (12 * 2) + (Icon_Position[0]),(6 * 24) + (Space_Base * 5) + (12 * 2)]
      else
        plus = [(6 * 24) + (Space_Base * 5) + (12 * 2),24 + (12 * 2) + (Icon_Position[1])]
      end
    end
    if @cond == "vertical"
      w = plus[0]
      h = ((plus[1]) + (Space_Base * 5))
    else
      w = ((plus[0]) + (Space_Base * 5))
      h = plus[1]
    end
    self.width = w ; self.height = h
    for i in tbl
      other_i = i
      if @cond == "vertical"
        x = 0 + ip[0] ; y = (24 * i) + ((Space_Icons * i) + ip[1])
      else
        x = (24 * i) + ((Space_Icons * i) + ip[0]) ; y = 0 + ip[1]
      end
      dwii_vms_eqp(tbz[i], x, y)
    end
    if Show_atk_def_texts == true
        a_color = Atk_Color ; d_color = Def_Color
        change_color(a_color)
        if @cond == "vertical"
          vezes_x = [0,0,0,0,0] ; vezes_y = [0,1,2,3,4]
        else
          vezes_x = [0,1,2,3,4] ; vezes_y = [0,0,0,0,0]
        end
        c_1 = Atk_T_x_y[0] ; c_2 = Atk_T_x_y[1] ; c_3 = Def_T_x_y[0]
        c_4 = Def_T_x_y[1] ; c_5 = Text_Space ; c_6 = vezes_x ; c_7 = vezes_y
        draw_text(c_1 + (c_5 * c_6[0]),c_2 + (c_5 * c_7[0]),132,32,Atk_Text,1) if tbz[0] != nil
        draw_text(c_1 + (c_5 * c_6[1]),c_2 + (c_5 * c_7[1]),132,32,Atk_Text,1) if tbz[1] != nil
        draw_text(c_1 + (c_5 * c_6[2]),c_2 + (c_5 * c_7[2]),132,32,Atk_Text,1) if tbz[2] != nil
        draw_text(c_1 + (c_5 * c_6[3]),c_2 + (c_5 * c_7[3]),132,32,Atk_Text,1) if tbz[3] != nil
        draw_text(c_1 + (c_5 * c_6[4]),c_2 + (c_5 * c_7[4]),132,32,Atk_Text,1) if tbz[4] != nil
        change_color(d_color)
        draw_text(c_3 + (c_5 * c_6[0]),c_4 + (c_5 * c_7[0]),132,32,Def_Text,1) if tbz[0] != nil
        draw_text(c_3 + (c_5 * c_6[1]),c_4 + (c_5 * c_7[1]),132,32,Def_Text,1) if tbz[1] != nil
        draw_text(c_3 + (c_5 * c_6[2]),c_4 + (c_5 * c_7[2]),132,32,Def_Text,1) if tbz[2] != nil
        draw_text(c_3 + (c_5 * c_6[3]),c_4 + (c_5 * c_7[3]),132,32,Def_Text,1) if tbz[3] != nil
        draw_text(c_3 + (c_5 * c_6[4]),c_4 + (c_5 * c_7[4]),132,32,Def_Text,1) if tbz[4] != nil
        change_color(normal_color) ; p = Valor_Space
        draw_text(c_1 + (c_5 * c_6[0]) + p,c_2 + (c_5 * c_7[0]),132,32," #{tbz[0].params[2]}",1) if tbz[0] != nil
        draw_text(c_3 + (c_5 * c_6[0]) + p,c_4 + (c_5 * c_7[0]),132,32," #{tbz[0].params[3]}",1) if tbz[0] != nil
        draw_text(c_1 + (c_5 * c_6[1]) + p,c_2 + (c_5 * c_7[1]),132,32," #{tbz[1].params[2]}",1) if tbz[1] != nil
        draw_text(c_3 + (c_5 * c_6[1]) + p,c_4 + (c_5 * c_7[1]),132,32," #{tbz[1].params[3]}",1) if tbz[1] != nil
        draw_text(c_1 + (c_5 * c_6[2]) + p,c_2 + (c_5 * c_7[2]),132,32," #{tbz[2].params[2]}",1) if tbz[2] != nil
        draw_text(c_3 + (c_5 * c_6[2]) + p,c_4 + (c_5 * c_7[2]),132,32," #{tbz[2].params[3]}",1) if tbz[2] != nil
        draw_text(c_1 + (c_5 * c_6[3]) + p,c_2 + (c_5 * c_7[3]),132,32," #{tbz[3].params[2]}",1) if tbz[3] != nil
        draw_text(c_3 + (c_5 * c_6[3]) + p,c_4 + (c_5 * c_7[3]),132,32," #{tbz[3].params[3]}",1) if tbz[3] != nil
        draw_text(c_1 + (c_5 * c_6[4]) + p,c_2 + (c_5 * c_7[4]),132,32," #{tbz[4].params[2]}",1) if tbz[4] != nil
        draw_text(c_3 + (c_5 * c_6[4]) + p,c_4 + (c_5 * c_7[4]),132,32," #{tbz[4].params[3]}",1) if tbz[4] != nil
      end
    elsif $game_switches[Has_Switche] == false
      self.opacity = 0
    end
  end
 
end

#==============================================================================#
#                             VMS - Scene_Map                             #
#------------------------------------------------------------------------------#
#          Modificação no Scene_Map para funcionalidades com script.           #
#==============================================================================#
class Scene_Map
 
alias eqp_w_vms_m main

  def main
    @eqp_w_vms = Vms_Equip_In_Map.new
    eqp_w_vms_m
    @eqp_w_vms.dispose
  end
 
alias eqp_w_vms_u update

  def update
    eqp_w_vms_u
    if Input.trigger?(Vms_Equip_In_Map_EQP::Input_To_Window) and
      @eqp_w_vms.visible == true
      @eqp_w_vms.visible = false
    elsif Input.trigger?(Vms_Equip_In_Map_EQP::Input_To_Window) and
      @eqp_w_vms.visible == false
      @eqp_w_vms.visible = true
    end
    if Input.trigger?(Vms_Equip_In_Map_EQP::Other_Actor_Down)
      if $vms_equip_i_map_sctp == 1 and $game_party.members.size >= 2
        $vms_equip_i_map_sctp = 0
      elsif $vms_equip_i_map_sctp == 2 and $game_party.members.size >= 3
        $vms_equip_i_map_sctp = 1
      elsif $vms_equip_i_map_sctp == 3 and $game_party.members.size >= 4
        $vms_equip_i_map_sctp = 2
      end
    elsif Input.trigger?(Vms_Equip_In_Map_EQP::Other_Actor_Up)
      if $vms_equip_i_map_sctp == 0 and $game_party.members.size >= 2
        $vms_equip_i_map_sctp = 1
      elsif $vms_equip_i_map_sctp == 1 and $game_party.members.size >= 3
        $vms_equip_i_map_sctp = 2
      elsif $vms_equip_i_map_sctp == 2 and $game_party.members.size >= 4
        $vms_equip_i_map_sctp = 3
      elsif $vms_equip_i_map_sctp == $game_party.members.size - 1
        $vms_equip_i_map_sctp = 0
      end
    end
    if $andando == true
      @eqp_w_vms.refresh if Graphics.frame_count % 10 == 0
    else 
      @eqp_w_vms.refresh if Graphics.frame_count % 10 == 0
    end
  end
 
end

#==============================================================================#
#                            VMS - Window_Base                            #
#------------------------------------------------------------------------------#
#          Modificação na Window_Base para funcionalidades com script.         #
#==============================================================================#

class Window_Base < Window
 
  def dwii_vms_eqp(item, x, y, enabled = true, width = 172)
    return unless item
    draw_icon(item.icon_index, x, y, enabled)
    change_color(normal_color, enabled)
  end
 
end

#==============================================================================#
#                               Fim do Script                             #
#------------------------------------------------------------------------------#
