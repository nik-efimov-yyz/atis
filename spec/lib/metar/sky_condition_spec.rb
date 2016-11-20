require "spec_helper"

describe METAR::Node::SkyCondition do

  let(:metar_object) { METAR::Report.new(metar) }

  subject { metar_object.sky_condition.first }

  context "SKC" do
    let(:metar) { "UAAA 050000Z SKC 04/03 Q1025 88CLRD65 NOSIG" }
    it { should be_clear }
    its(:no_significant_cloud?) { should be false }
    it { should_not be_vertical_visibility }
    its(:cover) { should be_nil }
    its(:height) { should be_nil }
    its(:cloud_type) { should be_nil }
  end

  context "NSC" do
    let(:metar) { "UAAA 050000Z NSC 04/03 Q1025 88CLRD65 NOSIG" }
    it { should_not be_clear }
    its(:no_significant_cloud?) { should be true }
    it { should_not be_vertical_visibility }
    its(:cover) { should be_nil }
    its(:height) { should be_nil }
    its(:cloud_type) { should be_nil }
  end

  context "standard" do
    let(:metar) { "UAAA 050000Z OVC050 04/03 Q1025 88CLRD65 NOSIG" }
    it { should_not be_clear }
    its(:no_significant_cloud?) { should be false }
    it { should_not be_vertical_visibility }
    its(:cover) { should == "OVC" }
    its(:height) { should == 5000 }
    its(:cloud_type) { should be_nil }
  end

  context "with cloud type" do
    let(:metar) { "UAAA 050000Z OVC050CB 04/03 Q1025 88CLRD65 NOSIG" }
    it { should_not be_clear }
    its(:no_significant_cloud?) { should be false }
    it { should_not be_vertical_visibility }
    its(:cover) { should == "OVC" }
    its(:height) { should == 5000 }
    its(:cloud_type) { should == "CB" }
  end

  context "as vertical visibility" do
    let(:metar) { "UAAA 050000Z VV005 04/03 Q1025 88CLRD65 NOSIG" }
    it { should_not be_clear }
    its(:no_significant_cloud?) { should be false }
    it { should be_vertical_visibility }
    its(:cover) { should be_nil }
    its(:height) { should == 500 }
    its(:cloud_type) { should be_nil }
  end

end