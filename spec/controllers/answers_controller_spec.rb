require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }

  # describe 'GET #new' do
  #   sign_in_user
  #   before { get :new, params: { question_id: question.id } }
  #
  #   it 'assigns a new Answer to @answer' do
  #     expect(assigns(:answer)).to be_a_new(Answer)
  #   end
  #
  #   it 'renders new view' do
  #     expect(response).to render_template :new
  #   end
  # end

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:answer) } }.to change(question.answers, :count).by(1)
      end

      it 'redirects to question show view' do
        post :create, params: { question_id:question, answer: attributes_for(:answer) }
        expect(response).to redirect_to question_path(assigns(:question))
      end

      it 'answer gets user, user is logged user' do
        post :create, params: { question_id:question, answer: attributes_for(:answer) }
        expect(answer).to have_attributes(user: user)
      end

    end

    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: { question_id: question, answer: attributes_for(:invalid_question) } }.to_not change(Answer, :count)
      end

      it 'renders new answer view' do
        post :create, params: { question_id: question, answer: attributes_for(:invalid_question) }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    context 'registered user is author' do

      it 'registered user is an current user' do
        expect(subject.current_user).to eq @user
      end

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
