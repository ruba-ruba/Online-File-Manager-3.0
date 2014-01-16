class CommentDecorator < Draper::Decorator
  delegate_all

  def status
    model.votes_up >= model.votes_down ? 'positive' : 'negative'
  end

  def parent_identifier
    model.parent ? ".comment-#{model.parent.id}" : '.comments>ul'
  end

  def content
    html = h.raw h.render("comments/comment_message", :comments => [model])
    html.gsub!(/<ul>|<\/ul>/, '') unless  model.parent
    html
  end
end
