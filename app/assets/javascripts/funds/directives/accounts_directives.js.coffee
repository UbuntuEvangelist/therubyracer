app.directive 'accounts', ->
  return {
    restrict: 'E'
    templateUrl: '/templates/funds/accounts.html'
    scope: { localValue: '=accounts' }
    controller: ($scope, $state) ->
      ctrl = @
      @state = $state
      if window.location.hash == ""
        @state.transitionTo("deposits.currency", {currency: Account.first().currency})

      $scope.accounts = Account.all()

      # Might have a better way
      # #/deposits/btc
      @selectedCurrency = window.location.hash.split('/')[2] || Account.first().currency
      @currentAction = window.location.hash.split('/')[1] || 'deposits'
      $scope.currency = @selectedCurrency

      $scope.currencyLogoStyles = (account) ->
        'background-image': "url('#{account.currency_icon_url}')"

      @isSelected = (currency) ->
        @selectedCurrency == currency

      @isDeposit = ->
        @currentAction != 'deposits'

      @isWithdraw = ->
        @currentAction != 'withdraws'

      @isCommission = ->
        @currentAction != 'commissions'

      #this method would be remove when we need to show csc and ipm in deposit funds dropdown
      @coin_hide_deposit = (account) ->
        if account
          if @currentAction == 'deposits' then  ( [].indexOf(account.currency) == -1)  else true

      @deposit = (account) ->
        ctrl.state.transitionTo("deposits.currency", {currency: account.currency})
        ctrl.selectedCurrency = account.currency
        ctrl.currentAction = "deposits"

      @withdraw = (account) ->
        ctrl.state.transitionTo("withdraws.currency", {currency: account.currency})
        ctrl.selectedCurrency = account.currency
        ctrl.currentAction = "withdraws"

      @commission = (account) ->
        ctrl.state.transitionTo("commissions.currency", {currency: account.currency})
        ctrl.selectedCurrency = account.currency
        ctrl.currentAction = "commissions"

      do @event = ->
        Account.bind "create update destroy", ->
          $scope.$apply()

    controllerAs: 'accountsCtrl'
  }

