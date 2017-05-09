//
//  ViewControllerLogin.swift
//  FoodTracker
//
//  Created by Marcus Ferreira on 28/04/17.
//  Copyright © 2017 Vladyslav Chornobai. All rights reserved.
//

import Foundation

//Bibliotecas utilizadas
import UIKit

class ViewControllerLogin: UIViewController
{
    @IBAction func backButtonDidTouch(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    //Variaveis de referencia para componentes visuais
  
    @IBOutlet weak var vrCampoLogin: UITextField!
    @IBOutlet weak var vrCampoSenha: UITextField!
    @IBOutlet weak var btLogin: UIButton!
    
    @IBOutlet weak var centerAlignUsername: NSLayoutConstraint!
    
    @IBOutlet weak var centerAlignPassword: NSLayoutConstraint!
    
    //Metodo chamado quando tela carregada
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        vrCampoLogin.layer.cornerRadius = 5
        vrCampoSenha.layer.cornerRadius = 5
        btLogin.layer.cornerRadius = 5
      
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
 
  
   
    //Metodo para animacao
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        centerAlignUsername.constant -= view.bounds.width
        centerAlignPassword.constant -= view.bounds.width
        btLogin.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.00, options: UIViewAnimationOptions.curveEaseOut, animations: {
            
            self.centerAlignUsername.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.10, options: .curveEaseOut, animations: {
            
            self.centerAlignPassword.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.20, options: .curveEaseOut, animations: {
            
            self.btLogin.alpha = 1
            
        }, completion: nil)
        
    }
    
    //Metodo chamado quando aviso de memoria recebido
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    //Metodo chamado quanto ocorre toque na tela
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        vrCampoLogin.resignFirstResponder()
        vrCampoSenha.resignFirstResponder()
    }
    
    //Metodo chamado para tratar o evento de botao
    @IBAction func handleLogin(_ sender: Any) {
        if(vrCampoSenha.text == "unitins")
        {
            let proximaTela = storyboard?.instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
            
            let telaLogin = proximaTela.viewControllers![0] as! ViewControllerProfile
            
            telaLogin.nomeUsuario = vrCampoLogin.text
            
            proximaTela.modalTransitionStyle = .flipHorizontal
            self.present(proximaTela, animated: true, completion: nil)
            
        }
        else
        {
            let alert = UIAlertController(title: "ALERTA", message: "Senha inválida!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }

}

