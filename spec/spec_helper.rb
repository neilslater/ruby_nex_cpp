# frozen_string_literal: true

unless ENV['BAZ_DISABLE_SIMPLECOV']
  require 'simplecov'

  SimpleCov.start do
    add_filter '/spec/'
    enable_coverage :branch
    minimum_coverage line: 95, branch: 95
  end
end

require 'baz'
