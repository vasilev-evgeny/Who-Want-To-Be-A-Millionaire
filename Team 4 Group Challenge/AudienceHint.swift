//
//  AudienceHint.swift
//  Team 4 Group Challenge
//
//  Created by Aliaksandr Zuyeu on 26.07.25.
//

import UIKit

class AudienceHint: UIView {
    private var barValues: [CGFloat] = []

    func setBarValues(_ values: [CGFloat]) {
        self.barValues = values
        self.subviews.forEach { $0.removeFromSuperview() }
        drawBars()
    }

    private func drawBars() {
        guard !barValues.isEmpty else { return }
        let maxVal = barValues.max() ?? 1
        let barWidth = self.bounds.width / CGFloat(barValues.count * 2)

        // Color ranking
        let sortedIndices = barValues.enumerated()
            .sorted { $0.element > $1.element }
            .map { $0.offset }
        
        var displayIndices = Array(barValues.indices)

        let labelColor = UIColor(red: 225/255, green: 155/255, blue: 48/255, alpha: 1)
        
        let titles = ["A", "B", "C", "D"]

        for (drawIndex, valueIndex) in displayIndices.enumerated() {
            let value = barValues[valueIndex]
            let barHeight = (value / maxVal) * self.bounds.height
            let barX = CGFloat(drawIndex) * barWidth * 2 + barWidth / 2
            let barY = self.bounds.height - barHeight

            // Bar color by value ranking
            let barView = UIView(frame: CGRect(x: barX, y: self.bounds.height, width: barWidth, height: 0))
            if valueIndex == sortedIndices.first {
                barView.backgroundColor = .systemGreen
            } else if sortedIndices.dropFirst().prefix(2).contains(valueIndex) {
                barView.backgroundColor = .systemYellow
            } else {
                barView.backgroundColor = .systemRed
            }
            self.addSubview(barView)

            // Ordered label title
            let labelWidth: CGFloat = barWidth
            let labelHeight: CGFloat = 24
            let labelX = barX + (barWidth - labelWidth) / 2
            let labelY = barY - labelHeight
            let label = UILabel(frame: CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight))
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 18),
                .foregroundColor: labelColor,
            ]
            let title = drawIndex < titles.count ? titles[drawIndex] : ""
            label.attributedText = NSAttributedString(string: title, attributes: attributes)
            label.textAlignment = .center
            label.alpha = 0
            self.addSubview(label)

            // Animate bar growth
            UIView.animate(withDuration: 0.7, delay: 0.1 * Double(drawIndex), options: .curveEaseOut, animations: {
                barView.frame = CGRect(x: barX, y: barY, width: barWidth, height: barHeight)
            }, completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    label.alpha = 1
                }
            })
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.subviews.forEach { $0.removeFromSuperview() }
        drawBars()
    }
}
