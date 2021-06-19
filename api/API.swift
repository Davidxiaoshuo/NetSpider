// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// Location input type.
public struct Location: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  /// - Parameters:
  ///   - latitude: The latitude of location
  ///   - longitude: The longitude of location
  public init(latitude: Double, longitude: Double) {
    graphQLMap = ["latitude": latitude, "longitude": longitude]
  }

  /// The latitude of location
  public var latitude: Double {
    get {
      return graphQLMap["latitude"] as! Double
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "latitude")
    }
  }

  /// The longitude of location
  public var longitude: Double {
    get {
      return graphQLMap["longitude"] as! Double
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "longitude")
    }
  }
}

/// Token type enum
public enum TokenTypeEnum: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// Anonymous login
  case anonymous
  /// APP user login
  case app
  /// Robot login
  case robot
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "ANONYMOUS": self = .anonymous
      case "APP": self = .app
      case "ROBOT": self = .robot
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .anonymous: return "ANONYMOUS"
      case .app: return "APP"
      case .robot: return "ROBOT"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: TokenTypeEnum, rhs: TokenTypeEnum) -> Bool {
    switch (lhs, rhs) {
      case (.anonymous, .anonymous): return true
      case (.app, .app): return true
      case (.robot, .robot): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [TokenTypeEnum] {
    return [
      .anonymous,
      .app,
      .robot,
    ]
  }
}

/// Captcha type enum
public enum CaptchaTypeEnum: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// Registration constant
  case register
  /// Reset password the constant
  case resetPassword
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "REGISTER": self = .register
      case "RESET_PASSWORD": self = .resetPassword
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .register: return "REGISTER"
      case .resetPassword: return "RESET_PASSWORD"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: CaptchaTypeEnum, rhs: CaptchaTypeEnum) -> Bool {
    switch (lhs, rhs) {
      case (.register, .register): return true
      case (.resetPassword, .resetPassword): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [CaptchaTypeEnum] {
    return [
      .register,
      .resetPassword,
    ]
  }
}

public final class CheckCaptchaQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query checkCaptcha($region: Region!, $channelValue: String!, $captcha: String!) {
      checkCaptcha(region: $region, name: $channelValue, captcha: $captcha) {
        __typename
        result
      }
    }
    """

  public let operationName: String = "checkCaptcha"

  public var region: String
  public var channelValue: String
  public var captcha: String

  public init(region: String, channelValue: String, captcha: String) {
    self.region = region
    self.channelValue = channelValue
    self.captcha = captcha
  }

  public var variables: GraphQLMap? {
    return ["region": region, "channelValue": channelValue, "captcha": captcha]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("checkCaptcha", arguments: ["region": GraphQLVariable("region"), "name": GraphQLVariable("channelValue"), "captcha": GraphQLVariable("captcha")], type: .object(CheckCaptcha.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(checkCaptcha: CheckCaptcha? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "checkCaptcha": checkCaptcha.flatMap { (value: CheckCaptcha) -> ResultMap in value.resultMap }])
    }

    /// Check captcha code
    public var checkCaptcha: CheckCaptcha? {
      get {
        return (resultMap["checkCaptcha"] as? ResultMap).flatMap { CheckCaptcha(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "checkCaptcha")
      }
    }

    public struct CheckCaptcha: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["BoolResult"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("result", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(result: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "BoolResult", "result": result])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var result: Bool? {
        get {
          return resultMap["result"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "result")
        }
      }
    }
  }
}

public final class CountryListQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query countryList {
      countryList {
        __typename
        region
        name
        diallingCode
        weight
      }
    }
    """

  public let operationName: String = "countryList"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("countryList", type: .list(.object(CountryList.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(countryList: [CountryList?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "countryList": countryList.flatMap { (value: [CountryList?]) -> [ResultMap?] in value.map { (value: CountryList?) -> ResultMap? in value.flatMap { (value: CountryList) -> ResultMap in value.resultMap } } }])
    }

    /// Country list
    public var countryList: [CountryList?]? {
      get {
        return (resultMap["countryList"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [CountryList?] in value.map { (value: ResultMap?) -> CountryList? in value.flatMap { (value: ResultMap) -> CountryList in CountryList(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [CountryList?]) -> [ResultMap?] in value.map { (value: CountryList?) -> ResultMap? in value.flatMap { (value: CountryList) -> ResultMap in value.resultMap } } }, forKey: "countryList")
      }
    }

    public struct CountryList: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Country"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("region", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("diallingCode", type: .nonNull(.scalar(String.self))),
          GraphQLField("weight", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(region: String, name: String, diallingCode: String, weight: Int) {
        self.init(unsafeResultMap: ["__typename": "Country", "region": region, "name": name, "diallingCode": diallingCode, "weight": weight])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Geographic information：region
      public var region: String {
        get {
          return resultMap["region"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "region")
        }
      }

      /// Geographic information：name
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// Geographic information：diallingCode
      public var diallingCode: String {
        get {
          return resultMap["diallingCode"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "diallingCode")
        }
      }

      /// Geographic information：weight
      public var weight: Int {
        get {
          return resultMap["weight"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "weight")
        }
      }
    }
  }
}

public final class DefaultCountryQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query defaultCountry($location: Location) {
      defaultCountry(location: $location) {
        __typename
        region
        name
        diallingCode
        weight
      }
    }
    """

  public let operationName: String = "defaultCountry"

  public var location: Location?

  public init(location: Location? = nil) {
    self.location = location
  }

  public var variables: GraphQLMap? {
    return ["location": location]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("defaultCountry", arguments: ["location": GraphQLVariable("location")], type: .object(DefaultCountry.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(defaultCountry: DefaultCountry? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "defaultCountry": defaultCountry.flatMap { (value: DefaultCountry) -> ResultMap in value.resultMap }])
    }

    /// Default country for current device
    public var defaultCountry: DefaultCountry? {
      get {
        return (resultMap["defaultCountry"] as? ResultMap).flatMap { DefaultCountry(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "defaultCountry")
      }
    }

    public struct DefaultCountry: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Country"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("region", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("diallingCode", type: .nonNull(.scalar(String.self))),
          GraphQLField("weight", type: .nonNull(.scalar(Int.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(region: String, name: String, diallingCode: String, weight: Int) {
        self.init(unsafeResultMap: ["__typename": "Country", "region": region, "name": name, "diallingCode": diallingCode, "weight": weight])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Geographic information：region
      public var region: String {
        get {
          return resultMap["region"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "region")
        }
      }

      /// Geographic information：name
      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      /// Geographic information：diallingCode
      public var diallingCode: String {
        get {
          return resultMap["diallingCode"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "diallingCode")
        }
      }

      /// Geographic information：weight
      public var weight: Int {
        get {
          return resultMap["weight"]! as! Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "weight")
        }
      }
    }
  }
}

public final class IsRegisteredQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query isRegistered($channelValue: String!, $region: Region!) {
      registered(mobile: $channelValue, region: $region) {
        __typename
        result
      }
    }
    """

  public let operationName: String = "isRegistered"

  public var channelValue: String
  public var region: String

  public init(channelValue: String, region: String) {
    self.channelValue = channelValue
    self.region = region
  }

  public var variables: GraphQLMap? {
    return ["channelValue": channelValue, "region": region]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("registered", arguments: ["mobile": GraphQLVariable("channelValue"), "region": GraphQLVariable("region")], type: .object(Registered.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(registered: Registered? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "registered": registered.flatMap { (value: Registered) -> ResultMap in value.resultMap }])
    }

    /// Query specified user information by mobile number
    public var registered: Registered? {
      get {
        return (resultMap["registered"] as? ResultMap).flatMap { Registered(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "registered")
      }
    }

    public struct Registered: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["BoolResult"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("result", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(result: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "BoolResult", "result": result])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var result: Bool? {
        get {
          return resultMap["result"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "result")
        }
      }
    }
  }
}

public final class ResetPasswordMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation resetPassword($region: Region!, $channelValue: String!, $password: String!, $captcha: String!) {
      resetPassword(region: $region, name: $channelValue, password: $password, captcha: $captcha) {
        __typename
        token
        tokenType
      }
    }
    """

  public let operationName: String = "resetPassword"

  public var region: String
  public var channelValue: String
  public var password: String
  public var captcha: String

  public init(region: String, channelValue: String, password: String, captcha: String) {
    self.region = region
    self.channelValue = channelValue
    self.password = password
    self.captcha = captcha
  }

  public var variables: GraphQLMap? {
    return ["region": region, "channelValue": channelValue, "password": password, "captcha": captcha]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("resetPassword", arguments: ["region": GraphQLVariable("region"), "name": GraphQLVariable("channelValue"), "password": GraphQLVariable("password"), "captcha": GraphQLVariable("captcha")], type: .object(ResetPassword.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(resetPassword: ResetPassword? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "resetPassword": resetPassword.flatMap { (value: ResetPassword) -> ResultMap in value.resultMap }])
    }

    /// Reset user password
    public var resetPassword: ResetPassword? {
      get {
        return (resultMap["resetPassword"] as? ResultMap).flatMap { ResetPassword(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "resetPassword")
      }
    }

    public struct ResetPassword: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Token"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("token", type: .scalar(String.self)),
          GraphQLField("tokenType", type: .scalar(TokenTypeEnum.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(token: String? = nil, tokenType: TokenTypeEnum? = nil) {
        self.init(unsafeResultMap: ["__typename": "Token", "token": token, "tokenType": tokenType])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The token of the authorization
      public var token: String? {
        get {
          return resultMap["token"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }

      /// The type of token
      public var tokenType: TokenTypeEnum? {
        get {
          return resultMap["tokenType"] as? TokenTypeEnum
        }
        set {
          resultMap.updateValue(newValue, forKey: "tokenType")
        }
      }
    }
  }
}

public final class SendCaptchaMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation sendCaptcha($region: Region!, $channelValue: String!, $captchaType: CaptchaTypeEnum!) {
      sendCaptcha(region: $region, name: $channelValue, captchaType: $captchaType) {
        __typename
        result
      }
    }
    """

  public let operationName: String = "sendCaptcha"

  public var region: String
  public var channelValue: String
  public var captchaType: CaptchaTypeEnum

  public init(region: String, channelValue: String, captchaType: CaptchaTypeEnum) {
    self.region = region
    self.channelValue = channelValue
    self.captchaType = captchaType
  }

  public var variables: GraphQLMap? {
    return ["region": region, "channelValue": channelValue, "captchaType": captchaType]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("sendCaptcha", arguments: ["region": GraphQLVariable("region"), "name": GraphQLVariable("channelValue"), "captchaType": GraphQLVariable("captchaType")], type: .object(SendCaptcha.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(sendCaptcha: SendCaptcha? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "sendCaptcha": sendCaptcha.flatMap { (value: SendCaptcha) -> ResultMap in value.resultMap }])
    }

    /// Send captcha Mutation
    public var sendCaptcha: SendCaptcha? {
      get {
        return (resultMap["sendCaptcha"] as? ResultMap).flatMap { SendCaptcha(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "sendCaptcha")
      }
    }

    public struct SendCaptcha: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["BoolResult"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("result", type: .scalar(Bool.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(result: Bool? = nil) {
        self.init(unsafeResultMap: ["__typename": "BoolResult", "result": result])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var result: Bool? {
        get {
          return resultMap["result"] as? Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "result")
        }
      }
    }
  }
}

public final class SignInMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation signIn($region: Region!, $channelValue: String!, $password: String!) {
      signIn(region: $region, name: $channelValue, password: $password) {
        __typename
        token
        tokenType
      }
    }
    """

  public let operationName: String = "signIn"

  public var region: String
  public var channelValue: String
  public var password: String

  public init(region: String, channelValue: String, password: String) {
    self.region = region
    self.channelValue = channelValue
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["region": region, "channelValue": channelValue, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("signIn", arguments: ["region": GraphQLVariable("region"), "name": GraphQLVariable("channelValue"), "password": GraphQLVariable("password")], type: .object(SignIn.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(signIn: SignIn? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "signIn": signIn.flatMap { (value: SignIn) -> ResultMap in value.resultMap }])
    }

    /// Sign in Mutation
    public var signIn: SignIn? {
      get {
        return (resultMap["signIn"] as? ResultMap).flatMap { SignIn(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "signIn")
      }
    }

    public struct SignIn: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Token"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("token", type: .scalar(String.self)),
          GraphQLField("tokenType", type: .scalar(TokenTypeEnum.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(token: String? = nil, tokenType: TokenTypeEnum? = nil) {
        self.init(unsafeResultMap: ["__typename": "Token", "token": token, "tokenType": tokenType])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The token of the authorization
      public var token: String? {
        get {
          return resultMap["token"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }

      /// The type of token
      public var tokenType: TokenTypeEnum? {
        get {
          return resultMap["tokenType"] as? TokenTypeEnum
        }
        set {
          resultMap.updateValue(newValue, forKey: "tokenType")
        }
      }
    }
  }
}

public final class SignUpMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation signUp($region: Region!, $channelValue: String!, $password: String!, $captcha: String!) {
      signUp(region: $region, name: $channelValue, password: $password, captcha: $captcha) {
        __typename
        token
        tokenType
      }
    }
    """

  public let operationName: String = "signUp"

  public var region: String
  public var channelValue: String
  public var password: String
  public var captcha: String

  public init(region: String, channelValue: String, password: String, captcha: String) {
    self.region = region
    self.channelValue = channelValue
    self.password = password
    self.captcha = captcha
  }

  public var variables: GraphQLMap? {
    return ["region": region, "channelValue": channelValue, "password": password, "captcha": captcha]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("signUp", arguments: ["region": GraphQLVariable("region"), "name": GraphQLVariable("channelValue"), "password": GraphQLVariable("password"), "captcha": GraphQLVariable("captcha")], type: .object(SignUp.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(signUp: SignUp? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "signUp": signUp.flatMap { (value: SignUp) -> ResultMap in value.resultMap }])
    }

    /// Signup Mutation
    public var signUp: SignUp? {
      get {
        return (resultMap["signUp"] as? ResultMap).flatMap { SignUp(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "signUp")
      }
    }

    public struct SignUp: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Token"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("token", type: .scalar(String.self)),
          GraphQLField("tokenType", type: .scalar(TokenTypeEnum.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(token: String? = nil, tokenType: TokenTypeEnum? = nil) {
        self.init(unsafeResultMap: ["__typename": "Token", "token": token, "tokenType": tokenType])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The token of the authorization
      public var token: String? {
        get {
          return resultMap["token"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "token")
        }
      }

      /// The type of token
      public var tokenType: TokenTypeEnum? {
        get {
          return resultMap["tokenType"] as? TokenTypeEnum
        }
        set {
          resultMap.updateValue(newValue, forKey: "tokenType")
        }
      }
    }
  }
}
