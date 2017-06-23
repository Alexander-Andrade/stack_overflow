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

  describe 'DELETE #destroy' do
    sign_in_user

    it 'deletes question' do
      expect { delete :destroy, id: question }.to change(Question, :count).by(1)
    end

    it 'redirect to questions view' do
      delete :destroy, id: question
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

end
