require './lib/item'
require './lib/attendee'
require './lib/auction'

RSpec.describe Auction do
    let(:auction) { Auction.new }
    let(:item1) { Item.new('Chalkware Piggy Bank') }
    let(:item2) { Item.new('Bamboo Picture Frame') }
    let(:item3) { Item.new('Homemade Chocolate Chip Cookies') }
    let(:item4) { Item.new('2 Days Dogsitting') }
    let(:item5) { Item.new('Forever Stamps') }
    let(:attendee1) { Attendee.new(name: 'Megan', budget: '$50') }
    let(:attendee2) { Attendee.new(name: 'Bob', budget: '$75') }
    let(:attendee3) { Attendee.new(name: 'Mike', budget: '$100') }

    describe "#initialize" do
        it "exists" do
            expect(auction).to be_instance_of Auction
        end
    end

    describe "#has items" do
        it "starts with no items" do
            expect(auction.items).to eq([])
        end

        it "can add items" do
            auction.add_item(item1)
            auction.add_item(item2)

            expect(auction.items).to eq([item1, item2])
            expect(auction.item_names).to eq(['Chalkware Piggy Bank', 'Bamboo Picture Frame'])
        end
    end

    describe "item bids" do
        it "starts with no bids" do
            expect(item1.bids).to eq({})
        end
        
        it "can add bids and have a current high bid" do
            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)
        
            bids_by_attendees = {
                attendee1 => 22,
                attendee2 => 20
            }
        
            expect(item1.bids).to eq(bids_by_attendees)
            expect(item1.current_high_bid).to eq(22)
        end
    end
end