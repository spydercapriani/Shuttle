//
//  Fields.swift
//  
//

import Foundation

public enum AppField: String, Codable, CaseIterable {
    case appClips
    case appCustomProductPages
    case appEvents
    case appInfos
    case appStoreVersions
    case availableInNewTerritories
    case availableTerritories
    case betaAppLocalizations
    case betaAppReviewDetail
    case betaGroups
    case betaLicenseAgreement
    case betaTesters
    case builds
    case bundleID = "bundleId"
    case ciProduct
    case contentRightsDeclaration
    case customerReviews
    case endUserLicenseAgreement
    case gameCenterEnabledVersions
    case inAppPurchases
    case inAppPurchasesV2
    case isOrEverWasMadeForKids
    case name
    case perfPowerMetrics
    case preOrder
    case preReleaseVersions
    case pricePoints
    case prices
    case primaryLocale
    case promotedPurchases
    case reviewSubmissions
    case sku
    case subscriptionGracePeriod
    case subscriptionGroups
    case subscriptionStatusURL = "subscriptionStatusUrl"
    case subscriptionStatusURLForSandbox = "subscriptionStatusUrlForSandbox"
    case subscriptionStatusURLVersion = "subscriptionStatusUrlVersion"
    case subscriptionStatusURLVersionForSandbox = "subscriptionStatusUrlVersionForSandbox"
}


