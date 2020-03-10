//
//  Food.swift
//  FirebaseTest
//
//  Created by MyMac on 2020/03/05.
//  Copyright © 2020 sandMan. All rights reserved.
//

import Foundation

struct HundredGram: Decodable {
    let gram: [Food]
    
    private enum CodingKeys: String, CodingKey {
        case gram = "100g당"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        gram = try container.decode([Food].self, forKey: .gram)
    }
}

struct Food: Decodable {
    let foodName: String
    let servingSize: String
    let calory: String
    let carbohydrate: String
    let fat: String
    let protein: String
    
    private enum CodingKeys: String, CodingKey {
        case foodName = "음식명"
        case servingSize = "중량(g)"
        case calory = "열량\r\n(kcal)"
        case carbohydrate = "탄수화물\r\n(g)"
        case fat = "지방\r\n(g)"
        case protein = "단백질\r\n(g)"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        foodName = try container.decode(String.self, forKey: .foodName)
        servingSize = try container.decode(String.self, forKey: .servingSize)
        calory = try container.decode(String.self, forKey: .calory)
        carbohydrate = try container.decode(String.self, forKey: .carbohydrate)
        fat = try container.decode(String.self, forKey: .fat)
        protein = try container.decode(String.self, forKey: .protein)
    }
}
