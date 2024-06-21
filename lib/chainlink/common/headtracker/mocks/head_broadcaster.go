// Code generated by mockery v2.42.2. DO NOT EDIT.

package mocks

import (
	context "context"

	headtracker "github.com/smartcontractkit/chainlink/v2/common/headtracker"
	mock "github.com/stretchr/testify/mock"

	types "github.com/smartcontractkit/chainlink/v2/common/types"
)

// HeadBroadcaster is an autogenerated mock type for the HeadBroadcaster type
type HeadBroadcaster[H types.Head[BLOCK_HASH], BLOCK_HASH types.Hashable] struct {
	mock.Mock
}

// BroadcastNewLongestChain provides a mock function with given fields: _a0
func (_m *HeadBroadcaster[H, BLOCK_HASH]) BroadcastNewLongestChain(_a0 H) {
	_m.Called(_a0)
}

// Close provides a mock function with given fields:
func (_m *HeadBroadcaster[H, BLOCK_HASH]) Close() error {
	ret := _m.Called()

	if len(ret) == 0 {
		panic("no return value specified for Close")
	}

	var r0 error
	if rf, ok := ret.Get(0).(func() error); ok {
		r0 = rf()
	} else {
		r0 = ret.Error(0)
	}

	return r0
}

// HealthReport provides a mock function with given fields:
func (_m *HeadBroadcaster[H, BLOCK_HASH]) HealthReport() map[string]error {
	ret := _m.Called()

	if len(ret) == 0 {
		panic("no return value specified for HealthReport")
	}

	var r0 map[string]error
	if rf, ok := ret.Get(0).(func() map[string]error); ok {
		r0 = rf()
	} else {
		if ret.Get(0) != nil {
			r0 = ret.Get(0).(map[string]error)
		}
	}

	return r0
}

// Name provides a mock function with given fields:
func (_m *HeadBroadcaster[H, BLOCK_HASH]) Name() string {
	ret := _m.Called()

	if len(ret) == 0 {
		panic("no return value specified for Name")
	}

	var r0 string
	if rf, ok := ret.Get(0).(func() string); ok {
		r0 = rf()
	} else {
		r0 = ret.Get(0).(string)
	}

	return r0
}

// Ready provides a mock function with given fields:
func (_m *HeadBroadcaster[H, BLOCK_HASH]) Ready() error {
	ret := _m.Called()

	if len(ret) == 0 {
		panic("no return value specified for Ready")
	}

	var r0 error
	if rf, ok := ret.Get(0).(func() error); ok {
		r0 = rf()
	} else {
		r0 = ret.Error(0)
	}

	return r0
}

// Start provides a mock function with given fields: _a0
func (_m *HeadBroadcaster[H, BLOCK_HASH]) Start(_a0 context.Context) error {
	ret := _m.Called(_a0)

	if len(ret) == 0 {
		panic("no return value specified for Start")
	}

	var r0 error
	if rf, ok := ret.Get(0).(func(context.Context) error); ok {
		r0 = rf(_a0)
	} else {
		r0 = ret.Error(0)
	}

	return r0
}

// Subscribe provides a mock function with given fields: callback
func (_m *HeadBroadcaster[H, BLOCK_HASH]) Subscribe(callback headtracker.HeadTrackable[H, BLOCK_HASH]) (H, func()) {
	ret := _m.Called(callback)

	if len(ret) == 0 {
		panic("no return value specified for Subscribe")
	}

	var r0 H
	var r1 func()
	if rf, ok := ret.Get(0).(func(headtracker.HeadTrackable[H, BLOCK_HASH]) (H, func())); ok {
		return rf(callback)
	}
	if rf, ok := ret.Get(0).(func(headtracker.HeadTrackable[H, BLOCK_HASH]) H); ok {
		r0 = rf(callback)
	} else {
		r0 = ret.Get(0).(H)
	}

	if rf, ok := ret.Get(1).(func(headtracker.HeadTrackable[H, BLOCK_HASH]) func()); ok {
		r1 = rf(callback)
	} else {
		if ret.Get(1) != nil {
			r1 = ret.Get(1).(func())
		}
	}

	return r0, r1
}

// NewHeadBroadcaster creates a new instance of HeadBroadcaster. It also registers a testing interface on the mock and a cleanup function to assert the mocks expectations.
// The first argument is typically a *testing.T value.
func NewHeadBroadcaster[H types.Head[BLOCK_HASH], BLOCK_HASH types.Hashable](t interface {
	mock.TestingT
	Cleanup(func())
}) *HeadBroadcaster[H, BLOCK_HASH] {
	mock := &HeadBroadcaster[H, BLOCK_HASH]{}
	mock.Mock.Test(t)

	t.Cleanup(func() { mock.AssertExpectations(t) })

	return mock
}