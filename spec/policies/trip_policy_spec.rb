require 'rails_helper'

RSpec.describe TripPolicy do

  let(:user) { User.new }

  subject { described_class }

  permissions :update? do
  end

  permissions :destroy? do
  end
end
