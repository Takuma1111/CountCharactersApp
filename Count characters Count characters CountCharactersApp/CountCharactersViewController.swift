import UIKit
import Combine

class CountCharactersViewController: UIViewController {

    //入力するバーを設置
    
    @IBOutlet weak var countTextField: UITextField!
    @IBOutlet weak var countCharacterLabel: UILabel!
    //AnyCancelableはキャンセルされた時に発火する関数
    private var binding = Set<AnyCancellable>()
    private let viewModel = CountViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification,object: countTextField)
            .compactMap{$0.object as? UITextField}
            .map{ $0.text ?? "" }
            .removeDuplicates()
            .eraseToAnyPublisher() //publisherをAnyPublisherに変更する
            .receive(on: RunLoop.main)
            .assign(to: \.countText,on: viewModel)
            .store(in: &binding)
        
        }
    }
    
    final class CountViewModel{
        
        var countText : String = "" {
            didSet{
                print(countText.count)
            }
        }
    }
    


