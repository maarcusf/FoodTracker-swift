//
//  StarRatingControl.swift
//  FoodTracker
//
//  Created by Marcus Ferreira on 28/04/17.
//  Copyright © 2017 Vladyslav Chornobai. All rights reserved.
//

import UIKit

@IBDesignable class StarRatingControl: UIStackView {
    
    private var buttons = [UIButton]()
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    //Propriedades
    
    //Tamanho da estrela - largura e altura
    @IBInspectable var starSize: CGSize = CGSize(width: 34.0, height: 34.0) {
        didSet {
            initButtons()
        }
    }
    //Quantidade de estrelas
    @IBInspectable var starCount: Int = 5 {
        didSet {
            initButtons()
        }
    }

    //Inicialização
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        initButtons()
    }

    //Métodos privados para carregar as imagens das estrelas.
    private func initButtons() {
        let bundle = Bundle(for: type(of: self))
        
        let filled = UIImage(named: "filled", in: bundle, compatibleWith: self.traitCollection)
        let empty = UIImage(named:"empty", in: bundle, compatibleWith: self.traitCollection)
        let highlighted = UIImage(named:"highlighted", in: bundle, compatibleWith: self.traitCollection)
        
        removeButtons()
        
        //Contador para ir preenchendo com as imagens das estrelas de acordo com o número de estrelas definidos
        for index in 0..<starCount {
            let button = createButton()
            button.setImage(empty, for: .normal)
            button.setImage(filled, for: .selected)
            button.setImage(highlighted, for: .highlighted)
            button.setImage(highlighted, for: [.selected, .highlighted])
            
            // Definir o rótulo de acessibilidade
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            buttons.append(button)
            addArrangedSubview(button)
        }
        
        updateButtonSelectionStates()
    }
    
    private func createButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor.red
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
        button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
        
        button.addTarget(self, action: #selector(StarRatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
        
        return button
    }
    
    private func removeButtons() {
        for button in buttons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        buttons.removeAll()
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in buttons.enumerated() {
            // Se o índice de um botão for menor que a classificação, esse botão deve ser selecionado.
            button.isSelected = index < rating
            
            // Definir a string de sugestão para a estrela selecionada atualmente
            let hintString: String?
            if rating == index + 1 {
                hintString = "Toque para redefinir a classificação para zero."
            } else {
                hintString = nil
            }
            
            // Calcula o valor da string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "Sem classificação definida."
            case 1:
                valueString = "1 estrela definida."
            default:
                valueString = "\(rating) estrelas definidas."
            }
            
            //Atribuir a sequência de caracteres e a sequência de valor.
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
    
    //Ações dos buttons
    func ratingButtonTapped(button: UIButton) {
        guard let index = buttons.index(of: button) else {
            fatalError("O botão, \(button), não está no array ratingButtons : \(buttons)")
        }
        
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
}
