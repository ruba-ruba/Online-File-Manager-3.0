class CommentDecorator < Draper::Decorator
  delegate_all

  def status
    model.votes_up >= model.votes_down ? 'positive' : 'negative'
  end
end
