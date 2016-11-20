require "spec_helper"

describe METAR::Node::RunwayCondition do

  let(:metar_object) { METAR::Report.new(metar) }

  subject { rwy }
  let(:rwy) { metar_object.runway_condition.first }

  describe "#runway" do

    subject { rwy.runway }

    context "Rdds/xxxxxx" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 R23R/CLRD60 FZFG" }
      it { should == "23R" }
    end

    context "dd/xxxxxx" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 23/CLRD60 FZFG" }
      it { should == "23" }
    end

    context "ddxxxxxx" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 23CLRD60 FZFG" }
      it { should == "23" }
    end

    context "88xxxxxx" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 88CLRD60 FZFG" }
      it { should == :all }
    end

    context "runway number > 50" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 63CLRD60 FZFG" }
      it { should == "13R" }
    end

  end

  describe "#condition" do

    subject { rwy.condition }

    context "/" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 63////60 FZFG" }
      it { should be_nil }
    end

    context "C" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 63CLRD60 FZFG" }
      it { should == :clear_and_dry }
    end

    context "1" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 071///60 FZFG" }
      it { should == :damp }
    end

    context "2" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 072///60 FZFG" }
      it { should == :wet }
    end

    context "3" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 073///60 FZFG" }
      it { should == :frost }
    end

    context "4" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 074///60 FZFG" }
      it { should == :dry_snow }
    end

    context "5" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 075///60 FZFG" }
      it { should == :wet_snow }
    end

    context "6" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 076///60 FZFG" }
      it { should == :slush }
    end

    context "7" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 077///60 FZFG" }
      it { should == :ice }
    end

    context "8" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 078///60 FZFG" }
      it { should == :compacted_snow }
    end

    context "9" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 079///60 FZFG" }
      it { should == :rough_ice }
    end

  end

  describe "#coverage" do
    subject { rwy.coverage }

    context "L" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07CLRD60 FZFG" }
      it { should be_nil }
    end

    context "1" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07/1//60 FZFG" }
      it { should == (0..10) }
    end

    context "2" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07/2//60 FZFG" }
      it { should == (11..25) }
    end

    context "3" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07/3//60 FZFG" }
      it { should == (26..50) }
    end

    context "5" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07/5//60 FZFG" }
      it { should == (26..50) }
    end

    context "9" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07/9//60 FZFG" }
      it { should == (51..100) }
    end

  end

  describe "#depth" do
    subject { rwy.depth }

    context "01..90" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07//2860 FZFG" }
      it { should == 28 }
    end

    context "92..98" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07//9560 FZFG" }
      it { should == 250 }
    end

    context "99" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07//9960 FZFG" }
      it { should be_nil }
    end
  end

  describe "#braking_action" do

    subject { rwy.braking_action }

    context "00..25" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07////23 FZFG" }
      it { should == :poor }
    end

    context "26..29" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07////28 FZFG" }
      it { should == :medium_to_poor }
    end

    context "30..35" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07////34 FZFG" }
      it { should == :medium }
    end

    context "36..39" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07////37 FZFG" }
      it { should == :medium_to_good }
    end

    context "40..90" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07////80 FZFG" }
      it { should == :good }
    end

    context "91" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07////91 FZFG" }
      it { should == :poor }
    end

    context "92" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07////92 FZFG" }
      it { should == :medium_to_poor }
    end

    context "93" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07////93 FZFG" }
      it { should == :medium }
    end

    context "94" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07////94 FZFG" }
      it { should == :medium_to_good }
    end

    context "95" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07////95 FZFG" }
      it { should == :good }
    end

  end

  describe "#friction_index" do
    subject { rwy.friction_index }

    context "00-90" do
      let(:metar) { "UAAA 031800Z 14002MPS 0550 07////37 FZFG" }
      it { should == "0.37" }
    end

  end

end