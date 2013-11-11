require "spec_helper"

describe METAR::Node::Time do

  let(:metar_object) { METAR::Report.new(metar) }

  subject { metar_object.time.first }

  context "normal" do
    let(:metar) { "031330Z" }
    its(:hours) { should == 13 }
    its(:minutes) { should == 30 }
    its(:time_zone) { should == "Z" }
  end
end