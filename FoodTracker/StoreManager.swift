//
//  StoreManager.swift
//  FoodTracker
//
//  Created by Marcus Ferreira on 28/04/17.
//  Copyright © 2017 Vladyslav Chornobai. All rights reserved.
//

/*************************************************************
 Nome: Exemplo8
 Descricao: exemplo demonstra o conceito de troca de telas em iOS
 Autor: Silvano Malfatti
 Data: 01/11/2016
 **************************************************************/

//Bibliotecas utilizadas
import Foundation
class StoreManager
{
    //Metodo de classe utilizado para persistir os dados
    class func gravaPreferencias(notificacoes:Bool, historico:Bool)
    {
        let defaults = UserDefaults.standard
        
        defaults.set(notificacoes, forKey: "notificacoes")
        defaults.set(historico, forKey: "historico")
        
        defaults.synchronize()
    }
    
    //Metodo de classe utilizado para persistir os dados
    class func gravaPreferencias(notificacoes:Bool)
    {
        let defaults = UserDefaults.standard
        
        defaults.set(notificacoes, forKey: "notificacoes")
        
        defaults.synchronize()
        
    }
    
    //Metodo de classe utilizado para persistir os dados
    class func gravaPreferencias(historico:Bool)
    {
        let defaults = UserDefaults.standard
        
        defaults.set(historico, forKey: "historico")
        
        defaults.synchronize()
        
    }
    
    
    //Metodo de classe utililado para recuperar os dados persistidos
    class func retornaPreferencias()->(notificacoes:Bool, historico:Bool)
    {
        let defaults = UserDefaults.standard
        
        let notificacoes = defaults.bool(forKey: "notificacoes")
        
        let historico = defaults.bool(forKey: "historico")
        
        
        return(notificacoes, historico)
    }
}
