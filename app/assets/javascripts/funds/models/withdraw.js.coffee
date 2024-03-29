class Withdraw extends PeatioModel.Model
  @configure 'Withdraw', 'sn', 'account_id', 'member_id', 'currency', 'amount', 'fee', 'fund_uid', 'fund_extra',
    'created_at', 'updated_at', 'done_at', 'txid', 'blockchain_url', 'aasm_state', 'sum', 'type', 'is_submitting'

  constructor: ->
    super
    @is_submitting = @aasm_state == "submitting"

  @initData: (records) ->
    PeatioModel.Ajax.disable ->
      $.each records, (idx, record) ->
        Withdraw.create(record)

  afterScope: ->
    "#{@pathName()}"

  pathName: ->
    switch @currency
#      when 'usd' then 'banks'
#      when 'inr' then 'banks'
      when 'btc' then 'satoshis'
      when 'bch' then 'bitcoin_cash'
      when 'xrp' then 'ripples'
      when 'eth' then 'ethereums'
      when 'trx' then 'tronixes'
      when 'cac+' then 'cac+s'

window.Withdraw = Withdraw
