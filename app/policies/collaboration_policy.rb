class CollaborationPolicy < ApplicationPolicy
  def create?
    #Collaboration.where(user: user, wiki: record)      # record is the wiki
    Collaboration.where(user: user, wiki: record.wiki).exists? # record is the collaboration
  end
end