//
//  ContextualAlternates.swift
//  BonMot
//
//  Created by Zev Eisenberg on 11/5/16.
//  Copyright © 2016 Raizlabs. All rights reserved.
//

#if os(OSX)
    import AppKit
#else
    import UIKit
#endif

// This is not supported by watchOS
#if os(iOS) || os(tvOS) || os(OSX)
    public struct ContextualAlternates {

        var contextualAlternates: Bool?
        var swashAlternates: Bool?
        var contextualSwashAlternates: Bool?

        public init() { }

    }

    // Convenience constructors
    extension ContextualAlternates {

        public static func contextualAlternates(on isOn: Bool) -> ContextualAlternates {
            var alts = ContextualAlternates()
            alts.contextualAlternates = isOn
            return alts
        }

        public static func swashAlternates(on isOn: Bool) -> ContextualAlternates {
            var alts = ContextualAlternates()
            alts.swashAlternates = isOn
            return alts
        }

        public static func contextualSwashAlternates(on isOn: Bool) -> ContextualAlternates {
            var alts = ContextualAlternates()
            alts.contextualSwashAlternates = isOn
            return alts
        }

    }

    extension ContextualAlternates {

        mutating public func add(other theOther: ContextualAlternates) {
            contextualAlternates = theOther.contextualAlternates ?? contextualAlternates
            swashAlternates = theOther.swashAlternates ?? swashAlternates
            contextualSwashAlternates = theOther.contextualSwashAlternates ?? contextualSwashAlternates
        }

        public func byAdding(other theOther: ContextualAlternates) -> ContextualAlternates {
            var varSelf = self
            varSelf.add(other: theOther)
            return varSelf
        }

    }

    extension ContextualAlternates: FontFeatureProvider {

        public func featureSettings() -> [(type: Int, selector: Int)] {
            var selectors = [Int]()

            if let contextualAlternates = contextualAlternates {
                selectors.append(contextualAlternates ? kContextualAlternatesOnSelector : kContextualAlternatesOffSelector)
            }
            if let swashAlternates = swashAlternates {
                selectors.append(swashAlternates ? kSwashAlternatesOnSelector : kSwashAlternatesOffSelector)
            }
            if let contextualSwashAlternates = contextualSwashAlternates {
                selectors.append(contextualSwashAlternates ? kContextualSwashAlternatesOnSelector : kContextualSwashAlternatesOffSelector)
            }

            return selectors.map { (type: kContextualAlternatesType, selector: $0) }
        }

    }

    public func + (lhs: ContextualAlternates, rhs: ContextualAlternates) -> ContextualAlternates {
        return lhs.byAdding(other: rhs)
    }
#endif