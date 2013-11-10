require "spec_helper"

describe ATIS::Group::Wind do

  let(:metar_object) { ATIS::METAR.new(metar) }

  subject { metar_object.wind.first }

  context "normal" do
    let(:metar) { "10006MPS" }
    it {should_not be_variable}
    it { should_not be_gusting }
    its(:direction) { should == 100 }
    its(:speed) { should == 6}
    its(:units) { should == "MPS" }
    its(:variable_from) { should be_nil }
    its(:variable_to) { should be_nil }
  end

  context "direction variable given with VRB" do
    let(:metar) { "VRB03KT" }
    it { should be_variable }
    it { should_not be_gusting }
    its(:direction) { should == "VRB" }
    its(:speed) { should == 3 }
    its(:units) { should == "KT" }
    its(:variable_from) { should be_nil }
    its(:variable_to) { should be_nil }
  end

  context "direction variable given with V" do
    let(:metar) { "15003MPS 120V180" }
    it { should be_variable }
    it { should_not be_gusting }
    its(:direction) { should == 150 }
    its(:speed) { should == 3 }
    its(:units) { should == "MPS" }
    its(:variable_from) { should == 120 }
    its(:variable_to) { should == 180 }
  end

  context "wind gusting" do
    let(:metar) { "26015G24MPS" }
    it { should_not be_variable }
    it { should be_gusting }
    its(:direction) { should == 260 }
    its(:speed) { should == (15..24) }
    its(:units) { should == "MPS" }
    its(:variable_from) { should be_nil }
    its(:variable_to) { should be_nil }
  end

  context "wind gusting and variable as VRB" do
    let(:metar) { "VRB10G15MPS" }
    it { should be_variable }
    it { should be_gusting }
    its(:direction) { should == "VRB" }
    its(:speed) { should == (10..15) }
    its(:units) { should == "MPS" }
    its(:variable_from) { should be_nil }
    its(:variable_to) { should be_nil }
  end

  context "wind gusting and variable as V" do
    let(:metar) { "30006G16MPS 270V340" }
    it { should be_variable }
    it { should be_gusting }
    its(:direction) { should == 300 }
    its(:speed) { should == (6..16) }
    its(:units) { should == "MPS" }
    its(:variable_from) { should == 270 }
    its(:variable_to) { should == 340 }
  end

  context "wind calm" do
    let(:metar) { "00000MPS" }
    it { should be_calm }
  end
end