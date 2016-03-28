function AIPlayer(data) {
	var data = data, seed, oppSeed;
	this.setSeed = function(_seed) {
		seed = _seed;
		oppSeed = _seed === Tile.NOUGHT ? Tile.CROSS : Tile.NOUGHT;
	}
	this.getSeed = function() {
		return seed;
	}
	this.move = function() {
		return minimax(2, seed)[1];
	}
	function minimax(depth, player) {
	
		var nextMoves = getValidMoves();

		var best = (player === seed) ? -1e100 : 1e100,
			current,
			bestidx = -1;

		if (nextMoves.length === 0 || depth === 0) {
			best = evaluate();
		} else {
			for (var i = nextMoves.length;i--;) {
				var m = nextMoves[i];
				data[m].set(player);

				if (player === seed) {
					current = minimax(depth-1, oppSeed)[0];
					if (current > best) {
						best = current;
						bestidx = m;
					}
				} else {
					current = minimax(depth-1, seed)[0];
					if (current < best) {
						best = current;
						bestidx = m;
					}
				}

				data[m].set(Tile.BLANK);
			}
		}

		return [best, bestidx];
	}
	function getValidMoves() {
		var nm = [];
		if (hasWon(seed) || hasWon(oppSeed)) {
			return nm;
		}
		for (var i = data.length;i--;) {
			if (!data[i].hasData()) {
				nm.push(i);
			}
		}
		return nm;
	}
	function evaluate() {
		var s = 0;
		s += evaluateLine(0, 1, 2, 3);
		s += evaluateLine(4, 5, 6, 7);
		s += evaluateLine(8, 9, 10, 11);
		s += evaluateLine(12, 13, 14, 15);
		
		s += evaluateLine(0, 4, 8, 12);
		s += evaluateLine(1, 5, 9, 13);
		s += evaluateLine(2, 6, 10, 14);
		s += evaluateLine(3, 7, 11, 15);
		
		return s;
	}
	
	function evaluateLine(idx1, idx2, idx3, idx4) {
		var s = 0;

		if (data[idx1].equals(seed)) {
			s = 1;
		} else if (data[idx1].equals(oppSeed)) {
			s = -1;
		}

		if (data[idx2].equals(seed)) {
			if (s === 1) {
				s = 10;
			} else if (s === -1) {
				return 0;
			} else {
				s = 1;
			}
		} else if (data[idx2].equals(oppSeed)) {
			if (s === -1) {
				s = -10;
			} else if (s === 1) {
				return 0;
			} else {
				s = -1;
			}
		}

		if (data[idx3].equals(seed)) {
			if (s > 0) {
				s *= 10;
			} else if (s < 0) {
				return 0;
			} else {
				s = 1;
			}
		} else if (data[idx3].equals(oppSeed)) {
			if (s < 0) {
				s *= 10;
			} else if (s > 0) {
				return 0;
			} else {
				s = -1;
			}
		}

		if (data[idx4].equals(seed)) {
			if (s < 0) {
				s *= 10;
			} else if (s > 0) {
				return 0;
			} else {
				s = 1;
			}
		} else if (data[idx4].equals(oppSeed)) {
			if (s > 0) {
				s *= 10;
			} else if (s < 0){
				return 0;
			} else {
				s = -1;
			}
		}

		return s;
	}

	var winnigPatterns = (function() {
		var wp = ["1110000000000000",
				  "0111000000000000",
				  "0000111000000000",
				  "0000011100000000",
				  "0000000011100000",
				  "0000000001110000",
				  "0000000000001110",
				  "0000000000000111",

				  "1000100010000000",
				  "0000100010001000",
				  "0100010001000000",
				  "0000010001000100",
				  "0010001000100000",
				  "0000001000100010",
				  "0001000100010000",
				  "0000000100010001",

				  "0100001000010000",
				  "1000010000100000",
				  "0000010000100001",
				  "0000100001000010",
				  "0010010010000000",
				  "0001000100010000",
				  "0000001001001000",
				  "0000000100100100",

				  ],
			r = new Array(wp.length);
		for (var i = wp.length;i--;) {
			r[i] = parseInt(wp[i], 2);
		}
		return r;
	})();
	var hasWon = this.hasWon = function(player) {
		var p = 0;
		for (var i = data.length;i--;) {
			if (data[i].equals(player)) {
				p |= (1 << i);
			}
		}
		for (var i = winnigPatterns.length;i--;) {
			var wp = winnigPatterns[i];
			if ((p & wp) === wp) return true;
		}
		return false;
	}
}