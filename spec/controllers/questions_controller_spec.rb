require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2, user: user) }

    before { get :index }

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'renders show view (question and its answers)' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'builds new attachment for question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it 'builds new attachment for question' do
      expect(assigns(:question).attachments.first).to be_a_new(Attachment)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end

      it 'answer gets user, user is logged user' do
        post :create, params: { question: attributes_for(:question) }
        expect(question).to have_attributes(user: user)
      end
    end


    context 'with invalid attributes' do
      it 'does not save the question' do
        expect { post :create, params: { question: attributes_for(:invalid_question) } }.to_not change(Question, :count)
      end

      it 're-renders new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'renders show view' do
      expect(response).to render_template :show
    end

    it 'assigns new question answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'builds new attachment for answer' do
      expect(assigns(:answer).attachments.first).to be_a_new(Attachment)
    end

  end

  describe 'DELETE #destroy' do
    sign_in_user

    it 'deletes question' do
      expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(1)
    end

    it 'redirect to questions view' do
      delete :destroy, params: {id: question }
      expect(response).to redirect_to questions_path
    end
  end

  describe 'DELETE #destroy' do
    sign_in_user

    context 'registered user is author' do

      it 'deletes question' do
        question = create(:question, user: @user)
        expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(-1)
      end

      it 'redirect to questions index' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end

    context "user isn't author" do
      it 'not deletes question' do
        question = create(:question, user: user)
        expect { delete :destroy, params: { id: question } }.to_not change(Question, :count)
      end

      it 'creates error message' do
        delete :destroy, params: { id: question }
        expect(flash[:error]).to eq "You can't delete another question."
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user

    context 'user is author' do
      it 'assigns requested question to @question' do
        patch :update, params: { id: question, question: attributes_for(:question), format: :js }
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        question = create(:question, user: @user)
        patch :update, params: { id: question, question: { title: 'title 123', body: 'body 123'}, format: :js }
        question.reload
        expect(question.title).to eq 'title 123'
        expect(question.body).to eq 'body 123'
      end

      it 'renders update template' do
        patch :update, params: { id: question, question: attributes_for(:question), format: :js }
        expect(response).to render_template :update
      end
    end

    context 'user is not author' do
      it 'not changes question attributes' do
        patch :update, params: { id: question, question: { title: 'title 123', body: 'body 123'}, format: :js }
        question.reload
        expect(question.title).to_not eq 'title 123'
        expect(question.body).to_not eq 'body 123'
      end

    end

  end

end
