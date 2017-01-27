require 'fileutils'

class Printer

  TMP_DIR = '/tmp/tfboy'
  # data is model - records hash
  def initialize(data)
    @format = data.delete(:format) || :yaml
    @dir = data.delete(:dir) || TMP_DIR
    @data = data
  end

  def print
    @data.each do |model, records|
      local_zip = File.open(file_name(model), mode = "wb") do |f|
        f.write("---\n")
        records.each do |record|
          attrs = record.split("\n")
          attrs.shift
          f.write("- #{attrs.shift}\n  ")
          f.write(attrs.join("\n  "))
          f.write("\n")
        end
      end
    end
  end

  private

  def local_dir
    FileUtils.mkdir_p @dir
  end

  def file_name(model)
    File.join local_dir, "#{model.underscore}s.#{@format.to_s}"
  end
end
