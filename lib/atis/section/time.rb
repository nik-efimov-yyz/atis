class ATIS::Section::Time < ATIS::Section::Base

  uses :metar, group: :time, first: true

  format :en do
    text source.time
  end

  format :ru do
    spaced_number_blocks_for source.hours
    spaced_number_blocks_for source.minutes
  end


end