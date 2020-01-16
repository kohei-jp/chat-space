class MessagesController < ApplicationController
  before_action :set_group

  def index
    @message = Message.new
    @messages = @group.messages.includes(:user)
    # binding.pry
  end
  # 疑問 messagesコントローラ内なのにgroupから始める?結局何のデータを取りたいの? assoしてればok
  # →include(:user)って何目的?  n+1が発生してしまう
  #→グループに所属する全てのメッセージ(何に使う?)

  #@groupってどこからきた?→before_acgionのやつ

  def create
    @message = @group.messages.new(message_params)
    if @message.save
      redirect_to group_messages_path(@group), notice: 'メッセージが送信されました'
    else
      @messages = @group.messages.includes(:user)
      flash.now[:alert] = 'メッセージを入力してください。'
      render :index
    end
  end

  private
  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
  #→messageコントローラ内で普通にgroupのアクティブレコードのメソッド使えた?

end
