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
        expect { delete :destroy, params: { id: answer }, format: :js }.to change(Answer, :count).by(-1)
      end

      it 'render destroy.js.erb' do
        delete :destroy, params: { id: answer }, format: :js
        expect(response).to render_template(:destroy)
      end
    end

    context "user isn't author" do
      it 'not deletes answer' do
        answer = create(:answer, question: question, user: user)
        expect { delete :destroy, params: { id: answer }, format: :js }.to_not change(Answer, :count)
      end

      it 'creates error message' do
        delete :destroy, params: { id: answer }, format: :js
        expect(flash[:error]).to eq 'Your could not delete another answer.'
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    context 'author' do
      it 'assigns requested answer to @answer' do
        patch :update, params: { id: answer, answer: attributes_for(:answer), format: :js }
        expect(assigns(:answer)).to eq answer
      end

      it 'changes answer attributes' do
        answer = create(:answer, question: question, user: @user)
        patch :update, params: { id: answer, answer: { content: 'answer content 123'}, format: :js }
        answer.reload
        expect(answer.content).to eq 'answer content 123'
      end

      it 'renders update template' do
        patch :update, params: { id: answer, answer: attributes_for(:answer), format: :js }
        expect(response).to render_template :update
      end
    end

    context 'not author' do
      it 'not changes answer attributes' do
        patch :update, params: { id: answer, answer: { content: 'answer content 123'}, format: :js }
        answer.reload
        expect(answer.content).to_not eq 'answer content 123'
      end
    end

  end

  describe 'POST #set_best' do
    sign_in_user

    context 'authenticated user' do

      it 'assigns reordered answer list to @answers' do
        question = create(:question, user: @user)
        answer = create(:answer, question: question, user: @user)
        post :set_best, params: { id: answer, format: :js }
        expect(assigns(:answers)).to eq question.answers.all
      end

      it 'sets answer as best if it is question owner' do
        question = create(:question, user: @user)
        answer = create(:answer, question: question, user: @user)
        post :set_best, params: { id: answer, format: :js }
        answer.reload
        expect(answer).to be_best
      end

      it 'sets not answer as best if it is not question owner' do
        answer = create(:answer, question: question, user: @user)
        post :set_best, params: { id: answer, format: :js }
        answer.reload
        expect(answer).to_not be_best
      end

      it 'renders set_best template' do
        answer = create(:answer, question: question, user: @user)
        post :set_best, params: { id: answer, format: :js }
        expect(response).to render_template :set_best
      end

    end

    context 'not authenticated user' do
      it 'not sets answer as best' do
        post :set_best, params: { id: answer, format: :js }
        answer.reload
        expect(answer).to_not be_best
      end

    end

  end

end
