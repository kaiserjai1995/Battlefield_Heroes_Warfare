require 'singleton'
class MenuState < GameState
  include Singleton
  attr_accessor :play_state

  def initialize
    @message = Gosu::Image.from_text(
      $window, "Battlefield Heroes Warfare v1.0\n",
      Utils.title_font, 47)
  end

  def enter
    music.play(true)
    music.volume = 2
  end

  def leave
    music.volume = 0
    music.stop
  end

  def music
    @@music ||= Gosu::Song.new(
      $window, Utils.media_path('menu_music.ogg'))
  end

  def update
    text = "[N] - Start a New Game\n[D] - See Gameplay Demonstration\n[X] - Exit Game\n"
    text << "\n[R] - Resume Play" if @play_state
    @info = Gosu::Image.from_text(
      $window, text,
      Utils.main_font, 30)
  end

  def draw
    @message.draw(
      $window.width / 2 - @message.width / 2,
      $window.height / 2 - @message.height / 2,
      10)
    @info.draw(
      $window.width / 2 - @info.width / 2,
      $window.height / 2 - @info.height / 2 + 100,
      10)
  end

  def button_down(id)
    $window.close if id == Gosu::KbX
    if id == Gosu::KbR && @play_state
      GameState.switch(@play_state)
    end
    if id == Gosu::KbN
      @play_state = PlayState.new
      GameState.switch(@play_state)
    end
    if id == Gosu::KbD
      @play_state = DemoState.new
      GameState.switch(@play_state)
    end
  end
end
