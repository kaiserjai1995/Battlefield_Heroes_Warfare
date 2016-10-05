require 'rubyscript2exe'
require "rubygems"
require 'gosu'
require 'gosu_texture_packer'
require 'perlin_noise'

RUBYSCRIPT2EXE.rubyw = true
APPLICATION_PATH = RUBYSCRIPT2EXE.exedir
exit if RUBYSCRIPT2EXE.is_compiling?

root_dir = File.dirname(__FILE__)
require_pattern = File.join(root_dir, '**/*.rb')
@failed = []

Dir.glob(require_pattern).each do |f|
  next if f.end_with?('_spec.rb')
  next if f.end_with?('/main.rb')
  begin
    require_relative f.gsub("#{root_dir}/", '')
  rescue
    @failed << f
  end
end

@failed.each do |f|
  require_relative f.gsub("#{root_dir}/", '')
end

$debug = false
$window = GameWindow.new
GameState.switch(MenuState.instance)
$window.show
