//
//  MemoListVCTableViewController.swift
//  MyMemory
//
//  Created by 최유진 on 2020/12/12.
//

import UIKit

class MemoListVC: UITableViewController {
    // 앱 델리게이트 객체의 참조 정보를 읽어온다.
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewWillAppear(_ animated: Bool) {
        // 테이블 데이터를 다시 읽어들인다. 이에 따라 행을 구성하는 로직이 다시 실행될 것이다.
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.appDelegate.memolist.count
        return count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 1. memolist 배열 데이터에서 주어진 행에 맞는 데이터를 꺼낸다.
        let row = self.appDelegate.memolist[indexPath.row]
        // 2. 이미지 속성이 비어 있을 경우 "memoCell", 아니면 "memoCellWithImage"
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        // 3. 재사용 큐로부터 프로토타입 셀의 인스턴스를 전달받는다.
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? MemoCell {
            cell.subject?.text = row.title
            cell.contents?.text = row.contents
            cell.img?.image = row.image
            // 5. Date 타입의 날짜를 "yyyy-MM-dd HH:mm:ss"
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            cell.regdate?.text = formatter.string(from: row.regdate!)
            // 6. 객체를 리턴한다.
            return cell
        } else {
            return MemoCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "read_sg", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "read_sg" {
            let vc  = segue.destination as? MemoReadVC
            vc?.param = self.appDelegate.memolist[tableView.indexPathForSelectedRow!.row]
        }
    }
   
}
