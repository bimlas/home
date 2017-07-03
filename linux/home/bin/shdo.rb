#!/bin/env ruby
# shdo: Execute shell command on several (tagged) paths at once
#
# Usage: shdo {ACTION} {TAGS} {TARGET}
#
# ACTION: See Action module
# TAGS:   List of tags, like `!home !work`; `!ALL` is predefined
#         Subdir can be used, for example if `!home` contains `~/.vim` and
#         `~/bin` then `!home/bin` means `~/bin`
# TARGET: Shell command or path (depends on action)

# Manage tags and paths
module Tags
  DATABASE = File.absolute_path(File.expand_path('~/.shdo/'))

  def self.init_database
    return if File.exist?(Tags::DATABASE)
    Dir.mkdir Tags::DATABASE
  end

  def self.list_tags
    Dir[File.join(Tags::DATABASE, '*')].map {|tag| File.basename(tag)}
  end

  def self.list_paths(tag)
    targets = if tag.match(%r{^ALL(/|$)})
      subdir = tag.match(%r{(?<=^ALL).+})
      list_tags.map {|t| "#{t}#{subdir unless subdir.nil?}"}
    else
      [tag]
    end
    paths = []
    targets.each {|target| paths += resolve_paths(target)}
    paths.sort.uniq
  end

  def self.assign(tags, paths)
    paths = "\n" + paths.map do |path|
      File.absolute_path(File.expand_path(path))
    end.join("\n")
    tags.each do |tag|
      File.open(File.join(Tags::DATABASE, tag), 'a') do |tag_file|
        tag_file.write(paths)
      end
    end
  end

  def self.resolve_paths(target)
    paths = []
    subs = target.match(%r{^([^\/]+)\/?(.*)})
    tag = subs[1]
    subdir = subs[2]
    File.foreach File.join(Tags::DATABASE, tag) do |path|
      path.chomp!
      next if path.empty? ||
              (!subdir.empty? && !path.match(%r{[\/\\]#{subdir}[\/\\]?$}))
      paths.push(path)
    end
    paths
  end
end

# Available actions
module Action
  # List paths related to tags
  #
  # List all tags and paths:
  #   list
  #
  # List paths associated to given tags:
  #   list !my !cool !tags
  def self.list(args)
    (args[:tags].empty? ? Tags.list_tags : args[:tags]).each do |tag|
      puts("\n==== #{tag}\n#{Tags.list_paths(tag).join("\n")}")
    end
  end

  # Associate tags with paths
  #
  # Add `~/.vim` and `~/bin` to `!home` and `!work` tags:
  #   add !home !work ~/.vim ~/bin
  def self.add(args)
    Tags.assign(args[:tags], args[:other])
    Action.list(args)
  end

  # Execute shell command on given tags
  #
  # Run `git status` on `!home` and `!work` tags:
  #   run !home !work git status
  def self.run(args)
    args[:tags].each do |tag|
      puts("\n==== #{tag}")
      Tags.list_paths(tag).each do |path|
        puts("\n---- #{File.basename(path)} (#{File.dirname(path)})")
        Dir.chdir(path) do
          system(args[:other].join(' '))
        end
      end
    end
  end
end

# Separate tags from other elements: the first element which does not seems to
# be tag separates the arguments.
#
#   >> parse_arguments(['!a', '!b', 'c'])
#   => {:tags => ['a', 'b'], :other => ['c']}
#   >> parse_arguments(['!a', 'b', '!c'])
#   => {:tags => ['a'], :other => ['b', '!c']}
#   >> parse_arguments(['a', '!b', '!c'])
#   => {:tags => [], :other => ['a', '!b', '!c']}
def parse_arguments(args)
  tags = []
  while !args.empty? && args[0][0] == '!'
    # Remove prefix form tag name.
    tags.push(args.shift[1..-1])
  end
  {tags: tags, other: args}
end

if ARGV.empty? || !(Action.methods - Object.methods).include?(ARGV[0].to_sym)
  puts 'HELP'
  exit
end

puts "INITIALIZED DATABASE: #{Tags::DATABASE}" if Tags.init_database

Action.send ARGV[0], parse_arguments(ARGV[1..-1])
