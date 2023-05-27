#==============================================================================#
#                           | Custom Item Pop UP |                             #
#------------------------------------------------------------------------------#
# To : uzumaki naruto seki      By : DeadMaker               Date : 17/08/2013 #
#==============================================================================#
# O script acrescenta um efeito 'Pop UP' diferente ao se ganhar itens ou gold. #
# É possível fazer o pop up aparecer em qualquer lugar da tela.                #
# Ele também é completamente customizavél, todas informações abaixo.           #
#------------------------------------------------------------------------------#
#                                                                              #
#  Para alterar o local de aparição do 'Pop UP', tem de ser seguir uma linha   #
#  de raciocínio, vejamos abaixo como modificar de forma correta :             #
#                                                                              #
#    Appear_Position = [x,y] #=> Posição onde a janela ficará após aparecer.   #
#                                                                              #
#    Back_Position = [z,c] #=> Posição onde a janela começa e termina.         #
#                                                                              #
#  Sendo, x e z = Posição Horizontal / y e c = Posição Vertical.               #
#  Supondo que :                                                               #
#                                                                              #
#    x = 440 e z = 640                  |                     y = 0 e c = 0    #
#                                                                              #
#  Enfim, a janela irá deslizar do ponto 'z' até o ponto 'x' para aparecer e   #
#  retornario do ponto 'x' ao 'z' para desaparecer. Já o 'y' e 'c' se mantem   #
#  pois possuem os mesmo valores.                                              #
#                                                                              #
#  É possível usar também números negativos para definir a posição da janela.  #
#==============================================================================#

#==============================================================================
# ■ Module Pop UP
#------------------------------------------------------------------------------
# Todas configurações do script se encontram aqui :
#==============================================================================
module Pop_Up_System
 
  Use_Back_Picture = true     #=> Usar imagem de fundo
 
  Picture = "Pop_Up_Bar"      #=> Nome da imagem
 
  Picture_XY = [0,10]         #=> Posição da imagem
 
  Font_Text = "Arial"         #=> Fonte para textos
 
  Font_Size = 16              #=> Tamanho das letras
 
  Font_Color =  Color.new(255, 255, 255, 255) #=> Coloração das letras
 
  Shadow_Text = true          #=> Colocar sombra no texto
 
  Shadow_Color = Color.new(0, 0, 0, 255)      #=> Coloração da sombra
 
  Shadow_Distance = [1,1]     #=> Distancia da sombra (Podem ser usados negativos)
 
  Gold_Text = "Gold"          #=> Texto para Gold
 
  Gold_Icon = "034-Item03"    #=> Nome do ícone para Gold
 
  Addition_Express = " x"     #=> Símbolo para indicar ganho
 
  Show_Loses = true           #=> Mostrar perdas
 
  Icon_Position = [28,2]      #=> Posição do ícone na janela
 
  Text_Align = 0              #=> Alinhar texto (0 = Esquerda)
 
  Text_Position = [58,1]      #=> Posição do texto na janela
   
  Appear_Speed = 2            #=> Velocidade de entrada da janela
 
  Exit_Speed = 4              #=> Velocidade de saida da janela
 
  Duration_Effect = 60        #=> Tempo que a janela fica na tela
 
  Show_Icons = true           #=> Mostrar Ícones dos itens
 
  Window_Opacity = 0          #=> Opacidade da janela
 
  Window_Size = [220,78]      #=> Tamanho da janela (Largura/Altura)
 
  Appear_Position = [-16,400] #=> Posição da janela exibida
 
  Back_Position = [-220,400]  #=> Posição da janela escondida
 
end
#==============================================================================#
#                              | Fim do Script |                               #
#==============================================================================#

#==============================================================================
# ■ Game_System
#------------------------------------------------------------------------------
# Esta classe trata dos dados do sistema, coisas como BGM, SE, ME, etc.
# Esta classe pode ser chamada utilizando $game_system
#==============================================================================
class Game_System
 
  attr_accessor :item_pop_up
  attr_accessor :pop_up_reserve
 
end

