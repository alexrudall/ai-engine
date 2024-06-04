require "rails_helper"

RSpec.describe AI::Engine::AssistantThread, type: :model do
  it { expect(build(:assistant_thread, remote_id: "thread_123")).to be_valid }
  it { expect(build(:assistant_thread, remote_id: "msg_123")).not_to be_valid }
end
