require 'rails_helper'

describe MessagesController do
  let(:group) { create(:group)}
  let(:user) { create(:user)}
  #遅延評価 beforeメソッドが各exampleの実行前に毎回処理を行うのに対して、letメソッドは初回の呼び出し時のみ実行される。複数回の処理を一度で実行できるから、テストの高速化になる。
  #https://master.tech-camp.in/curriculums/2692
  describe '#index' do
    context 'log in' do
      before do
        login user
        get :index, params: { group_id: group.id}
      end
      
      it "assigns @message" do
        expect(assigns(:message)).to be_a_new(Message)
        #newアクションで生成された未保存のデータ?
      end
      
      it 'assigns @group' do
        expect(assigns(:group)).to eq group
      end
      
      it 'renders index' do
        expect(response).to render_template :index
      end
    end
    
    context 'not log in' do
      before do
        get :index, params: { group_id: group.id}
      end
      
      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe '#create' do #これ以降createについて 全然理解していない
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }
    
    context 'log in' do
      before do
        login user
      end
      
      context 'can save' do
        subject {
          post :create,
          params: params
        }

        it 'count up message' do
          expect{ subject }.to change(Message, :count).by(1)
        end

        it 'redirects to group_messages_path' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      context 'can not save' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }

        subject {
          post :create,
          params: invalid_params
        }
        
        it 'does not count up' do
          expect{ subject }.not_to change(Message, :count)
        end

        it 'renders index' do
          subject
          expect(response).to render_template :index
        end
      end
    end
    
    context 'not log in' do
      
      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end