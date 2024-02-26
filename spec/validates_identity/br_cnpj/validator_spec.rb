# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ValidatesIdentity::BrCnpj::Validator do
  it 'rejects 345.65.67.3' do
    expect(described_class.new('345.65.67.3')).not_to be_valid
  end

  it 'rejects 04.22A.284/0001-11' do
    expect(described_class.new('04.22A.284/0001-11')).not_to be_valid
  end

  it 'rejects 04.222-284.0001-11' do
    expect(described_class.new('04.222-284.0001-11')).not_to be_valid
  end

  it 'rejects 04222/284/0001-11' do
    expect(described_class.new('04222/284/0001-11')).not_to be_valid
  end

  it 'rejects 69103604020160' do
    expect(described_class.new('69103604020160')).not_to be_valid
  end

  it 'rejects 00000000000000' do
    expect(described_class.new('00000000000000')).not_to be_valid
  end

  it 'rejects 69.103.604/0001-61' do
    expect(described_class.new('69.103.604/0001-61')).not_to be_valid
  end

  it 'rejects 01618211000264' do
    expect(described_class.new('01618211000264')).not_to be_valid
  end

  it 'rejects 691036040001-601' do
    expect(described_class.new('691036040001-601')).not_to be_valid
  end

  it 'rejects 69103604000160a' do
    expect(described_class.new('69103604000160a')).not_to be_valid
  end

  it 'rejects 69103604000160ABC' do
    expect(described_class.new('69103604000160ABC')).not_to be_valid
  end

  it 'rejects 6910360400016000' do
    expect(described_class.new('6910360400016000')).not_to be_valid
  end

  it 'accepts blank number' do
    expect(described_class.new('')).to be_valid
  end

  it 'accepts nil' do
    expect(described_class.new(nil)).to be_valid
  end

  it 'accepts 69103604000160' do
    expect(described_class.new('69103604000160')).to be_valid
  end

  it 'accepts 69.103.604/0001-60' do
    expect(described_class.new('69.103.604/0001-60')).to be_valid
  end

  it 'accepts 01518211/000264' do
    expect(described_class.new('01518211/000264')).to be_valid
  end

  it 'accepts 01.5182110002-64' do
    expect(described_class.new('01.5182110002-64')).to be_valid
  end

  it 'accepts 00.000.000/1447-89' do
    expect(described_class.new('00.000.000/1447-89')).to be_valid
  end
end
