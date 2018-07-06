require 'plist'
require 'sqlite3'
require 'fileutils'
require 'haml'
require 'ostruct'
require 'uri'
require 'pathname'

class Cheatset::Creator
  def initialize(cheatsheet, filename)
    @cheatsheet = cheatsheet
    @filename = filename
    @docset_path = "#{@cheatsheet.docset_file_name}.docset"
    @path = "#{@docset_path}/Contents/"
  end

  def generate
    FileUtils.rm_rf(@path)
    FileUtils.mkdir_p(@path)
    generate_html_file
    generate_plist_file
    generate_database
  end

  private

  def tpl_path
    File.expand_path('../templates', __FILE__)
  end

  def generate_html_file
    # HTML
    template = File.read("#{tpl_path}/template.haml")
    engine = Haml::Engine.new(template)
    out = engine.render(@cheatsheet)
    doc_path = "#{@path}Resources/Documents/"
    FileUtils.mkdir_p(doc_path)
    File.open("#{doc_path}index.html", 'w') { |file| file.write(out) }

    # (static) CSS
    FileUtils.cp("#{tpl_path}/style.css", doc_path)

    # resources
    FileUtils.cp_r("#{tpl_path}/cheatset_resources", doc_path)
    resources = @cheatsheet.resources
    if resources && !resources.empty?
      if Pathname.new(resources).absolute?
        resources_path = resources
      else
        base_dir = File.dirname(@filename)
        resources_path = "#{base_dir}/#{resources}"
      end

      FileUtils.cp_r(resources_path, doc_path)
    end
  end

  def generate_plist_file
    plist_data = {
      'CFBundleIdentifier' => 'cheatsheet',
      'CFBundleName' => (@cheatsheet.title) ? @cheatsheet.title : 'No Title',
      'DocSetPlatformFamily' => 'cheatsheet',
      'DashDocSetFamily' => 'cheatsheet',
      'isDashDocset' => true,
      'dashIndexFilePath' => 'index.html',
      'DashDocSetPluginKeyword' => (@cheatsheet.platform) ? @cheatsheet.platform : (@cheatsheet.keyword) ? @cheatsheet.keyword : 'cheatsheet',
      'DashDocSetKeyword' => (@cheatsheet.keyword) ? @cheatsheet.keyword : 'cheatsheet'
    }
    File.open("#{@path}Info.plist", 'w') do |file|
      file.write(Plist::Emit.dump(plist_data))
    end
  end

  def generate_database
    sqlite_file = "#{@path}Resources/docSet.dsidx"
    db = SQLite3::Database.new(sqlite_file)
    db.busy_timeout = 100;
    db.execute <<-SQL
      CREATE TABLE searchIndex(id INTEGER PRIMARY KEY, name TEXT,
                               type TEXT, path TEXT);
      CREATE UNIQUE INDEX anchor ON searchIndex (name, type, path);
    SQL

    sql = 'INSERT INTO searchIndex(name, type, path) VALUES (?, ?, ?)'
    db.execute(sql, @cheatsheet.title, 'Category',
               "index.html")
    
    @cheatsheet.categories.each do |category|
      category_strip = URI.escape(category.id.strip).gsub(/\//, '%252F');
      if @cheatsheet.title != category.id
        db.execute(sql, category.id, 'Category',
                 "index.html\#//dash_ref/Category/#{category_strip}/1")
      end
      category.entries.each_with_index do |entry, index|
        first_command = nil;
        if entry.command && entry.command.length > 0
          first_command = entry.command.first
        end
        href = (entry.name || entry.index_name) ? "index.html\#//dash_ref_#{category_strip}/Entry/#{URI.escape((entry.name) ? entry.tags_stripped_name.strip : entry.index_name.strip).gsub(/\//, '%252F')}/0" : (first_command) ? "index.html\#//dash_ref_#{category_strip}/Command/#{URI.escape(first_command).gsub(/\//, '%252F')}/0" : ""
        if entry.command
          entry.command.each do |command|
            if(!command.strip.empty?)
              db.execute(sql, command.strip, 'Command', href)
            end
          end
        end
        if entry.td_command
          entry.td_command.each do |command|
            if(!command.strip.empty?)
              db.execute(sql, command.strip, 'Command', href)
            end
          end
        end
        if entry.name || entry.index_name
          db.execute(sql, (entry.index_name) ? entry.index_name.strip : entry.tags_stripped_name.strip, 'Entry', href)
        end
      end
    end
  end
end