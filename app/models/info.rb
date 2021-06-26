class Info < ApplicationRecord
  validates :title, presence: true

  # default_scope { order('priority ASC') }
  def self.search_unfinish(search)
    if search
      info_title = Info.where(done: 0).find_by(title: search)
      if info_title
        self.where(id: info_title)
      else
        @info_unfinishs = Info.where(done: 0).order(id: :desc)
      end
    else
      @info_unfinishs = Info.where(done: 0).order(id: :desc)
    end
  end
end
