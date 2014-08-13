require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rdoc/task'
require 'thumbtack/version'

Rake::TestTask.new(:test) do |task|
  task.libs << 'test'
  task.test_files = FileList['test/**/*_test.rb']
end

RDoc::Task.new do |task|
  task.main = 'README.md'
  task.markup = 'tomdoc'
  task.rdoc_files.include("README.md", "lib/**/*.rb")
  task.title = "Thumbtack #{Thumbtack::VERSION} Documentation"
end

desc 'Start and IRB console with Thumbtack loaded'
task :console do
  exec 'irb -Ilib -rthumbtack'
end
