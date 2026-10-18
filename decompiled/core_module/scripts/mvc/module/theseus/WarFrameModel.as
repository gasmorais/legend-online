package mvc.module.theseus
{
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleDictionary;
   
   public class WarFrameModel
   {
      
      private var _itemDic:SimpleDictionary;
      
      private var _hatchDic:SimpleDictionary;
      
      private var _starParamList:Array = ["","","","",""];
      
      public var fightIdx:int;
      
      public var instensifyFunType:int;
      
      public var fenjieMax:int;
      
      private var _currInsSelectInfo:WarFrameItemInfo;
      
      private var _currWarInsSelectInfo:GoodsInfo;
      
      public function WarFrameModel()
      {
         super();
         _itemDic = new SimpleDictionary();
         _hatchDic = new SimpleDictionary();
      }
      
      public function get currInsSelectInfo() : WarFrameItemInfo
      {
         return _currInsSelectInfo;
      }
      
      public function set currInsSelectInfo(param1:WarFrameItemInfo) : void
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
      
      public function get currWarInsSelectInfo() : GoodsInfo
      {
         return _currWarInsSelectInfo;
      }
      
      public function set currWarInsSelectInfo(param1:GoodsInfo) : void
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
      
      public function getItemInfo(param1:int) : WarFrameItemInfo
      {
         return _itemDic[param1];
      }
      
      public function putItem(param1:int, param2:WarFrameItemInfo) : void
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
         for each(var _loc5_:WarFrameItemInfo in _loc4_)
         {
            if(_loc5_.isExist && !_loc5_.isEquip && _loc5_.templateId == param1 && _loc5_.objectId == 0)
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
         for each(var _loc5_:WarFrameItemInfo in _loc4_)
         {
            if(_loc5_.isExist && _loc5_.warTempInfo && _loc5_.objectId == 0)
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
         for each(var _loc3_:WarFrameItemInfo in _loc2_)
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
         for each(var _loc5_:WarFrameItemInfo in _loc4_)
         {
            if(_loc5_.isExist && !_loc5_.isEquip && _loc5_.templateId == param1 && _loc5_.strengthen == 0 && _loc5_.reform == 0)
            {
               _loc3_ += _loc5_.count;
               if(_loc5_.objectId != 0)
               {
                  _loc3_--;
               }
            }
         }
         return _loc3_;
      }
   }
}

