require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) }, format: :js }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question show view' do
        post :create, params: { question_id:question, answer: attributes_for(:answer), format: :js }
        expect(response).to render_template(:create)
      end

      it 'answer gets user, user is logged user' do
        post :create, params: { question_id:question, answer: attributes_for(:answer), format: :js }
        expect(answer).to have_attributes(user: user)
      end

    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:invalid_question), format: :js } }.to_not change(Answer, :count)
      end

      it 'renders new answer view' do
        post :create, params: { question_id: question, answer: attributes_for(:invalid_question), format: :js }
        expect(response).to render_template(:create)
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    context 'registered user is author' do

      it 'deletes answer' do
        answer = create(:answer, question: question, user: @user)
        expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
      end

      it 'redirect to question show' do
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to question_path(question)
      end
    end

    context "user isn't author" do
      it 'not deletes answer' do
        answer = create(:answer, question: question, user: user)
        expect { delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
      end

      it 'creates error message' do
        delete :destroy, params: { id: answer }
        expect(flash[:error]).to eq 'Your could not delete another answer.'
      end
    end
  end

end
