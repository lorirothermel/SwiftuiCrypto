//
//  MarketDataModel.swift
//  SwiftuiCrypto
//
//  Created by Lori Rothermel on 5/4/23.
//

import Foundation
// JSON Data
/*
 
 URL: https://api.coingecko.com/api/v3/global
 
 JSON Response:
 
 {
   "data": {
     "active_cryptocurrencies": 10682,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 727,
     "total_market_cap": {
       "btc": 42657433.356027424,
       "eth": 658378072.553964,
       "ltc": 14063211374.309261,
       "bch": 10546896655.221413,
       "bnb": 3831811203.546002,
       "eos": 1239224937476.273,
       "xrp": 2691560961553.554,
       "xlm": 13329158403759.713,
       "link": 176472133163.52557,
       "dot": 217423085939.89252,
       "yfi": 154403687.22339728,
       "usd": 1238870232491.9739,
       "aed": 4549627041803.511,
       "ars": 279589596826044.47,
       "aud": 1847157994386,
       "bdt": 132338810299807.78,
       "bhd": 467102393588.5428,
       "bmd": 1238870232491.9739,
       "brl": 6175396447902.753,
       "cad": 1674889371947.2947,
       "chf": 1095877352517.288,
       "clp": 989398933775065.4,
       "cny": 8560717193542.782,
       "czk": 26312264519408.207,
       "dkk": 8363456841904.022,
       "eur": 1122718714974.4563,
       "gbp": 983983831988.845,
       "hkd": 9723497255225.33,
       "huf": 418800244385912.6,
       "idr": 18185316031527136,
       "ils": 4527513208153.563,
       "inr": 101195900848279.31,
       "jpy": 166079433239678.12,
       "krw": 1632057019412779,
       "kwd": 379381709036.4823,
       "lkr": 397106364206211.3,
       "mmk": 2609810176563945.5,
       "mxn": 22166733408909.176,
       "myr": 5517308580403.0205,
       "ngn": 572142056580607.6,
       "nok": 13211110223446.506,
       "nzd": 1965156667420.162,
       "php": 68520051776042.04,
       "pkr": 352635950195152.5,
       "pln": 5152969233729.429,
       "rub": 97433772819591.05,
       "sar": 4646550054442.528,
       "sek": 12662134612803.281,
       "sgd": 1642847232254.12,
       "thb": 41770863741908.68,
       "try": 24150660199221.816,
       "twd": 37958363249567.64,
       "uah": 45901952103237.32,
       "vef": 124048076379.42157,
       "vnd": 29054181534015316,
       "zar": 22633170529182.832,
       "xdr": 920798972391.2874,
       "xag": 47484582808.97078,
       "xau": 603812962.6142632,
       "bits": 42657433356027.42,
       "sats": 4265743335602742.5
     },
     "total_volume": {
       "btc": 2919519.2552420227,
       "eth": 45060082.35441177,
       "ltc": 962500862.5145777,
       "bch": 721840613.5918105,
       "bnb": 262253157.56424785,
       "eos": 84813847948.65678,
       "xrp": 184213241062.31073,
       "xlm": 912261511168.6957,
       "link": 12077936956.133072,
       "dot": 14880662899.65768,
       "yfi": 10567549.485847816,
       "usd": 84789571569.36908,
       "aed": 311381222631.35004,
       "ars": 19135403780303.945,
       "aud": 126421420789.07257,
       "bdt": 9057406282779.02,
       "bhd": 31968975274.943447,
       "bmd": 84789571569.36908,
       "brl": 422650577401.8348,
       "cad": 114631176493.63716,
       "chf": 75002989639.68954,
       "clp": 67715495542445.24,
       "cny": 585904418501.4968,
       "czk": 1800838842606.533,
       "dkk": 572403714178.793,
       "eur": 76840040497.31131,
       "gbp": 67344880325.11567,
       "hkd": 665486299374.6467,
       "huf": 28663125776459.12,
       "idr": 1244622006991966.8,
       "ils": 309867728778.8392,
       "inr": 6925953059863.793,
       "jpy": 11366649727752.799,
       "krw": 111699685587277.61,
       "kwd": 25965280080.831043,
       "lkr": 27178373977706.043,
       "mmk": 178618132024307.88,
       "mxn": 1517114367219.2524,
       "myr": 377610356984.18616,
       "ngn": 39157999427193.22,
       "nok": 904182170515.5856,
       "nzd": 134497373112.3402,
       "php": 4689583849565.318,
       "pkr": 24134772434447.094,
       "pln": 352674591881.34863,
       "rub": 6668469091506.632,
       "sar": 318014734763.08014,
       "sek": 866609706824.3383,
       "sgd": 112438179014.56685,
       "thb": 2858841505647.263,
       "try": 1652896387130.4397,
       "twd": 2597909993310.1147,
       "uah": 3141577504209.1885,
       "vef": 8489979801.240941,
       "vnd": 1988498504490294.2,
       "zar": 1549037810494.2607,
       "xdr": 63020442595.93458,
       "xag": 3249894401.308044,
       "xau": 41325589.287194796,
       "bits": 2919519255242.0225,
       "sats": 291951925524202.25
     },
     "market_cap_percentage": {
       "btc": 45.39515033260631,
       "eth": 18.301175841330938,
       "usdt": 6.55880345659855,
       "bnb": 4.122502039408349,
       "usdc": 2.4110090838394775,
       "xrp": 1.9312565153814538,
       "ada": 1.099981914413052,
       "steth": 0.9547903424762558,
       "doge": 0.8826363663915439,
       "matic": 0.7349899856211685
     },
     "market_cap_change_percentage_24h_usd": -0.5225251945753591,
     "updated_at": 1683251622
   }
 }
 
 
 
 */


struct GlobalData: Codable {
    let data: MarketDataModel?
}


struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }  // enum
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }  // var marketCap
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd" }) {
            return "$" + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
            return item.value.asPercentString()
        }
        return ""
    }
    
    
}
