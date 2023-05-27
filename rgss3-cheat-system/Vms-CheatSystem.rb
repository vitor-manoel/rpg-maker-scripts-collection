#===============================================================================
#                           VMS - Cheat System                            
#-------------------------------------------------------------------------------
# To : RMB                      By : DeadMaker               Date : 17/10/2012
#===============================================================================
#                ~Não poste ou modifique o script sem permissão~               
#-------------------------------------------------------------------------------
#                     Configure o script no módulo abaixo :   
#===============================================================================
# * Configurando Items ('I') :
#===============================================================================
#
#~ Cheats[Cheat ID] = ["Cheat Code",'I',Item ID,Number]
#
#  Cheat ID = ID único do cheat.
#
#  Cheat Code = Código necessário para ativar cheat.
#
#  'I' = Tipo de alteração do cheat.
#
#  Item ID = ID do item que o personagem vai ganhar.
#
#  Number = Número destes mesmos items.
#
#===============================================================================
# * Configurando Skins ('S') :
#===============================================================================
#
#~ Cheats[Cheat ID] = ["Cheat Code",'S',Skin,Index]
#
#  Cheat ID = ID único do cheat.
#
#  Cheat Code = Código necessário para ativar cheat.
#
#  'S' = Tipo de alteração do cheat.
#
#  Skin = Nome do novo gráfico do personagem. (Pasta Characters)
#
#  Index = Índice do personagem. (1~8)
#
#===============================================================================
# * Configurando Classes ('C') :
#===============================================================================
#
#~ Cheats[Cheat ID] = ["Cheat Code",'C',Class ID,Total Exp]
#
#  Cheat ID = ID único do cheat.
#
#  Cheat Code = Código necessário para ativar cheat.
#
#  'C' = Tipo de alteração do cheat.
#
#  Class ID = ID da classe para qual sera alterada.
#
#  Total Exp = Manter experiência da classe anterior.
#
#===============================================================================
# * Configurando Skills ('H') :
#===============================================================================
#
#~ Cheats[Cheat ID] = ["Cheat Code",'H',Skill ID]
#
#  Cheat ID = ID único do cheat.
#
#  Cheat Code = Código necessário para ativar cheat.
#
#  'H' = Tipo de alteração do cheat.
#
#  Skill ID = ID da skill que irá ser aprendida.
#
#===============================================================================
# * Configurando Membros ('M') :
#===============================================================================
#
#~ Cheats[Cheat ID] = ["Cheat Code",'M',ID Member]
#
#  Cheat ID = ID único do cheat.
#
#  Cheat Code = Código necessário para ativar cheat.
#
#  'M' = Tipo de alteração do cheat.
#
#  ID Member = ID do membro a ser adicionado.
#
#===============================================================================
# * Configurando Experiência ('E') :
#===============================================================================
#
#~ Cheats[Cheat ID] = ["Cheat Code",'E',Exp Number]
#
#  Cheat ID = ID único do cheat.
#
#  Cheat Code = Código necessário para ativar cheat.
#
#  'E' = Tipo de alteração do cheat.
#
#  Exp Number = Valor em experiência a ser adiquirida.
#
#===============================================================================
# * Tipos :
#===============================================================================
#
#  'I' = Items                     ~            'H' = Skills
#
#  'S' = Skin                      ~            'M' = Membros
#
#  'C' = Classe                    ~            'E' = Experiência
#
#===============================================================================
module Deshu_Cheat_Module_0x1
 
    Cheats = []
   
  #==================================================================
  # * Definindo e criando novos "Cheats" :                                           
  #------------------------------------------------------------------
 
    Cheats[0] = ["[GT9b]-[J1Sk]-[WB3i]-[7VXs]",'I',1,3]   
 
    Cheats[1] = ["[PK7y]-[3MZq]-[R3Tn]-[HF1l]",'S',"People1",7] 
   
    Cheats[2] = ["[89AD]-[a90s]-[KSHD]-[VOp4]","C",10,false]
 
    Cheats[3] = ["[KP1s]-[PiN8]-[T6yO]-[m3ZD]","H",27]
     
    Cheats[4] = ["[IO4n]-[Cl9K]-[Z0Wl]-[TCh5]","M",8]
   
    Cheats[5] = ["[P2cH]-[Mu9Q]-[SfI6]-[HoNT]","E",100]
   
  #==================================================================
  # * Máximo de characters permitido pelo sistema :                                           
  #------------------------------------------------------------------
   
    Max_Characters = 27
   
  #==================================================================
  # * Teclas necessárias para chamar o sistema de Cheat :                                           
  #------------------------------------------------------------------
 
    Input_Keys = [:C,:R,:UP,:DOWN]
   
  #==================================================================
  # * Usar alguma imagem como fundo ?                                       
  #------------------------------------------------------------------
 
    Picture_ON = nil  #~ Para utilizar escreva o nome de uma imagem da pasta
                      #~ /Pictures/, entre parenteses. Exemplo : "Back Picture"
 
