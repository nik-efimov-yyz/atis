require "spec_helper"

describe ATIS::Group::Rvr do

  let(:metar_object) { ATIS::METAR.new(metar) }

  subject { metar_object.rvr }

  describe "single RVR" do
    let(:metar) { "UAAA 031800Z 14002MPS 0550 R23R/1300VP2000D FZFG" }
    its(:runway) { should == "23R" }

  end

  describe "multiple RVRs" do
    let(:metar) { "UAAA 031800Z 14002MPS 0550 R23R/1300VP2000D R23L/1400N FZFG" }
    its(:count) { should == 2 }
  end

end