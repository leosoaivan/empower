class UsersController < ApplicationController
  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end

    @contacts = @user.contacts
                  .includes(episode: :petitioner)
                  .desc
                  .limit(25)
                  .map { |contact| ContactDecorator.new(contact) }
  end
end
