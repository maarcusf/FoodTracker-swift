//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Marcus Ferreira on 28/04/17.
//  Copyright © 2017 Vladyslav Chornobai. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {


    //Propriedades
    var meals = [Meal]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedMeals = loadMeals() {
            meals += savedMeals
        } else {
            loadSampleMeals()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Navigation
    
// Em uma aplicação baseada em storyboard, muitas vezes é preciso fazer um pouco de preparação antes da navegação.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            case "AddItem":
                os_log("Adicionando nova refeição.", log: OSLog.default, type: .debug)
            
            case "ShowDetails":
                guard let mealDetailViewController = segue.destination as? MealViewController else {
                    fatalError("Destino inesperado: \(segue.destination)")
                }
            
                guard let selectedMealCell = sender as? MealTableViewCell else {
                    fatalError("Remetente inesperado: \(String(describing: sender))")
                }
            
                guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                    fatalError("A célula selecionada não está sendo exibida pela tabela.")
                }
            
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
            
            default:
                fatalError("Identificador Segue inesperado; \(String(describing: segue.identifier))")
        }
    }

    //Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    //Numero de refeições.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
// Células da TableView são reutilizadas e devem ser desanexadas usando um identificador de célula.
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
            fatalError("A célula desfeita não é uma instância de MealTableViewCell.")
        }
        
        //Obtém a refeição apropriada para o layout da fonte de dados.
        let meal = meals[indexPath.row]
        
        cell.labelField.text = meal.name
        cell.imageField.image = meal.photo
        cell.ratingsField.rating = meal.rating
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Exclui a linha do datasource
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            saveMeals()
            
        } else if editingStyle == .insert {
            // Cria uma nova instância da classe apropriada, insere na matriz e adiciona uma nova linha à TableView
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Retorna false se você não quiser que o item especificado seja editável.
        return true
    }

    //Ações
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Atualizar uma refeição existente.
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add ma nova refeição.
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
            saveMeals()
        }
    }
    
    //Métodos privados
    
    //Função carrega 3 refeições pré-definidas para mostrar no TableView
    //com o nome, foto e a avaliação;
    private func loadSampleMeals() {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = Meal(name: "Salada", photo: photo1, rating: 4) else {
            fatalError("Não é possível instanciar meal1")
        }
        
        guard let meal2 = Meal(name: "Frango e Batatas", photo: photo2, rating: 5) else {
            fatalError("Não é possível instanciar meal2")
        }
        
        guard let meal3 = Meal(name: "Macarrão com almôndegas", photo: photo3, rating: 3) else {
            fatalError("Não é possível instanciar meal3")
        }
        
        meals += [meal1, meal2, meal3]
    }
    
    //Função para salvar as refeições no arquivo.
    private func saveMeals() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        
        if isSuccessfulSave {
            os_log("Refeições salvas com sucesso.", log: OSLog.default, type: .debug)
        } else {
            os_log("Falha ao salvar as refeições...", log: OSLog.default, type: .error)
        }
    }
    
    //Carrega as refeições do arquivo.
    private func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
    }

}
