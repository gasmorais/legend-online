package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.RoyaltyTempInfo;
   import yishi.utils.SimpleDictionary;
   
   public class RoyaltyTempCate extends TemplateCate
   {
      
      private var _dic:SimpleDictionary;
      
      private var _tempXml:XML;
      
      private var _maxLv:int;
      
      private var _lvParam:Dictionary;
      
      private var _forbiddenLv:Dictionary;
      
      private var _outerTreasureLv:Dictionary;
      
      private var _innerTreasureLv:Dictionary;
      
      private var _warsoulParam:Dictionary;
      
      private var _minCoreLv:int;
      
      private var _finalRoadLv:Dictionary;
      
      private var _warSoulTowerLv:Dictionary;
      
      private var _pvpLv:Dictionary;
      
      private var _thessTowerLv:Dictionary;
      
      private var _thessdilaoLv:Dictionary;
      
      public function RoyaltyTempCate(param1:XMLList)
      {
         super(param1);
         _dic = new SimpleDictionary();
         _lvParam = new Dictionary();
         _forbiddenLv = new Dictionary();
         _outerTreasureLv = new Dictionary();
         _innerTreasureLv = new Dictionary();
         _finalRoadLv = new Dictionary();
         _warsoulParam = new Dictionary();
         _warSoulTowerLv = new Dictionary();
         _pvpLv = new Dictionary();
         _thessTowerLv = new Dictionary();
         _thessdilaoLv = new Dictionary();
      }
      
      public function getTemplates() : void
      {
         var _loc3_:String = null;
         if(_list)
         {
            for each(var _loc1_:XML in _list)
            {
               _loc3_ = _loc1_.@Id;
               if(!_dic[_loc3_])
               {
                  _dic[_loc3_] = createNode(_loc1_,RoyaltyTempInfo,_tempXml);
               }
            }
         }
         for each(var _loc2_:RoyaltyTempInfo in _dic)
         {
            if(_loc2_.OpenShopLevel > _maxLv)
            {
               _maxLv = _loc2_.OpenShopLevel;
            }
            if(!_lvParam[_loc2_.OpenShopLevel])
            {
               _lvParam[_loc2_.OpenShopLevel] = 999999;
            }
            if(_lvParam[_loc2_.OpenShopLevel] > _loc2_.RoyaltyLevel)
            {
               _lvParam[_loc2_.OpenShopLevel] = _loc2_.RoyaltyLevel;
            }
            if(!_warsoulParam[_loc2_.OpenWarSoul] || _warsoulParam[_loc2_.OpenWarSoul] > _loc2_.RoyaltyLevel)
            {
               _warsoulParam[_loc2_.OpenWarSoul] = _loc2_.RoyaltyLevel;
            }
            if(!_forbiddenLv[_loc2_.OpenForbidenBoss] || _forbiddenLv[_loc2_.OpenForbidenBoss] > _loc2_.RoyaltyLevel)
            {
               _forbiddenLv[_loc2_.OpenForbidenBoss] = _loc2_.RoyaltyLevel;
            }
            if(!_outerTreasureLv[_loc2_.OpenOutsideTreasureHoke] || _outerTreasureLv[_loc2_.OpenOutsideTreasureHoke] > _loc2_.RoyaltyLevel)
            {
               _outerTreasureLv[_loc2_.OpenOutsideTreasureHoke] = _loc2_.RoyaltyLevel;
            }
            if(!_innerTreasureLv[_loc2_.OpenInsideTreasureHoke] || _innerTreasureLv[_loc2_.OpenInsideTreasureHoke] > _loc2_.RoyaltyLevel)
            {
               _innerTreasureLv[_loc2_.OpenInsideTreasureHoke] = _loc2_.RoyaltyLevel;
            }
            if(!_finalRoadLv[_loc2_.OpenFinalRoad] || _finalRoadLv[_loc2_.OpenFinalRoad] > _loc2_.RoyaltyLevel)
            {
               _finalRoadLv[_loc2_.OpenFinalRoad] = _loc2_.RoyaltyLevel;
            }
            if(!_warSoulTowerLv[_loc2_.OpenWarSoulTower] || _warSoulTowerLv[_loc2_.OpenWarSoulTower] > _loc2_.RoyaltyLevel)
            {
               _warSoulTowerLv[_loc2_.OpenWarSoulTower] = _loc2_.RoyaltyLevel;
            }
            if(!_pvpLv[_loc2_.OpenPvp] || _pvpLv[_loc2_.OpenPvp] > _loc2_.RoyaltyLevel)
            {
               _pvpLv[_loc2_.OpenPvp] = _loc2_.RoyaltyLevel;
            }
            if(!_thessTowerLv[_loc2_.OpenTower] || _thessTowerLv[_loc2_.OpenTower] > _loc2_.RoyaltyLevel)
            {
               _thessTowerLv[_loc2_.OpenTower] = _loc2_.RoyaltyLevel;
            }
            if(!_thessdilaoLv[_loc2_.OpenDungeon] || _thessdilaoLv[_loc2_.OpenDungeon] > _loc2_.RoyaltyLevel)
            {
               _thessdilaoLv[_loc2_.OpenDungeon] = _loc2_.RoyaltyLevel;
            }
            if(_loc2_.OpenCoreTreasureHoke > 0)
            {
               if(_minCoreLv == 0 || _minCoreLv > _loc2_.RoyaltyLevel)
               {
                  _minCoreLv = _loc2_.RoyaltyLevel;
               }
            }
         }
         _list = null;
      }
      
      public function getTempInfoByLevel(param1:int) : RoyaltyTempInfo
      {
         initData();
         for each(var _loc2_:RoyaltyTempInfo in _dic)
         {
            if(_loc2_.RoyaltyLevel == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function initData() : void
      {
         if(_list)
         {
            getTemplates();
         }
      }
      
      public function get maxLv() : int
      {
         initData();
         return _maxLv;
      }
      
      public function get minCoreLv() : int
      {
         initData();
         return _minCoreLv;
      }
      
      public function getLockLv(param1:int) : int
      {
         initData();
         return int(_lvParam[param1]);
      }
      
      public function getOpenWarsoul(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         initData();
         var _loc4_:Array = [];
         for(var _loc5_:String in _warsoulParam)
         {
            _loc4_.push(int(_loc5_));
         }
         _loc4_.sort(16);
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_ = int(_loc4_[_loc3_]);
            if(param1 <= _loc2_)
            {
               return _warsoulParam[param1];
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function getForbiddenLv(param1:int) : int
      {
         initData();
         return int(_forbiddenLv[param1]);
      }
      
      public function getOuterTreasureLv(param1:int) : int
      {
         initData();
         return int(_outerTreasureLv[param1]);
      }
      
      public function getInnerTreasureLv(param1:int) : int
      {
         initData();
         return int(_innerTreasureLv[param1]);
      }
      
      public function getFinalRoadLv(param1:int) : int
      {
         initData();
         return int(_finalRoadLv[param1]);
      }
      
      public function getThessTowerLv(param1:int) : int
      {
         initData();
         return int(_thessTowerLv[param1]);
      }
      
      public function getWarSoulTowerLv(param1:int) : int
      {
         initData();
         return int(_warSoulTowerLv[param1]);
      }
      
      public function getdilaoLv(param1:int) : int
      {
         initData();
         return int(_thessdilaoLv[param1]);
      }
      
      public function getPvpLv(param1:int) : int
      {
         initData();
         return int(_pvpLv[param1]);
      }
      
      public function get dic() : SimpleDictionary
      {
         initData();
         return _dic;
      }
   }
}

