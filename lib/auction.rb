class Auction
    attr_reader :items, :bidders

    def initialize
        @items = []
        @bidders = []
    end

    def add_item(item)
        @items << item
    end
    
    def item_names
        item_names = []
        @items.each do |item|
            item_names << item.name
            # require 'pry'; binding.pry
        end
        item_names
    end

    def unpopular_items
        no_bids = []
        @items.each do |item| 
            no_bids << item if item.bids == {}
        end
        no_bids
    end

    def potential_revenue
        item_highest_bid = []
        @items.each do |item|
            item_bids = []
            item.bids.each do |item_bid|
                item_bids << item_bid[-1]
            end
            item_bid_max = item_bids.max
            item_highest_bid << item_bid_max if !item_bid_max.nil?
        end
        item_highest_bid.sum
    end

    def add_bidder(bidder)
        @bidders << bidder
    end

    def bidder_info
        bidder_info = {}
        @bidders.each do |bidder|
            items = @items.map { |item| item if item.name == x }
            bidder_info[bidder] = { 
                        :budget => bidder.budget, 
                        :items = items
                    }
                    require 'pry'; binding.pry
        # iterate through @items and add item to items array if name matches bidder name
    end
    bidder_info
    end
end