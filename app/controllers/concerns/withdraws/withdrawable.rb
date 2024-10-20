module Withdraws
  module Withdrawable
    extend ActiveSupport::Concern

    included do
      before_filter :fetch
    end

    def create
      @withdraw = model_kls.new(withdraw_params)

      if @withdraw.valid?
        @withdraw.save
        @withdraw.submit!
        render nothing: true
      else
        render text: @withdraw.errors.full_messages.join(', '), status: 403
      end
    end

    def destroy
      Withdraw.transaction do
        @withdraw = current_user.withdraws.find(params[:id]).lock!
        @withdraw.cancel
        @withdraw.save!
      end
      render nothing: true
    end


    private

    def fetch
      @withdraw_currency = params[:withdraw][:currency]
      @account = current_user.get_account(@withdraw_currency)
      @model = model_kls
      # @fund_sources = current_user.fund_sources.with_currency(channel.currency)
      @fund_sources = current_user.fund_sources.with_currency(@withdraw_currency)
      @assets = model_kls.without_aasm_state(:submitting).where(member: current_user).order(:id).reverse_order.limit(10)
    end

    def withdraw_params
      params[:withdraw][:currency] = @withdraw_currency
      params[:withdraw][:member_id] = current_user.id
      params.require(:withdraw).permit(:fund_source, :member_id, :currency, :sum,:payment_id )
    end

  end
end
