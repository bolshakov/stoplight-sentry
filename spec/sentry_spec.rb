# frozen_string_literal: true

require "sentry-ruby"

RSpec.describe Sentry do
  it { expect(Sentry).to be_respond_to("capture_message") }
end
