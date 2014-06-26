require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rdoc/task'

Rake::TestTask.new(:test) do |task|
  task.libs << 'test'
  task.test_files = FileList['test/**/*_test.rb']
end

RDoc::Task.new do |task|
  task.main = 'README.md'
  task.markup = 'tomdoc'
end

desc 'Start and IRB console with Thumbtack loaded'
task :console do
  exec 'irb -Ilib -rthumbtack'
end
