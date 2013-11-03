require "spec_helper"

describe ATIS::Group::Time do

  let(:metar_object) { ATIS::METAR.new(metar) }

  subject { metar_object.time }

  context "normal" do
    let(:metar) { "031330Z" }
    its(:hours) { should == 13 }
    its(:minutes) { should == 30 }
    its(:time_zone) { should == "Z" }
  end
end