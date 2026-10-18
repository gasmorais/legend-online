package mvc.module.theseus
{
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleDictionary;
   
   public class WarSoulModel
   {
      
      private var _itemDic:SimpleDictionary;
      
      private var _hatchDic:SimpleDictionary;
      
      private var _refineInfo:TheseusWarRfineInfo;
      
      private var _starParamList:Array = ["","","","",""];
      
      public var fightIdx:int;
      
      public var instensifyFunType:int;
      
      public var fenjieMax:int;
      
      private var _currInsSelectInfo:TheseusWarsoulItemInfo;
      
      private var _currWarInsSelectInfo:WarFrameItemInfo;
      
      public function WarSoulModel()
      {
         super();
         _itemDic = new SimpleDictionary();
         _hatchDic = new SimpleDictionary();
         _refineInfo = new TheseusWarRfineInfo();
      }
      
      public function get currInsSelectInfo() : TheseusWarsoulItemInfo
      {
         return _currInsSelectInfo;
      }
      
      public function set currInsSelectInfo(param1:TheseusWarsoulItemInfo) : void
      {
         _currInsSelectInfo = param1;
         if(param1 == null)
         {
            NotificationManager.instance.sendNotification("Evt.warsoulOut");
         }
         else
         {
            NotificationManager.instance.sendNotification("Evt.warsoulIn");
         }
      }
      
      public function get currWarInsSelectInfo() : WarFrameItemInfo
      {
         return _currWarInsSelectInfo;
      }
      
      public function set currWarInsSelectInfo(param1:WarFrameItemInfo) : void
      {
         _currWarInsSelectInfo = param1;
         if(param1 == null)
         {
            NotificationManager.instance.sendNotification("Evt.warFrameOut");
         }
         else
         {
            NotificationManager.instance.sendNotification("Evt.warFrameIn");
         }
      }
      
      public function get starParamList() : Array
      {
         return _starParamList;
      }
      
      public function get refineInfo() : TheseusWarRfineInfo
      {
         return _refineInfo;
      }
      
      public function getItemInfo(param1:int) : TheseusWarsoulItemInfo
      {
         return _itemDic[param1];
      }
      
      public function putItem(param1:int, param2:TheseusWarsoulItemInfo) : void
      {
         if(param2 == null)
         {
            return;
         }
         _itemDic.add(param1,param2);
      }
      
      public function delItem(param1:int) : void
      {
         _itemDic.del(param1);
      }
      
      public function getListByWarSoulIdAndStar(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         var _loc4_:Array = _itemDic.getList();
         for each(var _loc5_:TheseusWarsoulItemInfo in _loc4_)
         {
            if(_loc5_.isExist && !_loc5_.isEquip && _loc5_.warSoulId == param1 && _loc5_.star == param2 && _loc5_.objectId == 0)
            {
               _loc3_.push(_loc5_);
            }
         }
         return _loc3_;
      }
      
      public function getListByMainType(param1:int, param2:Boolean = false) : Array
      {
         var _loc3_:Array = [];
         var _loc4_:Array = _itemDic.getList();
         for each(var _loc5_:TheseusWarsoulItemInfo in _loc4_)
         {
            if(_loc5_.isExist && _loc5_.warTempInfo && _loc5_.warTempInfo.MainType == param1 && _loc5_.objectId == 0)
            {
               if(param2)
               {
                  _loc3_.push(_loc5_);
               }
               else if(!_loc5_.isEquip)
               {
                  _loc3_.push(_loc5_);
               }
            }
         }
         return _loc3_;
      }
      
      public function getEquipBodyList() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:Array = _itemDic.getList();
         for each(var _loc3_:TheseusWarsoulItemInfo in _loc2_)
         {
            if(_loc3_.isExist && _loc3_.isEquip)
            {
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function getBagNums(param1:int, param2:int) : Number
      {
         var _loc3_:int = 0;
         var _loc4_:Array = _itemDic.getList();
         for each(var _loc5_:TheseusWarsoulItemInfo in _loc4_)
         {
            if(_loc5_.isExist && !_loc5_.isEquip && _loc5_.warSoulId == param1 && _loc5_.star == param2 && _loc5_.strengthen == 0 && _loc5_.reform == 0 && _loc5_.learnSkill <= 0 && _loc5_.newLearnSkill <= 0)
            {
               _loc3_ += _loc5_.num;
               if(_loc5_.objectId != 0)
               {
                  _loc3_--;
               }
            }
         }
         return _loc3_;
      }
      
      public function getHatchInfo(param1:int) : TheseusWarsoulHatchInfo
      {
         return _hatchDic[param1];
      }
      
      public function putHatch(param1:int, param2:TheseusWarsoulHatchInfo) : void
      {
         if(param2 == null)
         {
            return;
         }
         _hatchDic.add(param1,param2);
      }
      
      public function delIHatch(param1:int) : void
      {
         _hatchDic.del(param1);
      }
   }
}

