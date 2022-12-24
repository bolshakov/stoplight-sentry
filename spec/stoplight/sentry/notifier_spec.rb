# frozen_string_literal: true

require "securerandom"

RSpec.describe Stoplight::Sentry::Notifier do
  subject(:notify) { notifier.notify(light, from_color, to_color, error) }

  let(:notifier) { described_class.new(sentry, formatter, **options) }
  let(:sentry) { class_double(Sentry) }
  let(:light) { instance_double(Stoplight::Light, name: "light-name") }
  let(:from_color) { Stoplight::Color::GREEN }
  let(:to_color) { Stoplight::Color::RED }
  let(:error) { StandardError.new("something went wrong").tap { _1.set_backtrace(backtrace) } }
  let(:backtrace) { ["foo", "bar"] }
  let(:options) { {} }

  context "when formatter is provided" do
    let(:formatter) { instance_double(Proc) }
    let(:message) { SecureRandom.uuid }

    before do
      expect(formatter).to receive(:call).with(light, from_color, to_color, error) { message }
    end

    it "notifies sentry" do
      expect(sentry).to receive(:capture_message).with(message, backtrace: backtrace)

      expect(notify).to eq(message)
    end

    context "with custom options" do
      let(:options) { { tags: { foo: "bar" }} }

      it "notifies sentry" do
        expect(sentry).to receive(:capture_message).with(message, backtrace: backtrace, tags: { foo: "bar" })

        expect(notify).to eq(message)
      end
    end
  end

  context "when formatter is not provided" do
    let(:formatter) { nil }
    let(:message) { "Switching light-name from green to red because StandardError something went wrong" }

    it "notifies sentry" do
      expect(sentry).to receive(:capture_message).with(message, backtrace: backtrace)

      notify
    end

    context "with custom options" do
      let(:options) { { tags: { foo: "bar" }} }

      it "notifies sentry" do
        expect(sentry).to receive(:capture_message).with(message, backtrace: backtrace, tags: { foo: "bar" })

        expect(notify).to eq(message)
      end
    end
  end
end
