module Private
  module Deposits
    class FtoTokensController < ::Private::Deposits::BaseController
      include ::Deposits::CtrlCoinable
    end
  end
end
