require "spec_helper"

describe METAR::Node::Cavok do

  let(:metar_object) { METAR::Report.new(metar) }

  subject { metar_object.cavok.first }

  context "normal" do
    let(:metar) { " CAVOK " }
    it { should be_cavok }
  end
end