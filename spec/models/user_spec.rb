require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe "when valid information is filled" do
    it { is_expected.to be_valid }
  end

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to allow_value('user@example.com').for(:email) }
  it { is_expected.not_to allow_value('user@example').for(:email) }

  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
  it { is_expected.to validate_length_of(:username).is_at_least(3).is_at_most(20) }

  it { is_expected.to validate_presence_of(:mobile) }
  it { is_expected.to validate_uniqueness_of(:mobile).case_insensitive }
  it { is_expected.to allow_value('1234567890').for(:mobile) }
  it { is_expected.not_to allow_value('123').for(:mobile) }
  it { is_expected.not_to allow_value('12345678901').for(:mobile) }
  it { is_expected.not_to allow_value('123456789a').for(:mobile) }

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_length_of(:first_name).is_at_least(3).is_at_most(20) }
  it { is_expected.to validate_length_of(:last_name).is_at_least(3).is_at_most(20) }

  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(6).is_at_most(50) }
  it do
    is_expected.to allow_value('Password1!').for(:password)
    is_expected.not_to allow_value('password').for(:password)
    is_expected.not_to allow_value('password!').for(:password)
    is_expected.not_to allow_value('PASSWORD1').for(:password)
    is_expected.not_to allow_value('Password').for(:password)
    is_expected.not_to allow_value('123456').for(:password)
  end
end
