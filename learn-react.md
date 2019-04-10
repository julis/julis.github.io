# My Journal on Learning React

#### April 09, 2019

- React class render lifecycle  
  Based on [documentation](https://reactjs.org/docs/react-component.html) react class apparently has different lifecycle between mount, update and unmount. When react class **mounted** at first time, will call these methods in the following order :

  1. `constructor()`
  2. `static getDerivedStateFromProps()`
  3. `render()`
  4. `componentDidMount()`

  When class updated because some changes on props or its internal state. These methods are called in the following order:

  1. `static getDerivedStateFromProps()`
  2. `shouldComponentUpdate()`
  3. `render()`
  4. `getSnapshotBeforeUpdate()`
  5. `componentDidUpdate()`

  When class is removed from DOM will call:

  - `componentWillUnmount()`

* `Class` is always re-render problem.  
  `Class App` containing class `Header` and class `Footer`. In `App` I subscribe to some redux state called `Status` that will change periodically. This `Status` are mapped to props, and will be injected to `Footer` class. Because of that on every change/update of `Status` so the `App Class` will be re-render and also the childs of the class. To make `Header` class not re-render on every time App props changed, I make `Header` class to extends `PureComponent` instead of `Component`. Because on react document said, the `PureComponent` only will re-render if there is shallow changes in the props.
* `NavLink` not update active class name in Header.  
  Based on [this article](https://github.com/ReactTraining/react-router/blob/master/packages/react-router/docs/guides/blocked-updates.md), I wrapped the react component that contain NavLink with `withRouter` from React-Router library.
