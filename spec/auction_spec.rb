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

    describe "#item bids" do
        before do
            auction.add_item(item1)
            auction.add_item(item2)
            auction.add_item(item3)
            auction.add_item(item4)
            auction.add_item(item5)
        end

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

        it "can auction unpopular items" do
            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)
            item3.add_bid(attendee2, 15)
            item4.add_bid(attendee3, 50)

            bids_by_attendees = {
                attendee1 => 22,
                attendee2 => 20,
                attendee2 => 15,
                attendee3 => 50
            }

            expect(auction.unpopular_items).to eq([item2, item5])
            expect(auction.potential_revenue).to eq(87)
        end
    end

    describe "#bidders" do
        before do
            auction.add_item(item1)
            auction.add_item(item2)
            auction.add_item(item3)
            auction.add_item(item4)
            auction.add_item(item5)
        end
        
        it "starts with no bidders" do
            expect(auction.bidders).to eq([])
        end

        it "can add bidders" do
            auction.add_bidder(attendee1)
            auction.add_bidder(attendee2)
            auction.add_bidder(attendee3)

            expect(auction.bidders).to eq([attendee1, attendee2, attendee3])
        end

        it "can have a hash with attendee's budget and an array of items that attendee has bid on" do
            item1.add_bid(attendee2, 20)
            item1.add_bid(attendee1, 22)
            item3.add_bid(attendee2, 15)
            item4.add_bid(attendee3, 50)

            auction.add_bidder(attendee1)
            auction.add_bidder(attendee2)
            auction.add_bidder(attendee3)

            bidder_info_hash = {
                    attendee1 =>
                      {
                        :budget => 50,
                        :items => [item1]
                      },
                    attendee2 =>
                      {
                        :budget => 75,
                        :items => [item1, item3]
                      },
                    attendee3 =>
                      {
                        :budget => 100,
                        :items => [item4]
                      }
                   }
            expect(auction.bidder_info).to eq(bidder_info_hash)
        end
    end
end