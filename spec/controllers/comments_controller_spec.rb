describe CommentsController do
  let(:admin) { Admin.create!(email: 'foo@ex.com', password: 'barbarbar') } 

  describe '#create' do
    let!(:_post)   { Post.create(title: 'title', body: 'body') }
    let(:subject) { post :create, post_id: _post.id, comment: params }

    context 'with invalid params' do
      let(:params) { { name: '', body: 'bar' } }

      it 'does not redirect to show page' do
        expect(subject).to redirect_to(post_path(_post))
      end

      it 'renders error flash message' do
        post :create, post_id: _post.id, comment: params

        expect(flash[:notice]).to eq("Name can't be blank")
      end
    end

    context 'with valid params' do
      let(:params) { { name: 'foo', body: 'bar' } }

      it 'redirects to show page' do
        expect(subject).to redirect_to(post_path(_post))
      end

      it 'renders a success flash message' do
        post :create, post_id: _post.id, comment: params

        expect(flash[:notice]).to eq('Comment saved successfully')
      end

      it 'creates a new comment record' do
        expect { subject }.to change { Comment.count }.by(1)
      end
    end
  end

  describe '#update' do
    let!(:post)    { Post.create(title: 'title', body: 'body') }
    let!(:comment) { Comment.create(name: 'Fu', body: 'bar', post: post) }
    let(:subject) do
      put :update, id: comment.id, post_id: post.id, comment: params
    end

    context 'logged in as admin' do
      before { sign_in admin }

      context 'with valid params' do
        let(:params) { { body: 'barfu' } }

        it 'redirects to post show page' do
          expect(subject).to redirect_to(post)
        end

        it 'renders a success flash message' do
          put :update, id: comment.id, post_id: post.id, comment: params

          expect(flash[:notice]).to eq('Comment saved successfully')
        end

        it 'updates the comment record' do
          put :update, id: comment.id, post_id: post.id, comment: params

          expect(Comment.first.body).to eq(params[:body])
        end
      end

      context 'with invalid params' do
        let(:params) { { body: '' } }

        it 'redirects to post show page' do
          expect(subject).to redirect_to(post)
        end

        it 'renders error flash message' do
          put :update, id: comment.id, post_id: post.id, comment: params
  
          expect(flash[:notice]).to eq("Body can't be blank")
        end
      end
    end

    context 'not logged in as admin' do
      let(:params) { { body: 'foo' } }

      it 'redirects to login page' do
        expect(subject).to redirect_to(new_admin_session_path)
      end
    end
  end

  describe '#destroy' do
    let!(:post)    { Post.create(title: 'title', body: 'body') }
    let!(:comment) { Comment.create(name: 'name', body: 'body') }
    let(:subject) { delete :destroy, post_id: post.id, id: comment.id }

    context 'logged in as admin' do
      before { sign_in admin }

      it 'redirects to index' do
        expect(subject).to redirect_to(post_path(post))
      end

      it 'destroys the comment' do
        expect { subject }.to change { Comment.count }.by(-1)
      end 
    end

    context 'not logged in as admin' do

      it 'redirects to the login screen' do
        expect(subject).to redirect_to(new_admin_session_path)
      end
    end
  end
end