end
#===============================================================================
# Dúvidas ? Acesse : http://www.rpgmakerbrasil.net/forum/profile/?u=54         
#-------------------------------------------------------------------------------
# Me envie uma MP que ajudarei ;)                                             
#===============================================================================

#===============================================================================
#                           VMS - Cheat System                            
#-------------------------------------------------------------------------------
# To : RMB                      By : DeadMaker               Date : 17/10/2012
#===============================================================================
#                ~Não poste ou modifique o script sem permissão~               
#-------------------------------------------------------------------------------
#   Fim das configurações. Só modifique abaixo caso saiba o que esta fazendo !                               
#===============================================================================
class Deshu_Input_Cheat_System_0x1 < Scene_Base
 
include Deshu_Cheat_Module_0x1
 
  def start
    super
    create_windows
    create_background
  end
 
  def create_background
    @background = Sprite.new
    @background.bitmap = SceneManager.background_bitmap
    $game_system.create_deshu_used_cheats_array
  end
 
  def create_windows
    @w1 = Deshu_Input_Cheat_Select_0x1.new
    @w1.x = (544/2) - (@w1.width/2)
    if Picture_ON != nil
      @w1.opacity = 0
      @back = Sprite.new
      @back.bitmap = Cache.picture(Picture_ON)
      @back.x = (544/2) - (@back.width/2)
      @back.y = (416/2) - (@back.height/2)
      @back.z = 15
    end
  end
 
  def update
    super
    if Input.trigger?(:SHIFT)
      @w1.w2_dispose
      SceneManager.call(Scene_Map)
    end
  end
 
  def terminate
    super
    @w1.dispose
    @back.dispose if Picture_ON != nil
  end

end

class Deshu_Input_Cheat_Select_0x1 < Window_Selectable
 
