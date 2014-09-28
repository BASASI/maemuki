require 'uri'

module Iminos
  class Client
    attr_accessor :access_key
    ENDPOINT = 'https://lr.capio.jp/'
    REQUEST_PATH ='/webapis/iminos/synana_k/1_1/' 
    SEPARATOR = '<!--p-->'
    MAX_SENTENCE_COUNT = 100
    MAX_SENTENCES_LENGTH = 1800

    def initialize(options = {})
      options.each { |key, value| send(:"#{key}", value) }
      yield(self) if block_given?
      @connection = connection
    end

    def request(text, options = {})
      if text.is_a?(Array)
        results = []
        sentences = []
        text.each do |sentence|
          sentences_length = URI.encode([*sentences, sentence].join(SEPARATOR)).length
          if sentences_length < MAX_SENTENCES_LENGTH && sentences.size < MAX_SENTENCE_COUNT
            sentences.push sentence
          else
            results.push request(sentences.join(SEPARATOR), options)
            sentences = []
          end
        end
        results.flatten
      else
        response = @connection.get(REQUEST_PATH, { acckey: @access_key, sent: text }.merge(options))
        json = JSON.parse(response.body)["results"]
        json.is_a?(Array) ? json.map { |item| Result.new(item) } : Result.new(json)
      end
    end

    private

      def connection
        Faraday::Connection.new(url: ENDPOINT) do |builder|
          builder.request :url_encoded
          builder.adapter :net_http
        end
      end
  end

  class Base
    class << self
      def attr_reader(*attrs)
        attrs.each { |attr| define_attribute_method "#{attr}" }
      end

      def object_attr_reader(klass, attr)
        define_attribute_method "#{attr}", klass
      end

      def define_attribute_method(key, klass = nil)
        define_method(key) do
          if klass.nil?
            @attrs[key]
          else
            if @attrs[key].is_a? Array
              @attrs[key].map { |v| Iminos.const_get(klass).new(v) }
            else
              Iminos.const_get(klass).new(@attrs[key])
            end
          end
        end
      end
    end

    def initialize(attrs = {})
      @attrs = attrs
    end
  end

  class Result < Iminos::Base
    attr_reader :spn, :pubrt, :reply, :mention, :url, :hashtag, :sensibilities
    object_attr_reader :Phrase, :phrases
    object_attr_reader :Morpheme, :morphemes
  end

  class Phrase < Iminos::Base
    attr_reader :pid, :ppn, :did, :pairpn,
      :deny, :jshuushi, :jgokan, :jhinshi, :jstart, :jcount, :jyomi,
      :fshuushi, :fgokan, :fhinshi, :fstart, :fcount, :fyomi
  end

  class Morpheme < Iminos::Base
    attr_reader :spn, :pubrt, :reply, :mention, :url, :hashtag, :sensibilities
  end
end
