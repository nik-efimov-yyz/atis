require "spec_helper"

describe ATIS::Group::Cavok do

  let(:metar_object) { ATIS::METAR.new(metar) }

  subject { metar_object.cavok }

  context "normal" do
    let(:metar) { " CAVOK " }
    it { should be_cavok }
  end
end