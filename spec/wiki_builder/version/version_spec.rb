require 'spec_helper'

require 'wiki_builder'

describe WikiBuilder do
  subject { WikiBuilder::VERSION }

  it { expect { WikiBuilder::VERSION }.to_not raise_error }
  it { expect { Gem::Version.new(WikiBuilder::VERSION) }.to_not raise_error }
  it { is_expected.to be_a_kind_of String }
end
