class Item
    attr_reader :name, :bids

    def initialize(name)
        @name = name
        @bids = {}
    end

    def add_bid(attendee, amount)
        @bids[attendee] = amount
    end

    def current_high_bid
        highest_bid = []
        @bids.each do |attendee, bid|
            highest_bid << bid
        end
        highest_bid.max
    end


    
end