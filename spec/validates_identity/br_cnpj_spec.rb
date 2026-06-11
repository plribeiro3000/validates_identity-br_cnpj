# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ValidatesIdentity::BrCnpj do
  let(:user) { User.new }

  context 'with a valid value' do
    context 'without formatting' do
      before do
        user.identity = '64483856000148'
        user.identity_type = 'BR_CNPJ'
        user.valid?
      end

      it 'leaves the value as it is' do
        expect(user.identity).to eq('64483856000148')
      end
    end

    context 'with formatting' do
      before do
        user.formatted_identity = '64483856000148'
        user.identity_type = 'BR_CNPJ'
        user.valid?
      end

      it 'formats the value' do
        expect(user.formatted_identity).to eq('64.483.856/0001-48')
      end
    end

    context 'with an alphanumeric value' do
      before do
        user.formatted_identity = 'ab12cd34efgh83'
        user.identity_type = 'BR_CNPJ'
        user.valid?
      end

      it 'formats and upcases the value' do
        expect(user.formatted_identity).to eq('AB.12C.D34/EFGH-83')
      end
    end
  end

  context 'with an invalid value' do
    before do
      user.identity = '123456'
      user.identity_type = 'BR_CNPJ'
      user.valid?
    end

    it 'leaves the original value' do
      expect(user.identity).to eq('123456')
    end
  end
end
