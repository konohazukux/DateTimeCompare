//
//  Date+extensions.swift
//  DateTimeCompare
//
//  Created by TAKESHI SHIMADA on 2019/05/16.
//  Copyright © 2019 TAKESHI SHIMADA. All rights reserved.
//

import Foundation
import SwiftDate

extension Date: ExtensionCompatible {}

extension Extension where Base == Date {
    
    static private var dateFormatterForStringYYYYMMDD: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    var toStringYYYYMMDD: String {
        return Date.ex.dateFormatterForStringYYYYMMDD.string(from: base)
    }
    
    static private var dateFormatterForStringHHmmss: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    var toStringHHmmss: String {
        return Date.ex.dateFormatterForStringHHmmss.string(from: base)
    }
    
    static private var dateFormatterForStringDateAndTime: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter
    }()
    var toStringDateAndTime: String {
        return Date.ex.dateFormatterForStringDateAndTime.string(from: base)
    }
    
    /// 文字列出力 ISO8601
    var toString: String {
        let date   = base
        //let year   = date.year
        //let month  = String(format: "%02d", date.month)
        //let day    = String(format: "%02d", date.day)
        //let hour   = String(format: "%02d", date.hour)
        //let minute = String(format: "%02d", date.minute)
        //return "\(year)-\(month)-\(day)T\(hour):\(minute):00+09:00"
        
        return Date.ex.toISO8601String(from: date)
    }
    
    static private var dateFormatterForStringUTC: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        formatter.locale = Locale(identifier: "UTC")
        return formatter
    }()
    var toStringUTC: String {
        return Date.ex.dateFormatterForStringUTC.string(from: base)
    }
    
    /// 2018年01月01日(月)
    var toStringDate: String {
        let date   = base
        let year   = date.year
        let month  = String(format: "%02d", date.month)
        let day    = String(format: "%02d", date.day)
        let weekOfDay = base.ex.weekOfDayJP
        return "\(year)年\(month)月\(day)日(\(weekOfDay))"
    }
    
    var toStringDateExt: String {
        let date   = base
        let year   = date.year
        let month  = String(format: "%d", date.month)
        let day    = String(format: "%d", date.day)
        let weekOfDay = base.ex.weekOfDayJP
        return "\(year)年\(month)月\(day)日(\(weekOfDay))"
    }
    
    var toStringDateShoft: String {
        let date   = base
        let month  = String(format: "%d", date.month)
        let day    = String(format: "%d", date.day)
        let weekOfDay = base.ex.weekOfDayJP
        return "\(month)月\(day)日(\(weekOfDay))"
    }
    
    func toStringDateShort(timeZone: TimeZone) -> String {
        let date = base
        let df = Extension<Base>.toStringDateShortFormatter
        df.timeZone = timeZone
        return df.string(from: date)
    }
    
    private static let toStringDateShortFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ja_JP") //曜日を日本語で出すため
        df.dateFormat = "MM月dd日（EEE）"
        return df
    }()
    
    /// en_UK (e.g. 09DEC18)
    static private var dateFormatterForStringDateUK: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMMyy"
        formatter.locale = Locale.init(identifier: "en_UK")
        return formatter
    }()
    
    var toStringDateUK: String {
        let date   = base
        return "\(Date.ex.dateFormatterForStringDateUK.string(from: date).uppercased())"
    }
    
    /// yyyyMMdd
    static private var dateFormatterForStringDateYYYYMMDD: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        formatter.locale = Locale.init(identifier: "ja_JP")
        return formatter
    }()
    var toStringDateYYYYMMDD: String {
        let date   = base
        return "\(Date.ex.dateFormatterForStringDateYYYYMMDD.string(from: date).uppercased())"
    }
    
    /// 00:00
    var toStringTime: String {
        let hour   = String(format: "%02d", base.hour)
        let minute = String(format: "%02d", base.minute)
        return "\(hour):\(minute)";
    }
    
    /// hhmm
    var toStringTimeShort: String {
        let hour   = String(format: "%02d", base.hour)
        let minute = String(format: "%02d", base.minute)
        return "\(hour)\(minute)";
    }
    
    /// hh
    var toStringHour: String {
        let hour   = String(format: "%02d", base.hour)
        return "\(hour)";
    }
    
    /// X月
    var toStringMonth: String {
        return "\(base.month)月"
    }
    
    /// Tostring() 今月を返す
    static var ToStringMonth: String {
        return "\(Date().month)月"
    }
    
    /// ToStringDateの省略表示
    var toStringDateShort: String {
        let date   = base
        let month  = String(format: "%02d", date.month)
        let day    = String(format: "%02d", date.day)
        return "\(month)/\(day)"
    }
    
    /// Unixタイムを取得
    var unixtime: TimeInterval {
        return base.timeIntervalSince1970
    }
    
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: base)!
    }
    
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: base)!
    }
    
    /// 日本語曜日名を取得
    var weekOfDayJP: String {
        let weekdaySymbolIndex: Int = base.weekday - 1
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja")
        return formatter.shortWeekdaySymbols[weekdaySymbolIndex]
    }
    
    /// 今月が何日あるか取得、最終日の日付を取得
    var lastDay: Int?  {
        let calendar = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let range = calendar?.range(of: .day, in: .month, for: base)
        return range?.length
    }
    
    /// 前月
    var lastMonth: Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: Date())!
    }
    
    /// 月間のDateリストを取得
    var monthOfDays: [Date] {
        var array:[Date] = []
        let year  = base.year
        let month = base.month
        let calendar = Calendar(identifier: .gregorian)
        if let length = base.ex.lastDay {
            for i in (0..<length) {
                let data = calendar.date(from: DateComponents(year: year, month: month, day: i+1))
                if let `data` = data {
                    array.append(data)
                }
            }
        }
        return array
    }
    
    /// 開始時間、終了時間からその間の時間文字列を生成 xx時間xx分
    static func calcRangeDateTime(date1:Date, date2:Date) -> String {
        let length = abs(Int(date1.ex.unixtime - date2.ex.unixtime))
        
        let hour = length / 3600
        let min = (length % 3600) / 60
        
        return "\(hour)時間\(min)分"
    }
    
    /// change date timezone
    /// TODO: 機能していない
    func changeTimezone(timezone: Double) -> Date? {
        //let param = base.ex.toString
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = Locale(identifier: timezone)
        dateFormatter.timeZone = TimeZone(secondsFromGMT: Int(60 * 60 * timezone))
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let newDateStr = dateFormatter.string(from: base)
        //Quad.trace(debug: newDateStr)
        //Quad.trace(debug: dateFormatter.date(from: newDateStr)!)
        return dateFormatter.date(from: newDateStr)
    }
    
    
    /// X月X日(X)のフォーマットで文字列を取得
    ///
    /// - Parameter timezone: <#timezone description#>
    /// - Returns: <#return value description#>
    func getTimezoneMonthDay(timezone: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: Int(60 * 60 * timezone))
        dateFormatter.dateFormat = "MM月dd日(EEE)"
        return dateFormatter.string(from: base)
    }
    
    ///
    func getTimezoneDay(timezone: Double) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: Int(60 * 60 * timezone))
        dateFormatter.dateFormat = "dd"
        return Int(dateFormatter.string(from: base))!
    }
    
    func getTimezoneTime(timezone: Double) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: Int(60 * 60 * timezone))
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: base)
    }
    
    /// 日付の比較
    ///
    /// - Parameter date: Date
    /// - Returns: Bool
    func compareDate(date: Date) -> Bool {
        return  date.year == base.year && date.month == base.month && date.day == base.day
    }
    
    
    /// 現在を軸に、引数に指定された数値文のDateオブジェクトを生成する
    ///
    /// - Parameter before: Int
    /// - Returns: Date?
    func getBeforeDay(before: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: before, to: calendar.startOfDay(for: base))
    }
    
    /// 現在を軸に、引数に指定された数値文のDateオブジェクトを生成する
    ///
    /// - Parameter before: Int
    /// - Returns: Date?
    static func getBeforeDay(before: Int) -> Date? {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: before, to: calendar.startOfDay(for: Date()))
    }
    
    /// 7時間後の時間を算出
    func getAfter7hour() -> Date? {
        let calendar = Calendar.current
        let comps = DateComponents( hour: 7)
        return calendar.date(byAdding: comps, to: base)
    }
    
    
    /// Dateオブジェクトを作成
    ///
    /// - Parameters:
    ///   - yyyy: 2008
    ///   - MM: 04
    ///   - dd: 02
    ///   - hh: 22
    ///   - mm: 00
    ///   - ss: 00
    /// - Returns: Optional(Date)
    static func createDate(yyyy:Int, MM:Int, dd:Int, hh:Int, mm:Int, ss:Int) -> Date? {
        let year:String     = yyyy.description
        let month:String    = String(format:  "%02d", MM)
        let day:String      = String(format:  "%02d", dd)
        let hour:String     = String(format:  "%02d", hh)
        let minute:String   = String(format:  "%02d", mm)
        let sec:String      = String(format:  "%02d", ss)
        let str:String      = "\(year)/\(month)/\(day) \(hour):\(minute):\(sec)"
        let dateFormater    = DateFormatter()
        dateFormater.locale = Locale(identifier: "ja_JP")
        dateFormater.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let date = dateFormater.date(from: str)
        return date
    }
    
    /// 引数の分数を加算したDateオブジェクトを作成する
    ///
    /// - Parameter value: Int
    /// - Returns: Optional(Date)
    static func createDateFromMinute(value: Int) -> Date? {
        let calendar = Calendar.current
        let comps = DateComponents(hour: 0, minute: value)
        return calendar.date(byAdding: comps, to: Date())
    }
    
    
    /// ISO8601形式の文字列からDateを生成する
    static func fromISO8601(string: String?) -> Date? {
        guard let string = string else { return nil }
        guard let date = Date.ex.ISO8601Formatter.date(from: string) else { return nil }
        return date
    }
    
    private static let ISO8601Formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        return dateFormatter
    }()
    
    
    /// DateオブジェクトからISO8601形式のStringを返す
    static func toISO8601String(from date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        f.locale = Locale(identifier: "ja_JP")
        return f.string(from: date)
    }
    
    /// TimelineEntityのキーに含める日付形式からDateを生成する
    static func fromEntityKeyDate(string: String) -> Date? {
        guard let date = Date.ex.EntityKeyFormatter.date(from: string) else { return nil }
        return date
    }
    
    private static let EntityKeyFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        return dateFormatter
    }()
    
    /// 指定日の0時0分を返す
    static func startOfDay(date: Date) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.startOfDay(for: date)
    }
    
    /// 指定日の翌日の0時0分を返す
    static func startOfNextDay(date: Date) -> Date? {
        let calendar = Calendar(identifier: .gregorian)
        return calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: date))
    }
    
    /// 現在の時刻の次の単位分（5分ごと、15分ごと等）の日時を返す
    static func nextUnitMinutes(unit: Int = 15, date: Date = Date()) -> Date {
        let min: Int = date.minute
        let addMinutes = unit - (min % unit) // 次の単位分までの分数
        let dateInterval = DateInterval(start: date, duration: Double(addMinutes * 60))
        return dateInterval.end
    }
    
    var isToday: Bool {
        let today = Date()
        return (base.year == today.year && base.month == today.month && base.day == today.day) ? true : false
    }
    
    /// Timezoneの値を取得 (ex: -10,  9)
    ///
    /// - Returns: Double