#==============================================================================
# ■ Interpreter (Parte 4)
#------------------------------------------------------------------------------
# É a classe que interpreta os comandos de eventos do jogo.
# É usada dentro da classe Game_Event e Game_System.
#==============================================================================
class Interpreter
 
  alias item_pop_up_gain_gold command_125
 
  def command_125
    n = operate_value(@parameters[0], @parameters[1], @parameters[2])
    if Pop_Up_System::Show_Loses == false and n > 0 or
      Pop_Up_System::Show_Loses == true and n != 0
      if $game_system.item_pop_up.nil?
        $game_system.item_pop_up = [true,'G',n]
      else
        $game_system.pop_up_reserve.push([true,'G',n])
      end
    end
    item_pop_up_gain_gold
  end
 
  alias item_pop_up_gain_item command_126
 
  def command_126
    item_id = @parameters[0]
    n = operate_value(@parameters[1], @parameters[2], @parameters[3])
    if Pop_Up_System::Show_Loses == false and n > 0 and item_id > 0 or
      Pop_Up_System::Show_Loses == true and n != 0 and item_id > 0
      if $game_system.item_pop_up.nil?
        $game_system.item_pop_up = [true,$data_items[item_id],n]
      else
        $game_system.pop_up_reserve.push([true,$data_items[item_id],n])
      end
    end
    item_pop_up_gain_item
  end
 
  alias item_pop_up_gain_weapon command_127
 
  def command_127
    weapon_id = @parameters[0]
    n = operate_value(@parameters[1], @parameters[2], @parameters[3])
    if Pop_Up_System::Show_Loses == false and n > 0 and weapon_id > 0 or
      Pop_Up_System::Show_Loses == true and n != 0 and weapon_id > 0
      if $game_system.item_pop_up.nil?
        $game_system.item_pop_up = [true,$data_weapons[weapon_id],n]
      else
        $game_system.pop_up_reserve.push([true,$data_weapons[weapon_id],n])
      end
    end
    item_pop_up_gain_weapon
  end
 
  alias item_pop_up_gain_armor command_128
 
  def command_128
    armor_id = @parameters[0]
    n = operate_value(@parameters[1], @parameters[2], @parameters[3])
    if Pop_Up_System::Show_Loses == false and n > 0 and armor_id > 0 or
      Pop_Up_System::Show_Loses == true and n != 0 and armor_id > 0
      if $game_system.item_pop_up.nil?
        $game_system.item_pop_up = [true,$data_armors[armor_id],n]
      else
        $game_system.pop_up_reserve.push([true,$data_armors[armor_id],n])
      end
    end
  end
 
end

#==============================================================================
# ■ Scene_Map
#------------------------------------------------------------------------------
# Esta classe processa a tela de Mapa
#==============================================================================
class Scene_Map
 
  alias item_pop_up_initialize initialize
 
  def initialize
    item_pop_up_initialize
    if $game_system.pop_up_reserve == nil
      $game_system.pop_up_reserve = []
    end
  end
 
  alias item_pop_up_main main
 
  def main
    $game_screen.show_pop_up_window if $game_system.item_pop_up != nil
    item_pop_up_main
    $game_screen.hide_pop_up_window if $game_system.item_pop_up != nil
  end
 
end

