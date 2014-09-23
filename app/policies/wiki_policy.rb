class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def update?
    Collaboration.where(user: user, wiki: wiki).exists? || !wiki.privacy 
  end

  def destroy
    update?
  end

  def edit?
    update?
  end

  def create?
    user.present? && !(wiki.privacy && !user.premium)
  end
end

