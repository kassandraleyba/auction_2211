class Auction
    attr_reader :items

    def initialize
        @items = []
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
end