include Deshu_Cheat_Module_0x1

  LATIN1 = [ 'A','B','C','D','E',  'a','b','c','d','e',
             'F','G','H','I','J',  'f','g','h','i','j',
             'K','L','M','N','O',  'k','l','m','n','o',
             'P','Q','R','S','T',  'p','q','r','s','t',
             'U','V','W','X','Y',  'u','v','w','x','y',
             'Z','[',']','^','_',  'z','{','}','|','~',
             '0','1','2','3','4',  '!','#','$','%','&',
             '5','6','7','8','9',  '(',')','*','+','-',
             '/','=','@','<','>',  ':',';',' ','Page','OK']
             
  LATIN2 = [ 'Á','É','Í','Ó','Ú',  'á','é','í','ó','ú',
             'À','È','Ì','Ò','Ù',  'à','è','ì','ò','ù',
             'Â','Ê','Î','Ô','Û',  'â','ê','î','ô','û',
             'Ä','Ë','Ï','Ö','Ü',  'ä','ë','ï','ö','ü',
             'Ā','Ē','Ī','Ō','Ū',  'ā','ē','ī','ō','ū',
             'Ã','Å','Æ','Ç','Ð',  'ã','å','æ','ç','ð',
             'Ñ','Õ','Ø','Š','Ŵ',  'ñ','õ','ø','š','ŵ',
             'Ý','Ŷ','Ÿ','Ž','Þ',  'ý','ÿ','ŷ','ž','þ',
             'Ĳ','Œ','ĳ','œ','ß',  '«','»',' ','Page','OK']
 
  def initialize
    super(0,140,360,240)
    @edit_window = Deshu_Input_Cheat_Window_0x1.new
    @edit_window.opacity = 0 if Picture_ON != nil
    @edit_window.x = (544/2) - (@edit_window.width/2)
    @page = 0
    @index = 0
    refresh
    update_cursor
    activate
  end

  def table
    return [LATIN1, LATIN2]
  end

  def character
    @index < 88 ? table[@page][@index] : ""
  end

  def is_page_change?
    @index == 88
  end

  def is_ok?
    @index == 89
  end
 
  def cheat_id
    return @index
  end

  def item_rect(index)
    rect = Rect.new
    rect.x = index % 10 * 32 + index % 10 / 5 * 16
    rect.y = index / 10 * line_height
    rect.width = 32
    rect.height = line_height
    rect
  end

  def refresh
    contents.clear
    change_color(normal_color)
    90.times {|i| draw_text(item_rect(i), table[@page][i], 1) }
  end

  def update_cursor
    cursor_rect.set(item_rect(@index))
  end

  def cursor_movable?
    active
  end

  def cursor_down(wrap)
    if @index < 80 or wrap
      @index = (index + 10) % 90
    end
  end

  def cursor_up(wrap)
    if @index >= 10 or wrap
      @index = (index + 80) % 90
    end
  end

  def cursor_right(wrap)
    if @index % 10 < 9
      @index += 1
    elsif wrap
      @index -= 9
    end
  end

  def cursor_left(wrap)
    if @index % 10 > 0
      @index -= 1
    elsif wrap
      @index += 9
    end
  end

  def cursor_pagedown
    @page = (@page + 1) % table.size
    refresh
  end

  def cursor_pageup
    @page = (@page + table.size - 1) % table.size
    refresh
  end

  def process_cursor_move
    last_page = @page
    super
    update_cursor
    Sound.play_cursor if @page != last_page
  end

  def process_handling
    return unless open? && active
    process_jump if Input.trigger?(:A)
    process_back if Input.repeat?(:B)
    process_ok   if Input.trigger?(:C)
  end

  def process_jump
    if @index != 89
      @index = 89
      Sound.play_cursor
    end
  end

  def process_back
    Sound.play_cancel if @edit_window.back
  end

  def process_ok
    if !character.empty?
      on_name_add
    elsif is_page_change?
      Sound.play_ok
      cursor_pagedown
    elsif is_ok?
      on_name_ok
    end
  end

  def on_name_add
    if @edit_window.add(character)
      Sound.play_ok
    else
      Sound.play_buzzer
    end
  end

  def on_name_ok
    cheats = $game_system.deshu_used_cheats_0x1
    for i in cheats
      if @edit_window.cheat_code == i[0]
        case i[1]
        when 'I'
          item = $data_items[i[2]]
        when 'W'
          item = $data_weapons[i[2]]
        when 'A'
          item = $data_armors[i[2]]
        end
        if i[1] == 'W' or i[1] == 'I' or i[1] == 'A'
          if i[4] == nil
            $game_party.gain_item(item,i[3])
            i[4] = true
          end
        elsif i[1] == 'E'
          if i[3] == nil
            $game_party.members[0].gain_exp(i[2])
            i[3] = true
          end
        elsif i[1] == 'S'
          if i[4] == nil
            $game_party.members[0].set_graphic(i[2], i[3]-1, i[2], i[3]-1)
            $game_player.set_graphic(i[2], i[3]-1)
            $game_map.need_refresh = true
            for p in cheats
              if p[4] == true
                p[4] = nil
                $game_system.deshu_used_cheats_0x1[cheats.index(p)] = p
              end
            end
            i[4] = true
          end
        elsif i[1] == 'C'
          if i[4] == nil
            $game_party.members[0].change_class(i[2], i[3])
            for p in cheats
              if p[4] == true
                p[4] = nil
                $game_system.deshu_used_cheats_0x1[cheats.index(p)] = p
              end
            end
            i[4] = true
          end
        elsif i[1] == 'H'
          if i[3] == nil
            $game_party.members[0].learn_skill(i[2])
            i[3] = true
          end
        elsif i[1] == 'M'
          if i[3] == nil
            $game_party.add_actor(i[2])
            i[3] = true
          end
        end
        Sound.play_ok
        w2_dispose
      else
        Sound.play_buzzer
        w2_dispose
      end
      $game_system.deshu_used_cheats_0x1[cheats.index(i)] = i
    end
  end
 
  def w2_dispose
    @edit_window.dispose
    SceneManager.call(Scene_Map)
  end
 
