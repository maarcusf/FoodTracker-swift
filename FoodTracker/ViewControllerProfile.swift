//
//  ViewControllerProfile.swift
//  FoodTracker
//
//  Created by Marcus Ferreira on 28/04/17.
//  Copyright © 2017 Vladyslav Chornobai. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class ViewControllerProfile: UIViewController
{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    //Variaveis de referencia para objetos visuais das classe
    @IBOutlet weak var vrHistorico: UISwitch!
    @IBOutlet weak var vrNotificacoes: UISwitch!
    @IBOutlet weak var vrNomeUsuario: UILabel!
    
    //Pega a referencia para o centro de notificacao
    let centroNotificacao = NotificationCenter.default
    var badge = 1
    
    //Variaveis do tipo Stored properties
    var nomeUsuario:String!
    
    
    //Metodo chamado quando tela e carregada
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Solicita autorizacao do usuario
        //Deseja disparar som, msg alerta e atualizar o badge
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
        {(flag:Bool, erro:Error?) in
        }
        
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
        if(vrNotificacoes.isEnabled)
        {
            let conteudo = UNMutableNotificationContent()
            conteudo.title = "Você tem uma nova mensagem."
            conteudo.subtitle = "Clique aqui."
            conteudo.body = "Acompanhe as refeições com suas avaliações!"
            conteudo.categoryIdentifier = "message"
            
            let criterio = UNTimeIntervalNotificationTrigger(timeInterval:5, repeats: false)
            
            let requisicao = UNNotificationRequest(identifier: "id3", content: conteudo, trigger: criterio)
            
            UNUserNotificationCenter.current().add(requisicao, withCompletionHandler: nil)
            
            UIApplication.shared.applicationIconBadgeNumber = badge
            badge = badge + 1
            
        }
        
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
