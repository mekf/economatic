require 'playhouse/role'

module Economatic
  module TransferDestination
    include Playhouse::Role

    actor_dependency :id

    def increase_money!(amount, transfer)
      Transaction.create!(amount: amount, transfer: transfer, account: self, pending: external?)
    end
  end
end