end

class Game_System
 
attr_accessor :deshu_used_cheats_0x1

  def create_deshu_used_cheats_array
    if $game_system.deshu_used_cheats_0x1 == nil
      $game_system.deshu_used_cheats_0x1 = Deshu_Cheat_Module_0x1::Cheats
    end
  end
 
  def deshu_necessary_cheat_keys
    round = 0 ; timer = 0
    work = Deshu_Cheat_Module_0x1::Input_Keys
    if Input.press?(work[0])
      loop do
        round += 1
        unless Input.press?(work[round])
          timer += 1
          round -= 1
        end
        if timer >= 5
          return false
        elsif round >= work.size-1
          return true
        end
      end
    end
  end
 
end

class Scene_Map
 
alias deshu_cheat_system_0x1 update

  def update
    deshu_cheat_system_0x1
    if $game_system.deshu_necessary_cheat_keys
      SceneManager.call(Deshu_Input_Cheat_System_0x1)
    end
  end
 
end

class Deshu_Input_Cheat_Window_0x1 < Window_Base

  def initialize
    super(0, 20, 360, 120)
    @max_char = Deshu_Cheat_Module_0x1::Max_Characters
    @default_name = @name = ""
    @index = @name.size
    deactivate
    refresh
  end

  def restore_default
    @name = @default_name
    @index = @name.size
    refresh
    return !@name.empty?
  end

  def add(ch)
    return false if @index >= @max_char
    @name += ch
    @index += 1
    refresh
    return true
  end

  def back
    return false if @index == 0
    @index -= 1
    @name = @name[0, @index]
    refresh
    return true
  end

  def char_width
    text_size($game_system.japanese? ? "あ" : "A").width
  end

  def left
    name_center = (contents_width/2)
    name_width = (@max_char + 1) * char_width
    return [name_center - name_width / 2, contents_width - name_width].min
  end

  def item_rect(index)
    Rect.new(left + index * char_width, 36, char_width, line_height)
  end

  def underline_rect(index)
    rect = item_rect(index)
    rect.x += 1
    rect.y += rect.height - 4
    rect.width -= 2
    rect.height = 2
    rect
  end

  def underline_color
    color = normal_color
    color.alpha = 48
    color
  end
 
  def cheat_code
    return @name
  end

  def draw_underline(index)
    contents.fill_rect(underline_rect(index), underline_color)
  end
 
  def draw_char(index)
    rect = item_rect(index)
    rect.x -= 1
    rect.width += 4
    change_color(normal_color)
    draw_text(rect, @name[index] || "")
  end

  def refresh
    contents.clear
    @max_char.times {|i| draw_underline(i) }
    @name.size.times {|i| draw_char(i) }
  end
 
end
#===============================================================================
#                               * Fim do Sistema *                             
#===============================================================================
