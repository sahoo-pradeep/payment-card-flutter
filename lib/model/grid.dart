class Grid {
  String _gridA;
  String _gridB;
  String _gridC;
  String _gridD;
  String _gridE;
  String _gridF;
  String _gridG;
  String _gridH;
  String _gridI;
  String _gridJ;
  String _gridK;
  String _gridL;
  String _gridM;
  String _gridN;
  String _gridO;
  String _gridP;

  Grid.empty();

  String get gridP => _gridP;

  set gridP(String value) {
    _gridP = value;
  }

  String get gridO => _gridO;

  set gridO(String value) {
    _gridO = value;
  }

  String get gridN => _gridN;

  set gridN(String value) {
    _gridN = value;
  }

  String get gridM => _gridM;

  set gridM(String value) {
    _gridM = value;
  }

  String get gridL => _gridL;

  set gridL(String value) {
    _gridL = value;
  }

  String get gridK => _gridK;

  set gridK(String value) {
    _gridK = value;
  }

  String get gridJ => _gridJ;

  set gridJ(String value) {
    _gridJ = value;
  }

  String get gridI => _gridI;

  set gridI(String value) {
    _gridI = value;
  }

  String get gridH => _gridH;

  set gridH(String value) {
    _gridH = value;
  }

  String get gridG => _gridG;

  set gridG(String value) {
    _gridG = value;
  }

  String get gridF => _gridF;

  set gridF(String value) {
    _gridF = value;
  }

  String get gridE => _gridE;

  set gridE(String value) {
    _gridE = value;
  }

  String get gridD => _gridD;

  set gridD(String value) {
    _gridD = value;
  }

  String get gridC => _gridC;

  set gridC(String value) {
    _gridC = value;
  }

  String get gridB => _gridB;

  set gridB(String value) {
    _gridB = value;
  }

  String get gridA => _gridA;

  set gridA(String value) {
    _gridA = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["gridA"] = _gridA;
    map["gridB"] = _gridB;
    map["gridC"] = _gridC;
    map["gridD"] = _gridD;
    map["gridE"] = _gridE;
    map["gridF"] = _gridF;
    map["gridG"] = _gridG;
    map["gridH"] = _gridH;
    map["gridI"] = _gridI;
    map["gridJ"] = _gridJ;
    map["gridK"] = _gridK;
    map["gridL"] = _gridL;
    map["gridM"] = _gridM;
    map["gridN"] = _gridN;
    map["gridO"] = _gridO;
    map["gridP"] = _gridP;
    return map;
  }

  Grid.fromObject(dynamic obj){
  this._gridA = obj["gridA"];
  this._gridB = obj["gridB"];
  this._gridC = obj["gridC"];
  this._gridD = obj["gridD"];
  this._gridE = obj["gridE"];
  this._gridF = obj["gridF"];
  this._gridG = obj["gridG"];
  this._gridH = obj["gridH"];
  this._gridI = obj["gridI"];
  this._gridJ = obj["gridJ"];
  this._gridK = obj["gridK"];
  this._gridL = obj["gridL"];
  this._gridM = obj["gridM"];
  this._gridN = obj["gridN"];
  this._gridO = obj["gridO"];
  this._gridP = obj["gridP"];
  }

  @override
  String toString() {
    return 'Grid{_gridA: $_gridA, _gridB: $_gridB, _gridC: $_gridC, _gridD: $_gridD, _gridE: $_gridE, _gridF: $_gridF, _gridG: $_gridG, _gridH: $_gridH, _gridI: $_gridI, _gridJ: $_gridJ, _gridK: $_gridK, _gridL: $_gridL, _gridM: $_gridM, _gridN: $_gridN, _gridO: $_gridO, _gridP: $_gridP}';
  }
}