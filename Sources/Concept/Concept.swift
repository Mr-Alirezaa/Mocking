// @Mockable
protocol ProtocolWithMethods {
    func simpleMethod()
    func simpleMehtodThatReturns() -> Int
    func simpleMehtodThatReturns(param: String) -> String
    func simpleMehtodThatReturns(optionalParam: String?) -> String?
}

class ProtocolWithMethodsMock: ProtocolWithMethods {
    enum Method {
        case simpleMethod(method: () -> Void)
        case simpleMehtodThatReturns(method: () -> Int)
        case simpleMehtodThatReturns__param(method: (String) -> String)
        case simpleMehtodThatReturns__optionalParam(method: (String?) -> String?)
    }

    struct MethodSignature {
        private enum UnderlyingSignature {
            case simpleMethod
            case simpleMehtodThatReturns
            case simpleMehtodThatReturns__params(Parameter<String>)
            case simpleMehtodThatReturns__optionalParam(Parameter<String?>)
        }

        private var underlyingSignature: UnderlyingSignature

        private init(_ underlyingSignature: UnderlyingSignature) {
            self.underlyingSignature = underlyingSignature
        }

        static func simpleMethod() -> Self {
            MethodSignature(.simpleMethod)
        }

        static func simpleMehtodThatReturns() -> Self {
            MethodSignature(.simpleMehtodThatReturns)
        }

        static func simpleMehtodThatReturns(param: Parameter<String>) -> Self {
            MethodSignature(.simpleMehtodThatReturns__params(param))
        }

        static func simpleMehtodThatReturns(optionalParam: Parameter<String?>) -> Self {
            MethodSignature(.simpleMehtodThatReturns__optionalParam(optionalParam))
        }
    }

    struct StubbedMethodCall {
        var methodSignature: MethodSignature
        var product: Product

        private init(methodSignature: MethodSignature, product: Product) {
            self.methodSignature = methodSignature
            self.product = product
        }

        static func simpleMethod() -> Self {
            StubbedMethodCall(
                methodSignature: .simpleMethod(),
                product: .value(() as Any)
            )
        }

        static func simpleMehtodThatReturns(willReturn returnedValue: Int) -> Self {
            StubbedMethodCall(
                methodSignature: .simpleMehtodThatReturns(),
                product: Product.value(returnedValue as Any)
            )
        }

        static func simpleMehtodThatReturns(param: Parameter<String>, willReturn returnedValue: String) -> Self {
            StubbedMethodCall(
                methodSignature: .simpleMehtodThatReturns(param: param),
                product: Product.value(returnedValue as Any)
            )
        }

        static func simpleMehtodThatReturns(optionalParam: Parameter<String?>, willReturn returnedValue: String?) -> Self {
            StubbedMethodCall(
                methodSignature: .simpleMehtodThatReturns(optionalParam: optionalParam),
                product: Product.value(returnedValue as Any)
            )
        }
    }

//    private var _$mockRegistrar: MockRegisterar<Method>
    private var methodCalls: [StubbedMethodCall] = []

    func given(_ stubbedMethodCall: StubbedMethodCall) {
        methodCalls.append(stubbedMethodCall)
    }

    func simpleMethod() {
        // Find first match from stubbed calls.
        // Get the returned from stubbed call.
        guard case let .simpleMethod(method) = methodCalls[0] else {
            fatalError()
        }
        return method()
    }

    func simpleMehtodThatReturns() -> Int {
        guard case let .simpleMehtodThatReturns(method) = methodCalls[0] else {
            fatalError()
        }
        return method()
    }

    func simpleMehtodThatReturns(param: String) -> String {
        guard case let .simpleMehtodThatReturns__param(method) = methodCalls[0] else {
            fatalError()
        }
        return method(param)
    }

    func simpleMehtodThatReturns(optionalParam: String?) -> String? {
        guard case let .simpleMehtodThatReturns__optionalParam(method) = methodCalls[0] else {
            fatalError()
        }
        return method(optionalParam)
    }
}

protocol Matchable {
    associatedtype Value
    func matches(_ other: Value) -> Bool
}

enum Parameter<Value>: Matchable {
    case value(Value)
    case matching((Value) -> Bool)
    case any

    func matches(_ other: Value) -> Bool {
        switch self {
        case .value(let value):
            value === value
        case .matching(let closure):
            closure(other)
        case .any:
            true
        }
    }
}

enum Product {
    case value(Any)
    case `throw`(Error)
}

struct MockRegisterar<T> {
    class _UnerlyingStorage {
        var methodCalls: [T] = []
    }
}
