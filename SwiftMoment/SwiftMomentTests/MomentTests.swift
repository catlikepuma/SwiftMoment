//
//  SwiftMomentTests.swift
//  SwiftMomentTests
//
//  Created by Adrian on 19/01/15.
//  Copyright (c) 2015 Adrian Kosmaczewski. All rights reserved.
//

import UIKit
import XCTest
import SwiftMoment

class MomentTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testTheMomentIsNow() {
        let today = moment()

        let date = NSDate()
        let cal = NSCalendar.currentCalendar()
        cal.timeZone = NSTimeZone.defaultTimeZone()
        let components = cal.components(.CalendarUnitYear | .CalendarUnitMonth
            | .CalendarUnitDay | .CalendarUnitHour
            | .CalendarUnitMinute | .CalendarUnitSecond
            | .CalendarUnitWeekdayOrdinal | .CalendarUnitWeekOfYear
            | .CalendarUnitQuarter, fromDate: date)

        XCTAssertEqual(today.year, components.year, "The moment contains the current year")
        XCTAssertEqual(today.month, components.month, "The moment contains the current month")
        XCTAssertEqual(today.day, components.day, "The moment contains the current day")
        XCTAssertEqual(today.hour, components.hour, "The moment contains the current hour")
        XCTAssertEqual(today.minute, components.minute, "The moment contains the current minute")
        XCTAssertEqual(today.second, components.second, "The moment contains the current second")
        XCTAssertEqual(today.weekOfYear, components.weekOfYear, "The moment contains the current week of year")
        XCTAssertEqual(today.weekdayOrdinal, components.weekdayOrdinal, "The moment contains the current number of the week day")
        XCTAssertEqual(today.quarter, components.quarter, "The moment contains the current quarter")

        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        let weekDay = formatter.stringFromDate(date)

