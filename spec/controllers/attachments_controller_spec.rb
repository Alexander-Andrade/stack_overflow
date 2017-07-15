require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do

  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let(:attachment) { create(:attachment, attachable: question) }

  describe 'DELETE #destroy' do

    context 'user deletes own attachment' do
      before { sign_in question.user }

      it 'deletes attachment' do
        expect { delete :destroy, params: { id: attachment, format: :js } }.to change(question.attachments, :count).by(-1)
      end

    end

    context 'somebody tries to delete someones attachment' do

      it 'not deletes someones attachment' do
        expect { delete :destroy, params: { id: attachment, format: :js } }.to_not change(Attachment, :count)
      end

    end

  end

end
