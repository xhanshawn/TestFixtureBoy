require 'logger'

class RecordScanner

  def initialize
    @cache = HashWithIndifferentAccess.new
    @filter = {}
  end

  def scan(clear_cache = false)
    @cache.clear if clear_cache
    query_results = yield

    return log(:warn, 'No query results.', @cache) unless query_results && query_results.present?

    records = query_results.is_a?(Array) ? query_results : [query_results]
    return log(:error, 'Not active records.', @cache) unless records.first.class < ActiveRecord::Base

    model_name = records.first.class.name
    @cache[model_name] ||= []
    @cache[model_name] = records.map(&:attributes)
    @cache[model_name].map!{ |h| h.slice(*@filter[:select]) } if @filter[:select]
    @cache[model_name].map!{ |h| h.except(*@filter[:except]) } if @filter[:except]
    @filter = {}
    @cache
  end

  def print_yaml
    @cache.inject({}) do |h, (model, records)|
      h[model] = records.map(&:to_yaml)
      h
    end
  end

  def select(attrs)
    attributes = symbolize_attrs attrs
    @filter = { select: attributes }
    puts @filter
    self
  end

  def except(attrs)
    attributes = symbolize_attrs attrs
    @filter = { except: attributes }
    puts @filter
    self
  end

  def symbolize_attrs(attrs)
    attrs = [attrs] unless attrs.is_a? Array
    attrs.map(&:to_sym)
  end

  def log(level, msg, retval)
    logger.send(level, msg)
    retval
  end

  def logger
    return @logger if @logger
    @logger = Logger.new(STDOUT)
    @logger.level = Logger::WARN
  end
end
