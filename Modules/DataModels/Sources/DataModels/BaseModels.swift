//
//  File.swift
//  
//
//  Created by tanaz on 14/04/1401 AP.
//

import Foundation


public enum FetchState<T, E> {
  case loading
  case success(T)
  case failure(E)
}

extension FetchState: Equatable
where T: Equatable,
      E: Equatable {
  public static func == (lhs: FetchState<T, E>, rhs: FetchState<T, E>) -> Bool {
    switch lhs {
    case .loading:
      if case Self.loading = rhs {
        return true
      } else {
        return false
      }
    case .failure(let lhsError):
      if case Self.failure(let rhsError) = rhs {
        return lhsError == rhsError
      } else {
        return false
      }
    case .success(let lhsVal):
      if case Self.success(let rhsVal) = rhs {
        return lhsVal == rhsVal
      } else {
        return false
      }
    }
  }
}

extension FetchState
where T: Equatable,
      E: Equatable {
  public static func == (lhs: FetchState<T?, E>, rhs: FetchState<T?, E>) -> Bool {
    typealias CT = FetchState<T?, E>
    switch lhs {
    case .loading:
      if case CT.loading = rhs {
        return true
      } else {
        return false
      }
    case .failure(let lhsError):
      if case CT.failure(let rhsError) = rhs {
        return lhsError == rhsError
      } else {
        return false
      }
    case .success(let lhsVal):
      if case CT.success(let rhsVal) = rhs {
        return lhsVal == rhsVal
      } else {
        return false
      }
    }
  }
}

public enum SubmitState<T> {
  case request(T)
  case response(T)
}
