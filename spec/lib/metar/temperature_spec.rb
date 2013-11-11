require "spec_helper"

describe METAR::Node::Temperature do

  let(:metar_object) { METAR::Report.new(metar) }

  subject { metar_object.temperature.first }

  context "positive values" do
    let(:metar) { "UAAA 050000Z VRB01MPS 4100 BR NSC 04/03 Q1025 88CLRD65 NOSIG" }
    its(:temperature) { should == 4 }
    its(:dew_point) { should == 3 }
  end

  context "negative values" do
    let(:metar) { "UAAA 050000Z VRB01MPS 4100 BR NSC M04/M07 Q1025 88CLRD65 NOSIG" }
    its(:temperature) { should == -4 }
    its(:dew_point) { should == -7 }
  end


end