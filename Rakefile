# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"
require "thumbtack/version"

Rake::TestTask.new(:test) do |task|
  task.libs << "test"
  task.test_files = FileList["test/**/*_test.rb"]
end

namespace :test do
  Rake::TestTask.new(:unit) do |task|
    task.libs << "test"
    task.test_files = FileList["test/**/*_test.rb"] -
      FileList["test/thumbtack/integration/**_test.rb"]
  end
end

desc "Start an IRB console with Thumbtack loaded"
task :console do
  exec "irb -Ilib -rthumbtack"
end

task default: "test:unit"
