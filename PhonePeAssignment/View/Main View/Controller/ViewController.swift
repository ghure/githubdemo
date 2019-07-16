//
//  ViewController.swift
//  PhonePeAssignment
//
//  Created by Mahadev on 09/07/19.
//  Copyright © 2019 Mahadev. All rights reserved.
//

import UIKit
import SKActivityIndicatorView

class ViewController: UIViewController  {
    
    //MARK: Outlets
    @IBOutlet weak var searchBtn: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var titleView: UIBarButtonItem = UIBarButtonItem()
    @IBOutlet weak var titleBarBtnItem: UIBarButtonItem!
    
    var searchBar: UISearchBar!
    var searchActive : Bool = false
    var filtered:[[String: Any]] = []
    var UserDetails:UserDetail?
    var followerAry: [UserDetail] = []
    
    let viewModel = PublicRepoViewModel(dataService: GetApiGlobal())
    
    @IBAction func didSearchBarBtnTapped(_ sender: Any) {
        self.searchBar = UISearchBar(frame: CGRect(x:self.view.frame.width, y:0, width:self.view.frame.width, height:20))
        self.searchBar.showsCancelButton = true
        searchBar.delegate = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.searchBar)
        UIView.animate(withDuration: 0.25) {
            self.searchBar.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:20)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleView = UIBarButtonItem(customView: titleBarBtnItem.customView!)
        self.navigationItem.rightBarButtonItems = []
        self.navigationController?.isNavigationBarHidden = false
        let shareBar: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem:.action, target: self, action: #selector(userDidTapShare))
        
        self.navigationItem.rightBarButtonItem = shareBar
        
        self.tableView.register(UINib(nibName: "GitHubUserTableViewCell", bundle: nil), forCellReuseIdentifier: "usercell")
        
        self.tableView.register(UINib(nibName: "FollowerTableViewCell", bundle: nil), forCellReuseIdentifier: "followcell")
        SKActivityIndicator.show("Loading...")
        if let user = UserDetails, let url = user.followers_url {
            viewModel.fetchUser(withName: url) { (users, err) in
                SKActivityIndicator.dismiss()
                if let users = users {
                    self.followerAry = users
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
    }
    
    @objc func userDidTapShare() {
        var text = ""
        //let image = UIImage(named: "Product")
        var imageUrl:URL?
        
        if let obj = self.UserDetails {
            
            if let url =  obj.avatar_url, let login = obj.login ,let name = obj.name, let location = obj.location {
                text = login + "\n" + name + "\n" + location
                imageUrl = URL(string: url)!
            }
        }
        if let imageUrl = imageUrl {
        let shareAll = [text ,  imageUrl] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
}


extension ViewController: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = false;
        UIView.animate(withDuration: 0.25, animations: {
            self.searchBar.frame = CGRect(x:self.view.frame.width, y:0, width:self.view.frame.width, height:20)
            self.searchBar.removeFromSuperview()
        }) { (sucess) in
            self.navigationItem.leftBarButtonItem = self.titleView
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            if self.followerAry.count == 0 {
                let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
                noDataLabel.text          = "No data available"
                noDataLabel.textColor     = UIColor.white
                noDataLabel.textAlignment = .center
                tableView.backgroundView  = noDataLabel
                tableView.separatorStyle  = .none
            } else {
                tableView.backgroundView = nil
            }
            return self.followerAry.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Followers";
        }
        return nil
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "usercell", for: indexPath) as! GitHubUserTableViewCell
            if let obj = self.UserDetails {
                
                if let url =  obj.avatar_url {
                    if url != "" {
                        print(url)
                        cell.avatarImgView.downloadImageFrom(link: url, contentMode: .scaleAspectFit)
                    }
                }
                
                if let login = obj.login {
                    cell.loginLbl.text = login
                }
                if let name = obj.name {
                    cell.nameLbl.text = name
                }
                if let location = obj.location {
                    cell.locationLbl.text = location
                }
                
                if let repos = obj.public_repos {
                    cell.reposCountLbl.text = "\(repos)"
                    cell.reposLbl.text = "Repos"
                }
                
                if let gists = obj.public_gists {
                    cell.gistCountLbl.text = "\(gists)"
                    cell.gistLbl.text = "Gist"
                }
                
                if let follower = obj.followers {
                    cell.followingCountLbl.text = "\(follower)"
                    cell.followingLbl.text = "Followers"
                }
                
                if let cDate = obj.updated_at {
                    let date = cDate.stringToDate()
                    cell.createdDateLbl.text = "Updated date: \(date.toString())"
                }
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "followcell", for: indexPath) as! FollowerTableViewCell
            let obj = self.followerAry[indexPath.row]
            if let url =  obj.avatar_url {
                if url != "" {
                    print(url)
                    cell.avtarImgView.downloadImageFrom(link: url, contentMode: .scaleAspectFit)
                    cell.avtarImgView.layer.cornerRadius = cell.avtarImgView.frame.height/2
                }
            }
            
            if let title = obj.login {
                cell.loginLbl.text = title
            }
            return cell
        }
    }
}

