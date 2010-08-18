require 'thor'
require 'thor/group'
require 'active_support'

module Dubious
  class Init < Thor::Group
    include Thor::Actions
    argument :name
    source_root File.dirname(__FILE__)+"/templates/base"

    def init
      directory '.', "#{name}/"
    end
    def self.subcommand_help *args
%Q(
Creates a new dubious project application structure in the NAME directory.
Uses NAME as the appengine app name.
)
    end
  end

  class Generator < Thor
    include Thor::Actions
    source_root File.dirname(__FILE__)+"/templates/generator"
    argument :name


    desc "model NAME", "creates model file" 
    def model#(name)
      template "model.mirah.tt", "app/models/#{name.underscore}.mirah"
    end

    desc "controller NAME", "creates controller file"
    def controller#(name)
      template "controller.mirah.tt", "app/controllers/#{name.underscore}_controller.mirah"
      empty_directory "app/views/#{name.underscore}"
    end
  end

  class CLI < Thor
    desc "init NAME", "initializes a new dubious project in NAME"
    subcommand :init, Init

    desc "generate GENERATOR", "run generator GENERATOR"
    subcommand :generate, Generator
  end

end