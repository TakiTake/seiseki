require 'benchmark'
require "rubygems"
require "bundler/setup"

Bundler.require

@root = File.expand_path('..', __FILE__)
@start = Date.new(2000,  1,  1)
@end   = Date.new(2009, 12, 31)

require File.join(@root, '/lib/model.rb')

namespace :db do
  desc 'Take the benchmark of the insert'
  task :save do
    def save(&block)
      prng = Random.new(1234)

      # Date loop
      @start.step(@end).each do |date|
        # Student loop
        100.times do |n|
          student_id = '%03d' % n
          scores = 5.times.map{ prng.rand(0..100) }
          attrs = [date.to_s, student_id, *scores]

          yield(attrs)
        end
      end
    end

    Normal.create
    Binary.create

    Benchmark.bm do |x|
      x.report('normal') do
        save{ |attrs| Normal.new.save(attrs) }
      end

      x.report('binary') do
        save{ |attrs| Binary.new.save(attrs) }
      end
    end
  end

  desc 'Take the benchmark of the select'
  task :select do
    def select
      @start.step(@end).each do |date|
        yield(date.to_s)
      end
    end

    Benchmark.bm do |x|
      x.report('normal') do
        select{ |date| Normal.find_by_date(date) }
      end

      x.report('binary') do
        select{ |date| Binary.find_by_date(date) }
      end
    end
  end
end
