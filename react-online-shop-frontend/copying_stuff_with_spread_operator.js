const state = {
  a: 1,
  b: 2,
  c: [3, 4, 5],
  d: {
    e: 6,
    f: 7
  }
}

const copy = {...state}
const deepCopy = JSON.parse(JSON.stringify(state));
copy.a = 0;
// console.log(copy);
// copy.d.e = 0;
// console.log(copy);
// console.log(state);
deepCopy.d.e = 0;
console.log(deepCopy);
console.log(state);
