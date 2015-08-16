module TrelloBackupHelper
  def time_of_backup(object)
    distance_of_time_in_words_to_now(object.created_at).to_s + " ago"
  end
end

