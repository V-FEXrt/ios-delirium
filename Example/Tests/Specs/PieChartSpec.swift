//
//  PieChartSpec.swift
//  Delirium
//
//  Created by Jelle Vandebeeck on 10/06/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import Delirium

class PieChartSpec: QuickSpec {
    
    // MARK: - Record
    
    private let record = false
    
    // MARK: - Specs
    
    override func spec() {
        describe("pie chart view") {
            var view: PieChartView!
            beforeEach{
                let frame = CGRect(x: 0, y: 0, width: 300, height: 300)
                view = PieChartView(frame: frame)
            }
            
            it("should show an empty pie chart") {
                self.expectSnapshot(forView: view, record: self.record)
            }
            
            it("should show a pie chart with one slice") {
                view.add(slice: PieChartSlice(value: 10, color: UIColor(red:0.16,green:0.55,blue:0.55,alpha:1.00)))
                self.expectSnapshot(forView: view, record: self.record)
            }
            
            it("should show a pie chart with three slices") {
                view.add(slice: PieChartSlice(value: 10, color: UIColor(red:0.16,green:0.55,blue:0.55,alpha:1.00)))
                view.add(slice: PieChartSlice(value: 10, color: UIColor(red:0.44,green:0.81,blue:0.80,alpha:1.00)))
                view.add(slice: PieChartSlice(value: 10, color: UIColor(red:0.98,green:0.90,blue:0.40,alpha:1.00)))
                self.expectSnapshot(forView: view, record: self.record)
            }
            
            it("should show a pie chart with another overlay color") {
                view.overlayColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
                view.add(slice: PieChartSlice(value: 10, color: UIColor(red:0.16,green:0.55,blue:0.55,alpha:1.00)))
                view.add(slice: PieChartSlice(value: 10, color: UIColor(red:0.44,green:0.81,blue:0.80,alpha:1.00)))
                view.add(slice: PieChartSlice(value: 10, color: UIColor(red:0.98,green:0.90,blue:0.40,alpha:1.00)))
                self.expectSnapshot(forView: view, record: self.record)
            }
            
            it("should show a pie chart with another stroke color") {
                view.strokeColor = UIColor(red:0.28,green:0.24,blue:0.25,alpha:1.00)
                view.add(slice: PieChartSlice(value: 10, color: UIColor(red:0.16,green:0.55,blue:0.55,alpha:1.00)))
                view.add(slice: PieChartSlice(value: 10, color: UIColor(red:0.44,green:0.81,blue:0.80,alpha:1.00)))
                view.add(slice: PieChartSlice(value: 10, color: UIColor(red:0.98,green:0.90,blue:0.40,alpha:1.00)))
                self.expectSnapshot(forView: view, record: self.record)
            }
            
            it("should show a pie chart with another overlay padding") {
                view.overlayPadding = 50.0
                view.add(slice: PieChartSlice(value: 10, color: UIColor(red:0.16,green:0.55,blue:0.55,alpha:1.00)))
                view.add(slice: PieChartSlice(value: 10, color: UIColor(red:0.44,green:0.81,blue:0.80,alpha:1.00)))
                view.add(slice: PieChartSlice(value: 10, color: UIColor(red:0.98,green:0.90,blue:0.40,alpha:1.00)))
                self.expectSnapshot(forView: view, record: self.record)
            }
        }
    }
}