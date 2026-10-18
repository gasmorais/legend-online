package mvc.module.findback
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class FindBackModel extends EventDispatcher
   {
      
      public static const FINDBACK_TYPE_GOLD:int = 1;
      
      public static const FINDBACK_TYPE_POINT:int = 2;
      
      public var itemsUsePoint:Vector.<FindBackItemInfo>;
      
      public var itemsUseGold:Vector.<FindBackItemInfo>;
      
      public var received:Boolean = false;
      
      public function FindBackModel()
      {
         super();
         itemsUsePoint = new Vector.<FindBackItemInfo>();
         itemsUseGold = new Vector.<FindBackItemInfo>();
      }
      
      public static function sortRewards(param1:FindBackRewardInfo, param2:FindBackRewardInfo) : int
      {
         var _loc4_:GoodsTemplateInfo = param1.goodsTempInfo;
         var _loc3_:GoodsTemplateInfo = param2.goodsTempInfo;
         if(!(_loc4_ && _loc3_))
         {
            return 0;
         }
         if(_loc4_.Profile > _loc3_.Profile)
         {
            return -1;
         }
         if(_loc4_.Profile < _loc3_.Profile)
         {
            return 1;
         }
         if(param1.count > param2.count)
         {
            return -1;
         }
         if(param1.count < param2.count)
         {
            return 1;
         }
         return 0;
      }
      
      public static function sortItem(param1:FindBackItemInfo, param2:FindBackItemInfo) : int
      {
         if(param1.type > param2.type)
         {
            return 1;
         }
         if(param1.type < param2.type)
         {
            return -1;
         }
         return 0;
      }
      
      public function addItem(param1:FindBackItemInfo) : void
      {
         var _loc2_:* = undefined;
         param1.model = this;
         if(param1.findType == 1)
         {
            _loc2_ = itemsUseGold;
         }
         else if(param1.findType == 2)
         {
            _loc2_ = itemsUsePoint;
         }
         if(_loc2_ && _loc2_.indexOf(param1) == -1)
         {
            _loc2_.push(param1);
         }
      }
      
      public function removeFindBackItemByType(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < itemsUsePoint.length)
         {
            if(itemsUsePoint[_loc2_].type == param1)
            {
               itemsUsePoint.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < itemsUseGold.length)
         {
            if(itemsUseGold[_loc3_].type == param1)
            {
               itemsUseGold.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
         dispatchChangeEvent();
      }
      
      public function findBackAll() : void
      {
         itemsUsePoint.length = 0;
         received = true;
         dispatchChangeEvent();
      }
      
      public function dispatchChangeEvent() : void
      {
         dispatchEvent(new Event("change"));
      }
      
      public function getGoldReward(param1:int) : FindBackItemInfo
      {
         var _loc3_:FindBackItemInfo = null;
         var _loc2_:* = null;
         for each(_loc2_ in itemsUseGold)
         {
            if(_loc2_.type == param1)
            {
               _loc3_ = _loc2_;
               break;
            }
         }
         return _loc3_;
      }
      
      public function getReceiveItemCostPointAndGold(param1:int) : Array
      {
         var _loc5_:FindBackItemInfo = null;
         var _loc4_:FindBackItemInfo = null;
         var _loc3_:* = null;
         var _loc2_:Array = [0,0];
         for each(_loc3_ in itemsUsePoint)
         {
            if(_loc3_.type == param1)
            {
               _loc4_ = _loc3_;
               break;
            }
         }
         for each(_loc3_ in itemsUseGold)
         {
            if(_loc3_.type == param1)
            {
               _loc5_ = _loc3_;
               break;
            }
         }
         if(_loc4_)
         {
            var _loc7_:int = 0;
            var _loc6_:Number = _loc2_[_loc7_] + _loc4_.costPoint;
            _loc2_[_loc7_] = _loc6_;
         }
         if(_loc5_)
         {
            var _loc9_:int = 1;
            var _loc8_:Number = _loc2_[_loc9_] + _loc5_.costGold;
            _loc2_[_loc9_] = _loc8_;
         }
         return _loc2_;
      }
      
      public function getReceiveAllCostPointAndGold() : Array
      {
         var _loc3_:* = null;
         var _loc1_:Array = null;
         var _loc2_:Array = [0,0];
         for each(_loc3_ in itemsUsePoint)
         {
            _loc2_[0] += _loc3_.costPoint;
         }
         for each(_loc3_ in itemsUseGold)
         {
            _loc2_[1] += _loc3_.costGold;
         }
         var _loc4_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("item_back2");
         var _loc7_:Array = _loc4_ != null ? _loc4_.ConfigValue.split("|") : "1|0.8|0.7|0.7|0.7|0.7|0.7|0.7".split("|");
         _loc4_ = TempleteManager.instance.getConfigInfoByConfigName("item_back1");
         var _loc5_:Array = _loc4_ != null ? _loc4_.ConfigValue.split("|") : "1|0.8|0.7|0.7|0.7|0.7|0.7|0.7".split("|");
         var _loc6_:Number = 1;
         var _loc8_:Number = 1;
         if(_loc7_[itemsUsePoint.length - 1])
         {
            _loc1_ = String(_loc7_[itemsUsePoint.length - 1]).split(",");
            _loc6_ = parseFloat(_loc1_[_loc1_.length - 1]);
         }
         if(_loc5_[itemsUsePoint.length - 1])
         {
            _loc1_ = String(_loc5_[itemsUsePoint.length - 1]).split(",");
            _loc8_ = parseFloat(_loc1_[_loc1_.length - 1]);
         }
         _loc2_[0] = int(Math.ceil(_loc2_[0] * _loc6_));
         _loc2_[1] = int(Math.ceil(_loc2_[1] * _loc8_));
         return _loc2_;
      }
      
      public function getAllRewards() : Vector.<FindBackRewardInfo>
      {
         var _loc6_:FindBackRewardInfo = null;
         var _loc1_:Vector.<FindBackRewardInfo> = new Vector.<FindBackRewardInfo>();
         var _loc4_:Dictionary = new Dictionary(true);
         for each(var _loc3_:FindBackItemInfo in itemsUsePoint)
         {
            for each(var _loc2_:FindBackRewardInfo in _loc3_.rewards)
            {
               if(_loc2_.goodsTempId in _loc4_)
               {
                  var _loc7_:int = _loc2_.goodsTempId;
                  var _loc8_:Number = _loc4_[_loc7_] + _loc2_.count;
                  _loc4_[_loc7_] = _loc8_;
               }
               else
               {
                  _loc4_[_loc2_.goodsTempId] = _loc2_.count;
               }
            }
         }
         for(var _loc5_:String in _loc4_)
         {
            _loc6_ = new FindBackRewardInfo(int(_loc5_),_loc4_[_loc5_]);
            _loc1_.push(_loc6_);
         }
         _loc1_.sort(sortRewards);
         return _loc1_;
      }
      
      public function getAllPointRewards() : Vector.<FindBackRewardInfo>
      {
         var _loc6_:FindBackRewardInfo = null;
         var _loc1_:Vector.<FindBackRewardInfo> = new Vector.<FindBackRewardInfo>();
         var _loc4_:Dictionary = new Dictionary(true);
         for each(var _loc3_:FindBackItemInfo in itemsUsePoint)
         {
            for each(var _loc2_:FindBackRewardInfo in _loc3_.rewards)
            {
               if(_loc2_.goodsTempId in _loc4_)
               {
                  var _loc7_:int = _loc2_.goodsTempId;
                  var _loc8_:Number = _loc4_[_loc7_] + _loc2_.count;
                  _loc4_[_loc7_] = _loc8_;
               }
               else
               {
                  _loc4_[_loc2_.goodsTempId] = _loc2_.count;
               }
            }
         }
         for(var _loc5_:String in _loc4_)
         {
            _loc6_ = new FindBackRewardInfo(int(_loc5_),_loc4_[_loc5_]);
            _loc1_.push(_loc6_);
         }
         _loc1_.sort(sortRewards);
         return _loc1_;
      }
      
      public function getAllGoldRewards() : Vector.<FindBackRewardInfo>
      {
         var _loc6_:FindBackRewardInfo = null;
         var _loc1_:Vector.<FindBackRewardInfo> = new Vector.<FindBackRewardInfo>();
         var _loc4_:Dictionary = new Dictionary(true);
         for each(var _loc3_:FindBackItemInfo in itemsUseGold)
         {
            for each(var _loc2_:FindBackRewardInfo in _loc3_.rewards)
            {
               if(_loc2_.goodsTempId in _loc4_)
               {
                  var _loc7_:int = _loc2_.goodsTempId;
                  var _loc8_:Number = _loc4_[_loc7_] + _loc2_.count;
                  _loc4_[_loc7_] = _loc8_;
               }
               else
               {
                  _loc4_[_loc2_.goodsTempId] = _loc2_.count;
               }
            }
         }
         for(var _loc5_:String in _loc4_)
         {
            _loc6_ = new FindBackRewardInfo(int(_loc5_),_loc4_[_loc5_]);
            _loc1_.push(_loc6_);
         }
         _loc1_.sort(sortRewards);
         return _loc1_;
      }
   }
}

