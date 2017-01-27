
module TestFixtureBoy

  # Some talents TFBoy have
  module Talents

    def self.introduce
      puts "  Hello, I am TFBoy. Let me introduce myself.\n",
           "  1. Scan your db records:",
           "    # This will select only name and customer_id attributes and scan records.",
           "    TFBoy.select([:name, :customer_id]).scan { Account.all }",
           "    # This will scan records except their credential attribute.",
           "    TFBoy.except(:credential).scan { Account.all }\n",
           "  2. Print your scanned data:",
           "    TFBoy.print :yaml\n",
           "  Then you can get your fixture file from /tmp/tfboy/<model>s.yaml"
    end
  end
end
