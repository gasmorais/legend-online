package mvc.module.minos
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.manager.TempleteManager;
   
   public class MinosModel
   {
      
      public const ROW:int = 10;
      
      public const COL:int = 16;
      
      private var _seasonId:int = -1;
      
      public var state:int;
      
      public var beginTime:String;
      
      public var endTime:String;
      
      private var _currBattleLv:int;
      
      public var selectedNode:MinosNodeInfo;
      
      public var mapx:int = 5;
      
      public var mapy:int = 35;
      
      public var currDiff:int = 1;
      
      private var _configBuyMax:int;
      
      private var _configBuyPrice:int;
      
      private var _cofigBaseChallenge:int;
      
      private var _posDic:Dictionary = new Dictionary();
      
      private var _mapLvInfoDic:Dictionary = new Dictionary();
      
      private var _mapLvNodeInfoDic:Dictionary = new Dictionary();
      
      private var _rankDic:Dictionary = new Dictionary();
      
      private var _playInfo:MinosPlayerInfo = new MinosPlayerInfo();
      
      public function MinosModel()
      {
         super();
         initPrams();
      }
      
      private function initPrams() : void
      {
         var _loc5_:Array = null;
         var _loc2_:MinosPos = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _cofigBaseChallenge = TempleteManager.instance.getConfigValue("Minos_ChallengeCount");
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("Minos_ChallengePrice");
         if(_loc1_)
         {
            _loc5_ = _loc1_.ConfigValue.split(",");
            _configBuyMax = int(_loc5_[0]);
            _configBuyPrice = int(_loc5_[1]);
         }
         _loc3_ = 0;
         while(_loc3_ < 10)
         {
            _loc4_ = 0;
            while(_loc4_ < 16)
            {
               _loc2_ = new MinosPos(_loc4_,_loc3_);
               _posDic[_loc4_ + "_" + _loc3_] = _loc2_;
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      public function posInit() : void
      {
         for each(var _loc1_:MinosPos in _posDic)
         {
            _loc1_.init();
         }
      }
      
      public function reset() : void
      {
         for each(var _loc1_:MinosPos in _posDic)
         {
            _loc1_.retset();
         }
         _mapLvInfoDic = new Dictionary();
         _mapLvNodeInfoDic = new Dictionary();
         _rankDic = new Dictionary();
         _playInfo = new MinosPlayerInfo();
         currBattleLv = 0;
      }
      
      public function getPos(param1:int, param2:int) : MinosPos
      {
         return _posDic[param1 + "_" + param2];
      }
      
      public function radomMapEvents(param1:Array) : void
      {
         var _loc9_:MinosPos = null;
         var _loc7_:int = 0;
         var _loc10_:MinosPos = null;
         var _loc4_:Array = null;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc12_:MinosPos = null;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         for each(_loc9_ in _posDic)
         {
            _loc9_.retset();
         }
         var _loc6_:int = Math.random() * 10;
         var _loc11_:int = Math.random() * 16;
         var _loc8_:int = int(param1.length);
         _loc9_ = getPos(_loc11_,_loc6_);
         _loc7_ = param1.shift();
         _loc9_.size = _loc7_;
         _loc9_.evt = _loc7_;
         var _loc3_:Array = [_loc9_];
         while(param1.length > 0)
         {
            _loc7_ = param1.shift();
            if(_loc7_ == 1)
            {
               _loc10_ = _loc9_.radomSize1();
               if(_loc10_ != null)
               {
                  _loc10_.size = 1;
                  _loc10_.evt = 1;
                  _loc9_ = _loc10_;
                  _loc3_.push(_loc9_);
               }
            }
            else if(_loc7_ == 4)
            {
               _loc10_ = _loc9_.radomSize4();
               if(_loc10_ != null)
               {
                  _loc9_ = _loc10_;
                  _loc4_ = _loc10_.getDownRightBox4();
                  _loc5_ = 0;
                  while(_loc5_ < 4)
                  {
                     _loc12_ = _loc4_[_loc5_];
                     if(_loc12_.size > 0)
                     {
                        param1.push(_loc12_.size);
                        _loc13_ = _loc3_.indexOf(_loc12_);
                        if(_loc13_ != -1)
                        {
                           _loc3_.splice(_loc13_,1);
                        }
                     }
                     _loc12_.retset();
                     _loc12_.evt = 4;
                     _loc5_++;
                  }
                  _loc10_.size = 4;
                  _loc10_.evt = 4;
                  _loc3_.push(_loc9_);
               }
            }
            if(_loc10_ == null)
            {
               _loc14_ = Math.random() * _loc3_.length;
               _loc9_ = _loc3_[_loc14_];
               param1.push(_loc7_);
            }
         }
         for each(_loc9_ in _loc3_)
         {
            if(_loc9_.size == 4)
            {
               _loc2_++;
            }
         }
         trace("生成了多少个事件：",_loc3_.length,"4事件数量：",_loc2_);
      }
      
      public function getMapLvNodes(param1:int) : Dictionary
      {
         var _loc2_:Dictionary = _mapLvNodeInfoDic[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new Dictionary();
            _mapLvNodeInfoDic[param1] = _loc2_;
         }
         return _loc2_;
      }
      
      public function getMapNodeInfo(param1:int, param2:int, param3:int) : MinosNodeInfo
      {
         var _loc4_:Dictionary = getMapLvNodes(param1);
         return _loc4_[param2 + "_" + param3];
      }
      
      public function get mapLvInfoDic() : Dictionary
      {
         return _mapLvInfoDic;
      }
      
      public function get playInfo() : MinosPlayerInfo
      {
         return _playInfo;
      }
      
      public function get rankDic() : Dictionary
      {
         return _rankDic;
      }
      
      public function get currBattleLv() : int
      {
         return _currBattleLv;
      }
      
      public function set currBattleLv(param1:int) : void
      {
         if(_currBattleLv == param1)
         {
            return;
         }
         _currBattleLv = param1;
         selectedNode = null;
         mapx = 5;
         mapy = 35;
         currDiff = 1;
      }
      
      public function get configBuyMax() : int
      {
         return _configBuyMax;
      }
      
      public function get configBuyPrice() : int
      {
         return _configBuyPrice;
      }
      
      public function get cofigBaseChallenge() : int
      {
         return _cofigBaseChallenge;
      }
      
      public function get getReaNum() : int
      {
         return 0;
      }
      
      public function set seasonId(param1:int) : void
      {
         if(_seasonId == param1)
         {
            return;
         }
         _seasonId = param1;
         reset();
      }
   }
}