//    static func localTimeZoneAbbreviation() -> Double {
//        let str = TimeZone.current.abbreviation() ?? "9" // クラッシュを回避に、日本時間設定、 v2で変更
//        //Quad.trace(debug: str)
//        if str.contains("JST")  {
//            return Double(9)
//        } else {
//            return Double(str.pregReplace(pattern: "UTC", with: ""))!
//        }
//    }
    
    static func getTimezoneValue(string: String) -> Double {
        let tz = string.dropFirst(19) // remove yyyy-MM-ddTHH:mm:ss part

        if tz.count == 3 { // assume +/-HH
            if let hour = Int(tz) {
                let time = Double(hour)
                return time
            }
        } else if tz.count == 5 { // assume +/-HHMM
            if let hour = Int(tz.dropLast(2)), let min = Int(tz.dropFirst(3)) {
                let time = Double(hour + min / 60)
                return time
            }
        } else if tz.count == 6 { // assime +/-HH:MM
            let parts = tz.components(separatedBy: ":")
            if parts.count == 2 {
                if let hour = Int(parts[0]), let min = Int(parts[1]) {
                    let time = Double(hour + min / 60)
                    return time
                }
            }
        }
        
        
        return 0
    }
    
    func dateHour() -> Date? {
        return Calendar.current.date(bySettingHour: base.hour, minute: 0, second: 0, of: base)
    }
}

