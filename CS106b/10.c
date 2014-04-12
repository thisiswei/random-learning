#include <stdlib.h>

typedef struct {
  int cols;
  int rows;
} Board;

bool solve(Board board, int col) {
  if (col == board.cols) return true;
  for (int rowToTry; rowToTry <= board.rows; rowToTry ++) {
    if isSafe(board, rowToTry, col) {
      placeQueen(board, rowToTry, col);
      if solve(board, col++) return true;
      removeQueen(board, rowToTry, col);
    }
  }
  return false;
}
