require 'rails_helper'

describe FeedbackController do
  subject { build(:feedback) }

  describe '#new' do
    before(:each) do
      get(:new)
    end

    it 'renders the "new" template' do
      expect(response).to render_template 'new'
    end
    it 'assigns a Feedback object to @feedback' do
      expect(assigns(:feedback)).to be_an_instance_of Feedback
    end
  end

  describe '#create' do
    let(:feedback_params) do
      { name: 'foo bar', email: 'foo@example.com', message: 'bar' }
    end

    context 'when feedback is valid' do
      before(:each) do
        allow(Feedback).to receive(:new).and_return(subject)
        allow(subject).to receive(:valid?).and_return(true)
        post(:create, feedback: feedback_params)
      end

      it 'feedback object is an instance of Feedback' do
        actual = controller.feedback
        expect(actual).to be_an_instance_of(Feedback)
      end
      it 'has a success flash message' do
        expect(flash[:success]).not_to be_nil
      end
      it 'redirects to root' do
        expect(response).to redirect_to root_url
      end
    end

    context 'when feedback is NOT valid' do
      before(:each) do
        allow(Feedback).to receive(:new).and_return(subject)
        allow(subject).to receive(:valid?).and_return(false)
        post(:create, feedback: feedback_params)
      end

      it 'feedback object is an instance of Feedback' do
        actual = controller.feedback
        expect(actual).to be_an_instance_of(Feedback)
      end
      it 'has an error flash message' do
        expect(flash[:error]).not_to be_nil
      end
      it 'renders the :new template' do
        expect(response).to render_template 'new'
      end
    end
  end
end