extension Date {
    
    static private var dateFormatterForStringDate: DateFormatter = {
        
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyyMMdd"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    var toStringDate: String {
        
        return Date.dateFormatterForStringDate.string(from: self)
    }
    
    static private let dateFormatterForDateSlash: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    var toStringDateSlash: String {
        return Date.dateFormatterForDateSlash.string(from: self)
    }
    
    static private let dateFormatterForStringHHmm: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    var toStringHHmm: String {
        return Date.dateFormatterForStringHHmm.string(from: self)
    }
    
    static private let dateFormatterForStringSystemTime: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    var toStringSystemTime: String {
        return Date.dateFormatterForStringSystemTime.string(from: self)
    }
    
    /// タイムラインの各スケジュールがある時間台に所属しているかチェックするため
    static private let dateFormatterForDateHour: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyyMMddHH"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    var toStringTimelineDateHour: String {
        return Date.dateFormatterForDateHour.string(from: self)
    }
    
    static private let dateFormatterForMealEvent: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter
    }()
    var toStringMealTimeEventFormat: String {
        return Date.dateFormatterForMealEvent.string(from: self)
    }
    
    /// M月d日 H時
    static private let dateFormatterForTimelineLabel: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "M月d日 HH:mm"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    var toStringTimelineLabelFormatHdD: String {
        return Date.dateFormatterForTimelineLabel.string(from: self)
    }
    
    /// MM月dd日
    static private let dateFormatterForTimelineWeekDate: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "M月d日"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    var toStringTimelineWeekDate: String {
        let formatter = Date.dateFormatterForTimelineWeekDate
        
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ja")
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        let weekdayIndex = calendar.component(.weekday, from: self) - 1
        return formatter.string(from: self) + " (\(formatter.shortWeekdaySymbols[weekdayIndex]))"
    }
    
    static private let dateFormatterForTimelineFlightDate: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "ddMMMyy HHmm"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.locale = Locale.init(identifier: "en_UK")
        return formatter
    }()
    var toStringTimelineFlightDate: String {
        return Date.dateFormatterForTimelineFlightDate.string(from: self).uppercased()
    }
    
    /// タイムラインの0時は日付を表示させるため
    func isShowTimelineDate(_ timezone: String) -> Bool {
        
        var calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        calendar.locale = Locale.init(identifier: timezone)
        let components = calendar.dateComponents([.hour], from: self)
        return components.hour! == 0
    }
    
    /// タイムラインで日付ラベルを表示有無を判断
    static private let dateFormatterForIsShowDate: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "H"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    var isShowDate: Bool {
        return Date.dateFormatterForIsShowDate.string(from: self) == "0"
    }
    
    /// 18時から翌日6時までとそれ以外の時間のタイムラインの背景設定のため
    static private let dateFormatterForIsNight: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "HH"
        return formatter
    }()
    func isNight() -> Bool {
        let nightTime = ["18", "19", "20", "21", "22", "23", "00", "01", "02", "03", "04", "05"]
        let currentHour = Date.dateFormatterForIsNight.string(from: self)
        return nightTime.contains(currentHour)
    }
    
    /// 18時から翌日6時までとそれ以外の時間のタイムラインの背景設定のため
    static private let dateFormatterForIsStartedNight: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "HH"
        return formatter
    }()
    func isStartedNight() -> Bool {
        return Date.dateFormatterForIsStartedNight.string(from: self) == "18"
    }
    
    static private let dateFormatterForIsEndedNight: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "HH"
        return formatter
    }()
    func isEndedNight() -> Bool {
        return Date.dateFormatterForIsEndedNight.string(from: self) == "06"
    }
    
    static private let dateFormatterForIsCurrentTime: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyyMMddHH"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    func isCurrentTime(utcOffSet: Int?) -> Bool {
        
        guard let utcOffSet = utcOffSet else { return false }
        guard let timelineDate = self.addHour(addTime: utcOffSet), let currentDate = Date().addHour(addTime: utcOffSet) else { return false }
        
        let formatter = Date.dateFormatterForIsCurrentTime
        return (formatter.string(from: timelineDate) == formatter.string(from: currentDate))
    }
    
    static private let dateFormatterForCurrentMinutes: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "m"
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    var currentMinutes: String {
        return Date.dateFormatterForCurrentMinutes.string(from: Date())
    }
    
    func addHour(addTime: Int) -> Date? {
        return Calendar.init(identifier: Calendar.Identifier.gregorian).date(byAdding: Calendar.Component.hour, value: addTime, to: self)
    }
    
    static let dateFormatterForDateAndTime: DateFormatter = {
        let formatter = DateFormatter.init()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        return formatter
    }()
    func toStringDateAndTime(timeZoneStr: String) -> String {
        let formatter = Date.dateFormatterForDateAndTime
        formatter.timeZone = TimeZone(identifier: timeZoneStr)
        return Date.dateFormatterForDateAndTime.string(from: self)
    }
}
