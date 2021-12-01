//
//  TableController.swift
//  ListController
//
//  Created by Nikolai Timonin on 06.04.2021.
//
// https://github.com/ra1028/DifferenceKit/blob/master/Examples/Example-iOS/Sources/Common/NibLoadable.swift UITableView.register(...)
// https://www.raywenderlich.com/10317653-calayer-tutorial-for-ios-getting-started CARepeaterLayer
// https://6ary.medium.com/combine-getting-started-guide-c5ac0febc04c Combine
// https://habr.com/ru/company/deliveryclub/blog/548792/ Compositonal Layout
// https://swiftsenpai.com/swift/section-snapshot-builder/ DSL

import UIKit

// MARK: - TableViewController

open class TableViewController<SectionItem: Hashable, RowItem: Hashable>: BaseTableViewController<SectionItem, RowItem>, UITableViewDelegate {

    // MARK: - Override methods

    open override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
    }

    // MARK: - Public mehtods

    func cellDidSelect(for item: RowItem, at indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    open func dequeueReusableHeaderView(
        with reuseIdentifier: String,
        for sectionItem: SectionItem,
        at sectionIndex: Int
    ) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) else { return nil }
        let configurableItem = prepareSectionHeaderItem(sectionItem, at: sectionIndex)
        
        setupConfigurableView(view, with: configurableItem)
        
        return view
    }
    
    open func dequeueReusableFooterView(
        with reuseIdentifier: String,
        for sectionItem: SectionItem,
        at sectionIndex: Int
    ) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: reuseIdentifier) else { return nil }
        let configurableItem = prepareSectionFooterItem(sectionItem, at: sectionIndex)
        
        setupConfigurableView(view, with: configurableItem)
        
        return view
    }

    func headerIdentifier(for sectionItem: SectionItem, at sectionIndex: Int) -> String? {
        return nil
    }

    func footerIdentifier(for sectionItem: SectionItem, at sectionIndex: Int) -> String? {
        return nil
    }
    
    open func prepareSectionHeaderItem(_ item: SectionItem, at sectionIndex: Int) -> Any {
        return item
    }
    
    open func prepareSectionFooterItem(_ item: SectionItem, at sectionIndex: Int) -> Any {
        return item
    }
    
    // MARK: - UITableViewDelegate

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            assertionFailure("Don't find item of type: `\(RowItem.self)` for index path: \(indexPath)")
            return
        }

        cellDidSelect(for: item, at: indexPath)
    }

    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionItem = snapshot.sectionIdentifiers[section]
        guard let identifier = headerIdentifier(for: sectionItem, at: section) else { return nil }
        
        return dequeueReusableHeaderView(with: identifier, for: sectionItem, at: section)
    }

    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let sectionItem = snapshot.sectionIdentifiers[section]
        guard let identifier = footerIdentifier(for: sectionItem, at: section) else { return nil }
        
        return dequeueReusableFooterView(with: identifier, for: sectionItem, at: section)
    }

    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // MARK: - UIScrollViewDelegate

    public func scrollViewDidScroll(_ scrollView: UIScrollView) { }
}

