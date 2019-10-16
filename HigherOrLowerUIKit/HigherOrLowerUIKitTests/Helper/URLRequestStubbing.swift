//
//  URLRequestStubbing.swift
//  HigherOrLowerUIKitTests
//
//  Created by Dominic Campbell on 16/10/2019.
//

import Foundation

public struct URLRequestStubbing {
    
    public enum StubError: Error {
        case stubRemovedWhileActive
    }
    
    private class Interscptor: URLProtocol  {
        override class func canInit(with request: URLRequest) -> Bool {
            let result = findHandler(for: request)
            return result != nil
        }
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            return request
        }
        override func startLoading() {
            guard let handler = findHandler(for: request)  else {
                client?.urlProtocol(self, didFailWithError: StubError.stubRemovedWhileActive)
                return
            }
            if let error = handler.error {
                client?.urlProtocol(self, didFailWithError: error)
                return
            }
            if let data = handler.data {
                client?.urlProtocol(self, didLoad: data)
            }
            if let response = HTTPURLResponse(url: request.url!, statusCode: handler.statusCode ?? 200, httpVersion: nil, headerFields: nil) {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }
            client?.urlProtocolDidFinishLoading(self)
        }
        override func stopLoading() {}
    }
    
    private struct Handler {
        let host: String?
        let path: String
        let statusCode: Int?
        let data: Data?
        let error: Error?
    }
    
    private static var handlers = [Handler]()
    private static func findHandler(for request: URLRequest) -> Handler? {
        return handlers.first {
            return request.url?.path == $0.path
        }
    }
    public static func addStub(host: String? = nil, path: String, statusCode: Int = 200, data: Data) {
        if handlers.isEmpty {
            URLProtocol.registerClass(Interscptor.self)
        }
        handlers.append(Handler(host: host, path: path, statusCode: statusCode, data: data, error: nil))
    }
    public static func addStub(host: String? = nil, path: String, error: Error) {
        if handlers.isEmpty {
            URLProtocol.registerClass(Interscptor.self)
        }
        handlers.append(Handler(host: host, path: path, statusCode: nil, data: nil, error: error))
    }
    public static func removeStub(host: String? = nil, path: String) {
        handlers.removeAll {
            return $0.host == host
                && $0.path == path
        }
        if handlers.isEmpty {
            URLProtocol.unregisterClass(Interscptor.self)
        }
    }
    public static func removeAllStubs() {
        handlers.removeAll()
        URLProtocol.unregisterClass(Interscptor.self)
    }
}

extension URLRequestStubbing {
    public static func addStub<T: Encodable>(host: String? = nil, path: String, withObjectAsJSON object: T) {
        addStub(host: host, path: path, data: try! object.encodeJson())
    }
}
