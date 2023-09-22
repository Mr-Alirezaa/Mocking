// @Mockable
protocol ProtocolWithMethods {
    func simpleMethod()
    func simpleMehtodThatReturns() -> Int
    func simpleMehtodThatReturns(param: String) -> String
    func simpleMehtodThatReturns(optionalParam: String?) -> String?
}

struct ProtocolWithMethodsMock: ProtocolWithMethods {
    enum Method {
        case simpleMethod(method: () -> Void)
        case simpleMehtodThatReturns(method: () -> Int)
        case simpleMehtodThatReturns__param(method: (String) -> String)
        case simpleMehtodThatReturns__optionalParam(method: (String?) -> String?)
    }

    enum MethodSignature {
        @_documentation(visibility: private)
        case _$simpleMethod

        @_documentation(visibility: private)
        case _$simpleMehtodThatReturns

        @_documentation(visibility: private)
        case _$simpleMehtodThatReturns__params(String)

        @_documentation(visibility: private)
        case _$simpleMehtodThatReturns__optionalParam(String?)

        static func simpleMethod() -> Self {
            _$simpleMethod
        }

        static func simpleMehtodThatReturns() -> Self {
            _$simpleMehtodThatReturns
        }

        static func simpleMehtodThatReturns(param: String) -> Self {
            _$simpleMehtodThatReturns__params(param)
        }

        static func simpleMehtodThatReturns(optionalParam: String?) -> Self {
            _$simpleMehtodThatReturns__optionalParam(optionalParam)
        }

    }

    private var _$mockRegistrar: MockRegisterar<Method>
    private var methodCalls: [Method]

    func given(_ methodSignature: MethodSignature, willProduce: Product) {
        self.given(.simpleMehtodThatReturns(), willProduce: <#T##Product#>)
    }

    func simpleMethod() {
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

enum Parameter<Value> {
    case value(Value)
    case matching((Value) -> Bool)
    case any
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
