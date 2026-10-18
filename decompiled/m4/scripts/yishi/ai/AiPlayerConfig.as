package yishi.ai
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class AiPlayerConfig
   {
      
      public static const FLOWER_WOMEN:int = 1;
      
      public static const FLAMAN:int = 2;
      
      public static const WARRIOR_WOMEN:int = 3;
      
      public static const SOLDIER:int = 4;
      
      public static const BUSSINESSMAN:int = 5;
      
      public static const BINLUO:int = 6;
      
      public static const SOLDIER_LEADER:int = 7;
      
      public static const DRUDGERY:int = 8;
      
      private var _pathDic:Dictionary;
      
      private var _specialDic:Dictionary;
      
      private var _allPath:Array;
      
      public function AiPlayerConfig()
      {
         super();
         _specialDic = new Dictionary();
         _specialDic[1] = new Dictionary();
         _specialDic[3] = new Dictionary();
         _specialDic[2] = new Dictionary();
         _specialDic[6] = new Dictionary();
         _specialDic[7] = new Dictionary();
         _specialDic[5] = new Dictionary();
         _pathDic = new Dictionary();
         _pathDic[1] = [new Point(522,722),new Point(606,672),new Point(671,633),new Point(704,614),new Point(753,643),new Point(780,650)];
         _pathDic[2] = [new Point(578,325),new Point(630,355),new Point(690,390),new Point(744,425),new Point(676,474),new Point(747,520),new Point(825,568),new Point(918,622),new Point(977,655)];
         _pathDic[3] = [new Point(357,400),new Point(407,428),new Point(437,455),new Point(508,498),new Point(567,533),new Point(530,557),new Point(490,582),new Point(437,615),new Point(384,646),new Point(340,624),new Point(283,590),new Point(248,568)];
         _pathDic[6] = [new Point(1080,578),new Point(972,649),new Point(917,609),new Point(1030,540),new Point(971,505)];
         _pathDic[5] = [new Point(729,602),new Point(804,551),new Point(780,533),new Point(925,450)];
         _pathDic[7] = [new Point(620,407)];
         _pathDic[4] = [new Point(1136,770)];
         _pathDic[8] = [new Point(379,1002)];
         _specialDic[5]["729_602"] = true;
         _specialDic[5]["780_533"] = true;
         _specialDic[5]["925_450"] = true;
         _specialDic[6]["1030_540"] = true;
         _specialDic[6]["971_505"] = true;
         _specialDic[6]["974_573"] = true;
         _specialDic[6]["1011_624"] = true;
         _specialDic[6]["1080_578"] = true;
         _specialDic[1]["606_672"] = true;
         _specialDic[1]["671_633"] = true;
         _specialDic[1]["753_643"] = true;
         _specialDic[2]["630_355"] = true;
         _specialDic[2]["690_390"] = true;
         _specialDic[2]["825_568"] = true;
         _specialDic[2]["918_622"] = true;
         _specialDic[3]["508_498"] = true;
         _specialDic[3]["530_557"] = true;
         _specialDic[3]["490_582"] = true;
         _specialDic[3]["437_615"] = true;
         _specialDic[3]["340_624"] = true;
         _specialDic[3]["283_590"] = true;
      }
      
      public function getPathByType(param1:int) : Array
      {
         return _pathDic[param1] as Array;
      }
      
      public function getSpecialByType(param1:int) : Dictionary
      {
         return _specialDic[param1] as Dictionary;
      }
   }
}

