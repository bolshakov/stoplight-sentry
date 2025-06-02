# frozen_string_literal: true

module Stoplight
  module Sentry
    # Usage:
    #
    #   notifier = Stoplight::Sentry::Notifier.new(Sentry)
    #   Stoplight::Light.default_notifiers += [notifier]
    #
    class Notifier < ::Stoplight::Notifier::Base
      # @!attribute sentry
      #   @return [::Sentry]
      attr_reader :sentry

      # @!attribute formatter
      #   @return [Proc]
      attr_reader :formatter

      # @!attribute options
      #   @return [Hash]
      attr_reader :options

      # @param sentry [::Sentry]
      # @param formatter [Proc, nil] (Stoplight::Default::FORMATTER)
      # @param options [Hash] custom options for the +Sentry#capture_message+ method
      def initialize(sentry, formatter = nil, **options)
        @sentry = sentry
        @formatter = formatter || Stoplight::Default::FORMATTER
        @options = options
      end

      # @param light [Stoplight::Light]
      # @param from_color [String]
      # @param to_color [String]
      # @param error [StandardError]
      # @return [String]
      def notify(light, from_color, to_color, error)
        formatter.call(light, from_color, to_color, error).tap do |message|
          options.merge(backtrace: error&.backtrace).then do |sentry_options|
            sentry.capture_message(message, **sentry_options)
          end
        end
      end
    end
  end
end
