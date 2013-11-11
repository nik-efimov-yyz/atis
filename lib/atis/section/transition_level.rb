class ATIS::Section::TransitionLevel < ATIS::Section::Base

  uses :transition_level

  format :ru do |f|
    f.block :prefix
    f.text message.transition_level
  end

end