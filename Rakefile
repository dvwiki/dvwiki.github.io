CURRENTPATH = File.expand_path(File.dirname(__FILE__))
LIBPATH     = File.join(File.expand_path(CURRENTPATH), 'lib')

$LOAD_PATH.unshift(LIBPATH) unless $LOAD_PATH.include?(LIBPATH)

require 'colorize'
require 'ruby-progressbar'

require 'wiki_builder'

PROGRESS_FORMAT = '%t: |%w%i| %E'

task default: [:settings] do
  puts 'Einstellungen:'.bold.cyan
  puts 'Aktuelles Verzeichnis:'.cyan.underline + ' ' + CURRENTPATH.blue
  puts 'Quelldateien:'.cyan.underline + ' ' + WikiBuilder::Settings[:articles]
  puts 'Base URL:'.cyan.underline + ' ' + WikiBuilder::Settings[:base]
  puts 'git-url:'

  puts 'Artikel-Index existiert?'.cyan.underline +
    ' ' +
    WikiBuilder::Settings.index_exists_as_string?

  progressbar = ProgressBar.create(title:  'Erstelle Index',
                                   format: PROGRESS_FORMAT)

  100.times do
    progressbar.increment
    sleep 0.01
  end
end

task :settings do
  WikiBuilder::Settings.load
end

tests = []
unless Gem.find_files('yard').empty?
  require 'yard'

  desc 'Generate documentation via yard'
  YARD::Rake::YardocTask.new(:doc)

  tests << :docstat
  YARD::Rake::YardocTask.new(:docstat) do |t|
    t.options << '--no-private'
    t.stats_options << '--list-undoc'
  end
end

unless Gem.find_files('rubocop').empty?
  tests << :rubocop
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new do |t|
    t.formatters = ['fuubar']
    t.fail_on_error = false
  end
end

desc 'Run tests'
task test: tests do
  puts tests.inspect
end
