# frozen_string_literal: true

require "securerandom"
require "timecop"

class MockStoplight
  def initialize
    @calls = []
  end

  def capture_message(message, **options)
    @calls.push([message, options])
  end

  def last_notification
    @calls.last
  end
end

RSpec.describe Stoplight::Sentry::Notifier do
  let(:notifier) { described_class.new(sentry, formatter, **options) }
  let(:sentry) { MockStoplight.new }
  let(:light) { Stoplight(name, threshold: 1, notifiers: [notifier], cool_off_time:) }
  let(:name) { SecureRandom.uuid }
  let(:options) { {} }
  let(:error) { RuntimeError.new("bang!") }
  let(:cool_off_time) { 60 }

  context "when formatter is provided" do
    let(:formatter) { ->(config, from_color, to_color, error) { [config, from_color, to_color, error] } }

    it "notifies sentry" do
      light.run(->(_) {}) { raise error }

      expect(sentry.last_notification).to eq(
        [
          [light.config, "green", "red", error],
          {backtrace: error.backtrace}
        ]
      )

      Timecop.travel(Time.now + cool_off_time + 1) do
        light.run {}
      end

      expect(sentry.last_notification).to eq(
        [
          [light.config, "yellow", "green", nil],
          {backtrace: nil}
        ]
      )
    end

    context "with custom options" do
      let(:options) { {tags: {foo: "bar"}} }

      it "notifies sentry" do
        light.run(->(_) {}) { raise error }

        expect(sentry.last_notification).to eq(
          [
            [light.config, "green", "red", error],
            {backtrace: error.backtrace, tags: {foo: "bar"}}
          ]
        )
      end
    end
  end

  context "when formatter is not provided" do
    let(:formatter) { nil }
    let(:message) { "Switching light-name from green to red because StandardError something went wrong" }

    it "notifies sentry" do
      light.run(->(_) {}) { raise error }

      expect(sentry.last_notification).to eq(
        [
          "Switching #{name} from green to red because RuntimeError bang!",
          {backtrace: error.backtrace}
        ]
      )

      Timecop.travel(Time.now + cool_off_time + 1) do
        light.run {}
      end

      expect(sentry.last_notification).to eq(
        [
          "Switching #{name} from yellow to green",
          {backtrace: nil}
        ]
      )
    end

    context "with custom options" do
      let(:options) { {tags: {foo: "bar"}} }

      it "notifies sentry" do
        light.run(->(_) {}) { raise error }

        expect(sentry.last_notification).to eq(
          [
            "Switching #{name} from green to red because RuntimeError bang!",
            {backtrace: error.backtrace, tags: {foo: "bar"}}
          ]
        )
      end
    end
  end
end
