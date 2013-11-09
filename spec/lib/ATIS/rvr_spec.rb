require "spec_helper"

describe ATIS::Group::Rvr do

  let(:metar_object) { ATIS::METAR.new(metar) }

  subject { rvr }
  let(:rvr) { metar_object.rvr.first }

  describe "single RVR" do
    let(:metar) { "UAAA 031800Z 14002MPS 0550 R23R/1300VP2000D FZFG" }
    its(:runway) { should == "23R" }

  end

  describe "#variable?" do
    subject { rvr.variable? }
    context "group includes V" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 R23R/1300VP2000D FZFG" }
      it { should be_true }
    end

    context "group does not include V" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 R23R/1300" }
      it { should be_false }
    end

  end

  describe "#visibility" do
    subject { rvr.visibility }
    context "non variable" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 R23R/1300" }
      it { should == 1300}
    end

    context "variable" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 R23R/1300V2000" }
      it { should == (1300..2000) }
    end

  end

  describe "#trend" do
    subject { rvr.trend }
    context "no trend data" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 R23R/1300" }
      it { should be_nil }
    end

    context "upward trend" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 R23R/1300U" }
      it { should == :upward }
    end

    context "downward trend" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 R23R/1300D" }
      it { should == :downward }
    end

    context "no change" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 R23R/1300N" }
      it { should == :no_change }
    end

  end

  describe "#peak" do
    subject { rvr.peak }
    context "peak present"  do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 R23R/P2000U" }
      it { should be_true }
    end

    context "peak absent" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 R23R/2000D" }
      it { should be_false }
    end

  end

  describe "#minimum" do
    subject { rvr.minimum }
    context  "minimum present" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 R23R/M0050D" }
      it { should be_true }
    end

    context "minimum absent" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 R23R/0050N" }
      it { should be_false }
    end

  end

end