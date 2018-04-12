module BandsHelper
  def translate_activity(action)
    case action
    when 'practice'
      'Practicing'
    when 'write_song'
      'Writing a song'
    when 'gig'
      'Playing a gig'
    when 'record_single'
      'Recording a single'
    when 'record_album'
      'Recording an album'
    when 'release'
      'Releasing music'
    when 'rest'
      'Resting'
    end
  end
end
