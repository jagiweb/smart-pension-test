require './lib/log_scan'


RSpec.describe LogScan do
    let(:file_path) {'./spec/sample/webserver_test.txt'}
    subject { described_class.new(file_path)}

    describe '#reader' do
        before {subject.reader}
        it 'The data is read correctly in #reader' do
            expect(subject.reader).to eq(expected_results)
        end
        let(:expected_results) do
            {
                '/index' => ['111.111.111.111', '111.111.111.111', '222.222.222.222', '333.333.333.333'],
                '/contact' => ['111.111.111.111', '222.222.222.222', '333.333.333.333'],
                '/about' => ['222.222.222.222','222.222.222.222'],
                '/about/2' => ['111.111.111.111', '111.111.111.111', '222.222.222.222', '222.222.222.222', '333.333.333.333', '333.333.333.333'],
                '/home' => ['111.111.111.111', '222.222.222.222', '333.333.333.333', '444.444.444.444'],
                '/help_page/1' => ['333.333.333.333', '111.111.111.111']
            }
        end

        
    end

    describe '#most_views' do
        before {subject.reader}
        it 'Working successfully' do
            expect(subject.most_views).to eq(expected_results)
        end
        let(:expected_results) do
            {
                '/about/2' => 6,
                '/index' => 4,
                '/home' => 4,
                '/contact' => 3,
                '/about' => 2,
                '/help_page/1' => 2
            }
        end
        
    end

    describe '#unique_views' do
        before {subject.reader} 
        it 'Working successfully' do
            expect(subject.unique_views).to eq(expected_results)
        end
        let(:expected_results) do
            {
                '/home' => 4,
                '/index' => 3,
                '/contact' => 3,
                '/about/2' => 3,
                '/help_page/1' => 2,
                '/about' => 1
            }
        end
    end

    describe '#scan_printer' do
        before {subject.reader}
        it 'Working successfully' do
            expect(subject.scan_printer).to eq(expected_results)
        end
        let(:expected_results) do
           { 
            "Most Views" => 
                {
                    '/about/2' => 6,
                    '/home' => 4,
                    '/index' => 4,
                    '/contact' => 3,
                    '/help_page/1' => 2,
                    '/about' => 2,
                },
            "Unique Views" => 
                {
                    '/home' => 4,
                    '/about/2' => 3,
                    '/contact' => 3,
                    '/index' => 3,
                    '/help_page/1' => 2,
                    '/about' => 1
                }
            }
        end
    end
end