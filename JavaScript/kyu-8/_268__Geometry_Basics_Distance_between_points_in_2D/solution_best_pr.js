// Codewars solution
function distanceBetweenPoints1(a, b) {
  return Math.hypot(a.x - b.x, a.y - b.y);
}
// My solution
function distanceBetweenPoints(a, b) {
  return Math.sqrt(Math.pow(b.x - a.x, 2) + Math.pow(b.y - a.y, 2));
}
