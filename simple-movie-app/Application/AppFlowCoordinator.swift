//
//  AppFlowCoordinator.swift
//  ExampleMVVM
//
//  Created by Oleh Kudinov on 03.03.19.
//

import UIKit

final class AppFlowCoordinator {

    var tabbarController: UITabBarController
    private let appDIContainer: AppDIContainer
    
    init(tabbarController: UITabBarController, appDIContainer: AppDIContainer) {
        self.tabbarController = tabbarController
        self.appDIContainer = appDIContainer
    }

    func start() {
        // In App Flow we can check if user needs to login, if yes we would run login flow
        /*let moviesSceneDIContainer = appDIContainer.makeMoviesSceneDIContainer()
        moviesSceneDIContainer.makeFetchMoviesRepository()
        let flow = moviesSceneDIContainer.makeMoviesSearchFlowCoordinator(navigationController: navigationController)
        flow.start()*/
    }
}