        XCTAssertEqual(today.weekDay, weekDay, "The moment contains the current week day")
    }
    
    func testCanCreateMomentsWithSixComponents() {
        let obj = moment([2015, 01, 19, 20, 45, 34])!
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 01, "The month should match")
        XCTAssertEqual(obj.day, 19, "The day should match")
        XCTAssertEqual(obj.hour, 20, "The hour should match")
        XCTAssertEqual(obj.minute, 45, "The minute should match")
        XCTAssertEqual(obj.second, 34, "The second should match")
    }
    
    func testCanCreateMomentsWithFiveComponents() {
        let obj = moment([2015, 01, 19, 20, 45])!
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 01, "The month should match")
        XCTAssertEqual(obj.day, 19, "The day should match")
        XCTAssertEqual(obj.hour, 20, "The hour should match")
        XCTAssertEqual(obj.minute, 45, "The minute should match")
        XCTAssertEqual(obj.second, 0, "The second should be zero")
    }
    
    func testCanCreateMomentsWithFourComponents() {
        let obj = moment([2015, 01, 19, 20])!
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 01, "The month should match")
        XCTAssertEqual(obj.day, 19, "The day should match")
        XCTAssertEqual(obj.hour, 20, "The hour should match")
        XCTAssertEqual(obj.minute, 0, "The minute should be zero")
        XCTAssertEqual(obj.second, 0, "The second should be zero")
    }
    
    func testCanCreateMomentsWithThreeComponents() {
        let obj = moment([2015, 01, 19])!
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 01, "The month should match")
        XCTAssertEqual(obj.day, 19, "The day should match")
        XCTAssertEqual(obj.hour, 0, "The hour should be zero")
        XCTAssertEqual(obj.minute, 0, "The minute should be zero")
        XCTAssertEqual(obj.second, 0, "The second should be zero")
    }
    
    func testCanCreateMomentsWithTwoComponents() {
        let obj = moment([2015, 01])!
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 01, "The month should match")
        XCTAssertEqual(obj.day, 1, "The day should be one")
        XCTAssertEqual(obj.hour, 0, "The hour should be zero")
        XCTAssertEqual(obj.minute, 0, "The minute should be zero")
        XCTAssertEqual(obj.second, 0, "The second should be zero")
    }
    
    func testCanCreateMomentsWithOneComponent() {
        let obj = moment([2015])!
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 1, "The month should be January")
        XCTAssertEqual(obj.day, 1, "The day should be the first")
        XCTAssertEqual(obj.hour, 0, "The hour should be zero")
        XCTAssertEqual(obj.minute, 0, "The minute should be zero")
        XCTAssertEqual(obj.second, 0, "The second should be zero")
    }
    
    func testCanCreateWeirdDateFromComponents() {
        let timeZone = NSTimeZone(abbreviation: "GMT+01")!
        let obj = moment([-2015445, 76, -46, 876, 234565, -999], timeZone: timeZone)!
        XCTAssertEqual(obj.format(), "2015440-02-13 12:57:81 GMT+01:00", "The date is weird...!")
    }
    
    func testEmptyArrayOfComponentsYieldsNilMoment() {
        let obj = moment([])
        XCTAssert(obj == nil, "This should yield a nil moment object")
    }
    
    func testCreateDateWithDictionary() {
        let obj = moment(["year": 2015,
            "second": 34,
            "month": 01,
            "minute": 45,
            "day": 19,
            "hour": 20,
            "ignoredKey": 2342432])!
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 01, "The month should match")
        XCTAssertEqual(obj.day, 19, "The day should match")
        XCTAssertEqual(obj.hour, 20, "The hour should match")
        XCTAssertEqual(obj.minute, 45, "The minute should match")
        XCTAssertEqual(obj.second, 34, "The second should match")
    }

    func testEmptyDictionaryOfComponentsYieldsNilMoment() {
        let obj = moment(["whatever": 453])
        XCTAssert(obj == nil, "This should yield a nil moment object")
    }

    func testGibberishIsInvalid() {
        let gibberish = moment("whatever")
        XCTAssert(gibberish == nil, "Gibberish is invalid")
    }

    func testCanCompareMoments() {
        let today = moment()
        let today2 = moment(NSDate())
        let epoch = moment(0)

        let copy = moment(epoch)
        let ninetyFive = moment("1995-12-25")!
        XCTAssertNotEqual(ninetyFive, epoch, "The epoch did not happen in 1995")
        XCTAssertGreaterThan(today, ninetyFive, "Today happens after 1995")
        XCTAssertLessThan(ninetyFive, today, "Today does not happen before 1995")
        XCTAssert(today ~= today2, "Separated by some milliseconds")
        XCTAssertEqual(epoch, copy, "Copies are exactly equal")

        let similar = ninetyFive + 30.seconds
        XCTAssert(ninetyFive ~= similar, "Separated by 30 seconds")
    }

    func testEqualityIsCommutative() {
        let today = moment()
        let copy = moment(today)
        XCTAssertEqual(today, copy, "Equality is commutative")
        XCTAssertEqual(copy, today, "Equality is commutative")
    }

    func testCanUseDifferentSyntaxesToAddAndSubstract() {
        let now = moment()
        let one = now.add(5.hours).substract(45.years)
        let two = now.add(5, .Hours).substract(45, .Years)
        let three = now.add(5, "H").substract(45, "y")
        let four = now + 5.hours - 45.years

        XCTAssertEqual(one, two, "All the different operations yield the same results")
        XCTAssertEqual(one, three, "All the different operations yield the same results")
        XCTAssertEqual(one, four, "All the different operations yield the same results")
        XCTAssertEqual(two, three, "All the different operations yield the same results")
        XCTAssertEqual(two, four, "All the different operations yield the same results")
        XCTAssertEqual(three, four, "All the different operations yield the same results")
    }

    func testAdditionAndSubstractionAreInverse() {
        let today = moment()
        let soon = today + 1.hours
        let now = soon - 1.hours
        XCTAssertEqual(now, today, "Addition and substraction are inverse operations")
    }

    func testFindMaximumMoment() {
        let today = moment()
        let epoch = moment(0)
        let copy = moment(epoch)
        let format = "EE yyyy/dd--MMMM HH:mm ZZZZ"
        let birthday = moment("Tue 1973/4--September 12:30 GMT-03:00", format)!
        let ninetyFive = moment("1995-12-25")!
        let max = maximum(today, ninetyFive, birthday)!
        XCTAssertEqual(max, today, "Today is the maximum")
    }

    func testFindMinimumMoment() {
        let today = moment()
        let epoch = moment(0)
        let copy = moment(epoch)
        let format = "EE yyyy/dd--MMMM HH:mm ZZZZ"
        let birthday = moment("Tue 1973/4--September 12:30 GMT-03:00", format)!
        let ninetyFive = moment("1995-12-25")!
        let min = minimum(today, epoch, ninetyFive, birthday)!
        XCTAssertEqual(min, epoch, "The minimum is the epoch")
    }

    func testMinimumWithoutParametersReturnsNil() {
        let min = minimum()
        XCTAssert(min == nil, "Without parameters, minimum() == nil")
    }

    func testMaximumWithoutParametersReturnsNil() {
        let max = maximum()
        XCTAssert(max == nil, "Without parameters, maximum() == nil")
    }

    func testCanGetParametersByGetter() {
        let today = moment()
        let hours = today.get(.Hours)!
        XCTAssertEqual(hours, today.hour, "Can use an enum to get properties")

        let minute = today.get("m")!
        XCTAssertEqual(minute, today.minute, "Can use a string to get properties")
    }

    func testUsingWrongParameterNameYieldsNil() {
        let today = moment()
        let whatever = today.get("whatever")
        XCTAssert(whatever == nil, "There is no 'whatever' property to get")
    }

    func testFormatDates() {
        let timeZone = NSTimeZone(abbreviation: "GMT+01:00")!
        let birthday = moment("1973-09-04", timeZone: timeZone)!
        let str = birthday.format(dateFormat: "EE QQQQ yyyy/dd/MMMM ZZZZ")
        XCTAssertEqual(str, "Tue 3rd quarter 1973/04/September GMT+01:00", "Complicated string")

        let standard = birthday.format()
        XCTAssertEqual(standard, "1973-09-04 00:00:00 GMT+01:00", "Standard output")
    }

    func testFutureMoment() {
        let duration = future() - moment()
        XCTAssertGreaterThan(duration.years, 1000, "The future is really far away")
    }

    func testPastMoment() {
        let duration = moment() - past()
        XCTAssertLessThan(1000, duration.years, "The past is really far away")
    }
    
    func testTimeZoneSupport() {
        let zone = NSTimeZone(abbreviation: "PST")!
        let birthday = moment("1973-09-04 12:30:00", timeZone: zone)!
        let str = birthday.format(dateFormat: "EE QQQQ yyyy/dd/MMMM HH:mm ZZZZ")
        XCTAssertEqual(str, "Tue 3rd quarter 1973/04/September 12:30 GMT-07:00", "A date in San Francisco")
    }
    
    func testUTCMomentSupport() {
        let greenwich = utc()
        let str = greenwich.format(dateFormat: "ZZZZ")
        XCTAssertEqual(str, "GMT", "The timezone is UTC")
    }
    
    func testLocaleSupport() {
        let français = NSLocale(localeIdentifier: "fr_FR")
        let anniversaire = moment("1973-09-04 12:30:00", locale: français)!
        let jour = anniversaire.weekDay
        let mois = anniversaire.monthName
        XCTAssertEqual(jour, "mardi", "Eh ben bravo!")
        XCTAssertEqual(mois, "septembre", "Eh ben bravo!")

        let deutsch = NSLocale(localeIdentifier: "de_DE")
        let geburtstag = moment("1973-03-04 12:30:00", locale: deutsch)!
        let tag = geburtstag.weekDay
        let monat = geburtstag.monthName
        XCTAssertEqual(tag, "Sonntag", "Ach so!")
        XCTAssertEqual(monat, "März", "Ach so!")
    }
}
