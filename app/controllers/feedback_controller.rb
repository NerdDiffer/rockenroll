class FeedbackController < ApplicationController
  attr_reader :feedback

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(feedback_params)

    if feedback.valid?
      flash[:success] = 'Thx!'
      redirect_to root_url
    else
      flash[:error] = 'Your message is not valid. Please try again.'
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(whitelisted_attr)
  end

  def whitelisted_attr
    [:name, :email, :message]
  end
end
