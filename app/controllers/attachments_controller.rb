class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_attachment, only: [:destroy]

  def destroy
    if current_user.author_of?(@attachment.attachable)
      @attachment.destroy!
    end
  end


  private

  def find_attachment
    @attachment = Attachment.find(params[:id])
  end
end
