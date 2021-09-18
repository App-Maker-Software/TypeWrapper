//
//  ProxyProtocol.swift
//  
//
//  Created by Joseph Hinkle on 9/18/21.
//

public protocol ProxyProtocol {
    associatedtype Wrapped
}
public enum Proxy<Wrapped>: ProxyProtocol {}
