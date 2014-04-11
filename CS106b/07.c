#ifndef __mazelib_h
#define _mazelib_h

#include "genlib.h"

enum directionT { North, East, South, West };

struct pointT {
  int x, y;
};

void ReadMazeMap(string filename);

pointT GetStartPosition();

bool OutsideMaze(pointT pt);

bool WallExists(pointT pt, directionT dir);

void MarkSquare(pointT pt);
void unmarkSquare(pointT pt);
bool IsMarked(pointT pt);
#endif


bool SolveMaze(pointT pt) {
  if (OutsideMaze(pt)) return true;
  if (IsMarked(pt)) return false;
  MarkSquare(pt);
  for (int i = 0; i < 4; i++) {
    directionT dir = directionT(i);
    if (!WallExists(pt, dir)) {
      if (SolveMaze(AdjacentPoint(pt, dir))) {
        return true;
      }
    }
  }
  UnmarkSquare(pt);
  return false;
}

pointT AdjacentPoint(pointT pt, directionT dir) {
  pointT newpt = pt;
  switch (dir) {
    case North: newpt.y++; break;
    case South: newpt.y--; break;
    case East: newpt.x++; break;
    case West: newpt.x--; break;
  }
  return newpt;
}

// game of nim
const int NO_GOOD_MOVE = -1;
const int MAX = -1;
const NCOINS = 13;
enum playerT { Human, Computer };


int FindGoodMove(int ncoins) {
  for (int taken = 1; taken <= MAX; taken++) {
    if (IsBadMove(ncoins-taken)) return taken;
  }
  return NO_GOOD_MOVE;
}

bool IsBadPosition(int ncoins) {
  if (ncoins == 1) return true;
  return FindGoodMove(ncoins) == NO_GOOD_MOVE;
}

int main() {
  int ncoins, taken;
  playT whoseTurn;
  givenInstruction();
  whoseTurn = Human;
  while (ncoins > 1) {
    printf ("There are %d coins in the pile", ncoins);
    switch (whoseTurn) {
      case Human:
        taken = GetUserMove(ncoins);
        whoseTurn = Computer;
        break;
      case Computer:
        taken = ChooseComputerMove(ncoins);
        prinft("I'll take %d coins", taken);
        whoseTurn = Human;
        break;
    }
    ncoins -= taken;
  }
  annouceWinner(ncoins, whoseTurn);
  return 0;
}
int GetUserMove(int ncoins) {
  int taken, limit;
  while (true) {
    printf ("how many would you like ?");
    taken = GetInteger();
    if (MoveIsLegal(taken, coins)) break;
    limit = (ncoins < MAX) ? coins : MAX;
    printf ("invalid number");
  }
}
