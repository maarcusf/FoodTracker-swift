//
//  ViewControllerProfile.swift
//  FoodTracker
//
//  Created by Marcus Ferreira on 28/04/17.
//  Copyright © 2017 Vladyslav Chornobai. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerProfile: UIViewController
{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    //Variaveis de referencia para objetos visuais das classe
    @IBOutlet weak var vrHistorico: UISwitch!
    @IBOutlet weak var vrNotificacoes: UISwitch!
    @IBOutlet weak var vrNomeUsuario: UILabel!
    
    //Variaveis do tipo Stored properties
    var nomeUsuario:String!
   

    //Metodo chamado quando tela e carregada
    override func viewDidLoad()
    {
        super.viewDidLoad()
        vrNomeUsuario.text! = nomeUsuario
        let configs = StoreManager.retornaPreferencias()
        vrHistorico.setOn(configs.historico, animated: false)
        vrNotificacoes.setOn(configs.notificacoes, animated: false)
    }
    
    //Metodo chamado quando aviso de memoria e recebido
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Metodo utilizado para tratar o evento do componente historico
    @IBAction func trataEventoHistorico(_ sender: UISwitch)
    {
        StoreManager.gravaPreferencias(historico: vrHistorico.isOn)
    }
    
    //Metodo utilizado para tratar o evento do componente notificacoes
    @IBAction func trataEventoNotificacoes(_ sender: UISwitch)
    {
        StoreManager.gravaPreferencias(notificacoes: vrNotificacoes.isOn)
    }
    
    //Metodo chamado para tratar o evento de logoff
    @IBAction func handleLogoff(_ sender: Any)
    {
        let alert = UIAlertController(title: "Atencão", message: "Deseja mesmo sair?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Sim", style: .default, handler:
            {
                (UIAlertAction) in
                self.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Não", style: .cancel, handler:nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}
