# Use this script to batch rename files
require 'fileutils'

Dir.glob("initial_folio_import/folio/**/*.folio.editors_notes.json").each do |old_file|
  puts old_file
  new_file = old_file.gsub(/\.editors_notes\.json\z/, '.notes.json')
  FileUtils.mv(old_file, new_file)
end; nil
