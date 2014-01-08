class CommentDecorator < Draper::Decorator
  delegate_all

  def status
    model.votes_up >= model.votes_down ? '' : 'negative'
  end
end