#==============================================================================
# ■ Game_Screen
#------------------------------------------------------------------------------
# Esta é a classe que reúne os dados da Tela, Tom, Flash, etc...
# Esta classe pode ser chamada utilizando $game_screen
#==============================================================================
class Game_Screen
 
  alias screen_item_pop_up_initialize initialize
 
  def initialize
    screen_item_pop_up_initialize
    @pop_up_turn = 0 ; @pop_up_count = 0 ; @pop_up_count2 = 0
  end
 
  alias item_pop_up_update update
 
  def update
    item_pop_up_update
    unless $game_temp.in_battle
      if $game_system.item_pop_up != nil and $game_system.item_pop_up[0] == true
        create_pop_up_window
      elsif $game_system.item_pop_up != nil and $game_system.item_pop_up[0] == false
        update_pop_up_move
      end
    end
  end
 
  def hide_pop_up_window
    @item_pop_up.refresh(true)
  end
 
  def show_pop_up_window
    @item_pop_up.refresh(false)
  end
 
  def create_pop_up_window
    @item_pop_up = Window_Item_Pop_Up.new
    @item_pop_up.x = Pop_Up_System::Back_Position[0]
    $game_system.item_pop_up[0] = false
  end
 
  def update_pop_up_move
    xy = Pop_Up_System::Appear_Position
    zb = Pop_Up_System::Back_Position
    if @pop_up_turn == 0
      pop_up_entrance_update(xy)
    elsif @pop_up_turn == 1
      @pop_up_count += 1
      if @pop_up_count >= Pop_Up_System::Duration_Effect
        @pop_up_count = 0
        @pop_up_turn = 2
      end
    elsif @pop_up_turn == 2
        pop_up_exit_update(zb)
    end
  end
 
  def pop_up_entrance_update(xy)
    if @item_pop_up.x < xy[0]
      @item_pop_up.x += Pop_Up_System::Appear_Speed
    elsif @item_pop_up.x > xy[0]
      @item_pop_up.x -= Pop_Up_System::Appear_Speed
    end
    if @item_pop_up.y < xy[1]
      @item_pop_up.y += Pop_Up_System::Appear_Speed
    elsif @item_pop_up.y > xy[1]
      @item_pop_up.y -= Pop_Up_System::Appear_Speed
    end
    if @item_pop_up.x == xy[0] and @item_pop_up.y == xy[1]
      @pop_up_turn = 1
      @item_pop_up.x = xy[0]
      @item_pop_up.y = xy[1]
    end
  end
 
  def pop_up_exit_update(zb)
    if @item_pop_up.x < zb[0]
      @item_pop_up.x += Pop_Up_System::Exit_Speed
    elsif @item_pop_up.x > zb[0]
      @item_pop_up.x -= Pop_Up_System::Exit_Speed
    end
    if @item_pop_up.y < zb[1]
      @item_pop_up.y += Pop_Up_System::Exit_Speed
    elsif @item_pop_up.y > zb[1]
      @item_pop_up.y -= Pop_Up_System::Exit_Speed
    end
    if @item_pop_up.x == zb[0] and @item_pop_up.y == zb[1]
      @pop_up_turn = 0
      @item_pop_up.x = zb[0]
      @item_pop_up.y = zb[1]
      @item_pop_up.dispose
      pop_up_reserve_come
    end
  end
 
  def pop_up_reserve_come
    if $game_system.pop_up_reserve.size > 0
      $game_system.item_pop_up = $game_system.pop_up_reserve[0]
      $game_system.pop_up_reserve.shift
    else
      $game_system.item_pop_up = nil
    end
  end
 
end

#==============================================================================
# ■ Window_Item_Pop_Up
#------------------------------------------------------------------------------
# Janela responsavél por processar e 'desenhar' os dados do itens.
#==============================================================================
class Window_Item_Pop_Up < Window_Base
 
  include Pop_Up_System
 
  def initialize
    xy = Back_Position ; wh = Window_Size
    super(xy[0],xy[1],wh[0],wh[1])
    self.contents = Bitmap.new(width - 32, height - 32)
    self.opacity = Window_Opacity
    self.contents.font.name = Font_Text
    self.contents.font.size = Font_Size
    refresh
  end
 
  def refresh(scene=false)
    self.contents.clear
    return if scene == true
    if Use_Back_Picture == true
      back = RPG::Cache.picture(Picture)
      rect = Rect.new(0, 0, back.width, back.height)
      self.contents.blt(Picture_XY[0], Picture_XY[1], back, rect)
    end
    data = $game_system.item_pop_up
    xy = Text_Position
    data[2] < 0 ? symbol = ' ' : symbol = Addition_Express
    if data[1] != 'G'
      text = data[1].name + symbol + data[2].to_s
    else
      text = Gold_Text + symbol + data[2].to_s
    end
    if Shadow_Text == true
      self.contents.font.color = Shadow_Color
      shw = Shadow_Distance
      self.contents.draw_text(xy[0]+shw[0], xy[1]+shw[1], Window_Size[0], 32, text, Text_Align)
    end
    self.contents.font.color = Font_Color
    self.contents.draw_text(xy[0], xy[1], Window_Size[0], 32, text, Text_Align)
    case Text_Align
    when 0
      ix = Icon_Position[0]
    when 1
      more = contents.text_size(text).width
      ix = ((Window_Size[0] / 2) + xy[0]) - (more / 2) - 28
    when 2
      more = contents.text_size(text).width
      ix = (Window_Size[0] / 2) + (xy[0] + more) + 4
    end
    if Show_Icons == true
      if data[1] != 'G'
        draw_icon(data[1].icon_name, ix, Icon_Position[1])
      else
        draw_icon(Gold_Icon, ix, Icon_Position[1])
      end
    end
  end
 
  def draw_icon(icon,x,y)
    bitmap = RPG::Cache.icon(icon)
    self.contents.blt(x, y, bitmap, Rect.new(0, 0, 24, 24))
  end
 
end
#==============================================================================#
#                              | Fim do Script |                               #
#==============================================================================#
