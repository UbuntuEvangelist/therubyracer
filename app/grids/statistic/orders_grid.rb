module Statistic
  class OrdersGrid
    include Datagrid
    include Datagrid::Naming
    include Datagrid::ColumnI18n

    scope do
      Order.joins(:member).where('members.is_fake = false').order('created_at asc')
    end

    filter(:currency, :enum, :select => Order.currency.value_options, :default => 1, :include_blank => false)
    filter(:state, :enum, :select => Order.state.value_options, :include_blank => false)
    filter(:type, :enum, :select => [[OrderBid.model_name.human, OrderBid.model_name], [OrderAsk.model_name.human, OrderAsk.model_name]], :include_blank => false)
    filter(:created_at, :datetime,:range => true, :default => proc { [30.day.ago, Time.now]})

    column(:member_id) do |model|
      format(model) do 
        link_to model.member.name, member_path(model.member.id)
      end
    end
    column(:id, :order => nil)
    column(:price)
    column(:volume) do |o|
      if o.volume == o.origin_volume or o.volume.zero?
        o.origin_volume
      else
        "#{o.volume} / #{o.origin_volume}"
      end
    end
    column_localtime :created_at
    column(:state_text, header: "Status")
  end
end
