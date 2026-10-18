package yishi.manager
{
   import bag.events.BagEvent;
   import bag.helper.GoodsCheck;
   import com.pickgliss.utils.SoundManager;
   import com.road.pb.helper.item.ItemHelper;
   import com.road.yishi.proto.item.ArrangeInfo;
   import com.road.yishi.proto.item.ArrangeReq;
   import com.road.yishi.proto.item.ItemMoveUpdateMsg;
   import com.road.yishi.proto.item.ItemMovedListMsg;
   import flash.events.EventDispatcher;
   import managers.TaskTraceTipManager;
   import managers.TheseussoulManager;
   import mvc.module.avenger.AvengerModel;
   import mvc.module.store.ComposeGoodsInfo;
   import mvc.module.store.StoreModel;
   import mvc.module.theseus.WarFrameItemInfo;
   import tasktracetip.data.TipMessageData;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleDictionary;
   
   public class GoodsManager extends EventDispatcher
   {
      
      private static var _instance:GoodsManager;
      
      private var _goodsListByPos:SimpleDictionary;
      
      private var _goodsCountByTempId:SimpleDictionary;
      
      public var filterFlag:Boolean = false;
      
      private var _sellPosList:Vector.<GoodsInfo>;
      
      private var _preGoodsCount:SimpleDictionary;
      
      private var _newGoodsCount:SimpleDictionary;
      
      public function GoodsManager()
      {
         super();
         initEvent();
      }
      
      public static function get instance() : GoodsManager
      {
         if(!_instance)
         {
            _instance = new GoodsManager();
         }
         return _instance;
      }
      
      public static function getGoodListByPramStr(param1:String) : Array
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:GoodsInfo = null;
         var _loc6_:int = 0;
         var _loc7_:Array = [];
         if(param1)
         {
            _loc2_ = param1.split("|");
            _loc4_ = int(_loc2_.length);
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc3_ = _loc2_[_loc6_].split(",");
               _loc5_ = new GoodsInfo();
               _loc5_.templateId = int(_loc3_[0]);
               _loc5_.count = int(_loc3_[1]);
               _loc7_.push(_loc5_);
               _loc6_++;
            }
         }
         return _loc7_;
      }
      
      public function setup() : void
      {
         _goodsListByPos = new SimpleDictionary();
         _goodsCountByTempId = new SimpleDictionary();
         _preGoodsCount = new SimpleDictionary(true);
         _newGoodsCount = new SimpleDictionary(true);
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 115,__bagUpdateHandler);
      }
      
      private function __bagUpdateHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:ItemMoveUpdateMsg = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc16_:GoodsInfo = null;
         var _loc3_:Boolean = false;
         var _loc13_:int = 0;
         var _loc6_:Boolean = false;
         var _loc9_:TipMessageData = null;
         _preGoodsCount.clear();
         for each(var _loc15_:GoodsInfo in _goodsListByPos)
         {
            if(_loc15_.bagType == 1)
            {
               _loc4_ = _loc15_.count;
               if(_preGoodsCount[_loc15_.templateId])
               {
                  _preGoodsCount.add(_loc15_.templateId,int(_preGoodsCount[_loc15_.templateId]) + _loc4_);
               }
               else
               {
                  _preGoodsCount.add(_loc15_.templateId,_loc4_);
               }
            }
         }
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:ItemMovedListMsg = new ItemMovedListMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as ItemMovedListMsg;
         var _loc14_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc2_.moved.length)
         {
            _loc7_ = _loc2_.moved[_loc5_] as ItemMoveUpdateMsg;
            _loc10_ = _loc7_.changeType;
            _loc11_ = _loc7_.changeObjId;
            _loc12_ = _loc7_.changePos;
            _loc3_ = _loc7_.hasItem;
            if(_loc3_)
            {
               _loc13_ = _loc7_.item.id;
               _loc6_ = false;
               _loc16_ = _goodsListByPos[_loc12_ + "_" + _loc11_ + "_" + _loc10_];
               if(!_loc16_)
               {
                  _loc16_ = new GoodsInfo();
                  _goodsListByPos.add(_loc12_ + "_" + _loc11_ + "_" + _loc10_,_loc16_);
                  _loc6_ = true;
               }
               _loc16_ = ItemHelper.readGoodsInfo(_loc7_.item,_loc16_);
               if(_loc16_.isNew && (_loc16_.bagType == 1 || _loc16_.bagType == 34))
               {
                  _loc14_.push(_loc16_);
               }
               if(_loc16_.bagType == 22)
               {
                  dispatchEvent(new BagEvent("UPDATE_BOTTLE_BAG",_loc16_));
               }
               if(_loc16_.bagType == 25)
               {
                  dispatchEvent(new BagEvent("UPDATE_GOLDROAD_BAG",_loc16_));
               }
               if(_loc16_.bagType == 33)
               {
                  dispatchEvent(new BagEvent("UPDATE_CHRISTMASTREE_BAG",_loc16_));
               }
               if(_loc6_)
               {
                  dispatchEvent(new BagEvent("ADD_GOODS",_loc16_));
               }
               if(_loc16_.templateId == 2032101)
               {
                  if(_loc16_.property1 == "1")
                  {
                     _loc9_ = new TipMessageData();
                     _loc9_.type = 38;
                     _loc9_.goods = _loc16_;
                     _loc9_.isFource = true;
                     TaskTraceTipManager.instance.showView(_loc9_);
                  }
               }
               dispatchEvent(new BagEvent("UPDATE_BAG",_loc16_));
               if(_loc10_ == 4)
               {
                  NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_FIGHT"));
               }
               if(_loc16_.bagType == 4)
               {
                  dispatchEvent(new BagEvent("UPDATE_EQUIP",_loc16_));
               }
            }
            else
            {
               _loc16_ = _goodsListByPos[_loc12_ + "_" + _loc11_ + "_" + _loc10_] as GoodsInfo;
               if(_loc16_)
               {
                  _goodsListByPos.del(_loc12_ + "_" + _loc11_ + "_" + _loc10_);
                  _loc16_.pos = _loc12_;
                  _loc16_.objectId = _loc11_;
                  _loc16_.bagType = _loc10_;
                  dispatchEvent(new BagEvent("DELETE_BAG",_loc16_));
                  if(_loc16_.bagType == 22)
                  {
                     dispatchEvent(new BagEvent("DELETE_BOTTLE_BAG",_loc16_));
                  }
                  if(_loc16_.bagType == 33)
                  {
                     dispatchEvent(new BagEvent("DELETE_CHRISTMASTREE_BAG",_loc16_));
                  }
                  if(_loc16_.bagType == 23)
                  {
                     dispatchEvent(new BagEvent("DELETE_FISH_BAG",_loc16_));
                  }
                  if(_loc16_.bagType == 25)
                  {
                     dispatchEvent(new BagEvent("DELETE_GOLDROAD_BAG",_loc16_));
                  }
                  if(_loc16_.templateInfo.SonType == 219)
                  {
                     dispatchEvent(new BagEvent("DELETE_TREASURE_MAP",_loc16_));
                  }
                  if(_loc16_.templateInfo.SonType == 320)
                  {
                     dispatchEvent(new BagEvent("DELETE_MARRY_TASK_MAP",_loc16_));
                  }
                  if(_loc16_.bagType == 4)
                  {
                     dispatchEvent(new BagEvent("DELETE_EQUIP",_loc16_));
                  }
               }
               if(_loc10_ == 4)
               {
                  NotificationManager.instance.dispatchEvent(new NotificationEvent("REFRESH_FIGHT"));
               }
            }
            _loc5_++;
         }
         if(_loc14_.length > 0)
         {
            SoundManager.instance.play("030",true);
            dispatchEvent(new BagEvent("NEW_GOODS",null,_loc14_));
         }
         countGoods();
         dispatchEvent(new BagEvent("BAG_FULL",null));
         InfoTipsManager.instance.dealData();
      }
      
      private function countGoods() : void
      {
         var _loc3_:* = null;
         var _loc1_:int = 0;
         _newGoodsCount.clear();
         for each(_loc3_ in _goodsListByPos)
         {
            if(_loc3_.bagType == 1)
            {
               _loc1_ = _loc3_.count;
               if(_newGoodsCount[_loc3_.templateId])
               {
                  _newGoodsCount.add(_loc3_.templateId,int(_newGoodsCount[_loc3_.templateId]) + _loc1_);
               }
               else
               {
                  _newGoodsCount.add(_loc3_.templateId,_loc1_);
               }
            }
         }
         for(var _loc2_:String in _newGoodsCount)
         {
            if(!_preGoodsCount[_loc2_])
            {
               _goodsCountByTempId.add(_loc2_,_newGoodsCount[_loc2_]);
            }
            else
            {
               if(int(_preGoodsCount[_loc2_]) != int(_newGoodsCount[_loc2_]))
               {
                  _goodsCountByTempId.add(_loc2_,_newGoodsCount[_loc2_]);
               }
               _preGoodsCount.del(_loc2_);
            }
         }
         for(_loc2_ in _preGoodsCount)
         {
            _goodsCountByTempId.del(_loc2_);
         }
      }
      
      public function fixBagItem(param1:Array, param2:Array, param3:int, param4:Boolean) : void
      {
         var _loc6_:int = 0;
         var _loc8_:ArrangeInfo = null;
         var _loc7_:PackageOut = new PackageOut(8220);
         var _loc5_:ArrangeReq = new ArrangeReq();
         _loc5_.isStackItem = param4;
         _loc5_.bagType = param3;
         _loc6_ = 0;
         while(_loc6_ < param1.length)
         {
            _loc8_ = new ArrangeInfo();
            _loc8_.newplace = param2[_loc6_];
            _loc8_.oldplace = param1[_loc6_];
            _loc5_.arrangeInfo.push(_loc8_);
            _loc6_++;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc7_,_loc5_);
      }
      
      public function getBottleBagList() : SimpleDictionary
      {
         var _loc1_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(isBottleBagGoods(_loc2_))
            {
               _loc1_.add(_loc2_.id,_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function isBottleBagGoods(param1:GoodsInfo) : Boolean
      {
         if(param1.objectId == 0 && param1.bagType == 22)
         {
            return true;
         }
         return false;
      }
      
      public function getChristmasTreeBagList() : SimpleDictionary
      {
         var _loc1_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(isChristmasTreeBagGoods(_loc2_))
            {
               _loc1_.add(_loc2_.id,_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function isChristmasTreeBagGoods(param1:GoodsInfo) : Boolean
      {
         if(param1.objectId == 0 && param1.bagType == 33)
         {
            return true;
         }
         return false;
      }
      
      public function getFishBagList() : SimpleDictionary
      {
         var _loc1_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(isFishBagGoods(_loc2_))
            {
               _loc1_.add(_loc2_.id,_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function isFishBagGoods(param1:GoodsInfo) : Boolean
      {
         if(param1.objectId == 0 && param1.bagType == 23)
         {
            return true;
         }
         return false;
      }
      
      public function getGeneralBagList() : SimpleDictionary
      {
         var _loc2_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc1_:GoodsInfo in _goodsListByPos)
         {
            if(isGneralBagGoods(_loc1_))
            {
               _loc2_.add(_loc1_.id,_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function getRuneBagList(param1:int = 0, param2:int = 0) : SimpleDictionary
      {
         var _loc4_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.objectId == 0 && _loc3_.bagType == 40)
            {
               if(param1 == 0)
               {
                  if(param2 == 0)
                  {
                     _loc4_.add(_loc3_.id,_loc3_);
                  }
                  else if(_loc3_.templateInfo.Profile == param2)
                  {
                     _loc4_.add(_loc3_.id,_loc3_);
                  }
               }
               else if(_loc3_.templateInfo.Property1 == param1)
               {
                  if(param2 == 0)
                  {
                     _loc4_.add(_loc3_.id,_loc3_);
                  }
                  else if(_loc3_.templateInfo.Profile == param2)
                  {
                     _loc4_.add(_loc3_.id,_loc3_);
                  }
               }
            }
         }
         return _loc4_;
      }
      
      public function getRuneEquipBagList(param1:int) : SimpleDictionary
      {
         var _loc2_:int = (param1 - 1) * 10;
         var _loc4_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.bagType == 41 && (_loc2_ <= _loc3_.pos && _loc3_.pos < _loc2_ + 10))
            {
               _loc4_.add(_loc3_.pos,_loc3_);
            }
         }
         return _loc4_;
      }
      
      public function getStroeBagList() : SimpleDictionary
      {
         var _loc2_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc1_:GoodsInfo in _goodsListByPos)
         {
            if(_loc1_.bagType == 34)
            {
               _loc2_.add(_loc1_.id,_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function setTheseusBagList(param1:SimpleDictionary) : void
      {
         var _loc3_:GoodsInfo = null;
         for each(var _loc2_:WarFrameItemInfo in param1)
         {
            if(_loc2_.type == 1 && !_loc2_.isEquip && _loc2_.strengthen == 0 && _loc2_.reform == _loc2_.warTempInfo.Profile)
            {
               _loc3_ = new GoodsInfo();
               _loc3_.templateId = _loc2_.templateId;
               _loc3_.count = _loc2_.count;
            }
         }
      }
      
      public function getCountBySontypeAndBagType(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         for each(var _loc4_:GoodsInfo in _goodsListByPos)
         {
            if(_loc4_.bagType == param2 && _loc4_.templateInfo.SonType == param1)
            {
               _loc3_ += _loc4_.count;
            }
         }
         return _loc3_;
      }
      
      public function getListBySontypeListAndBagType(param1:Array, param2:int) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc4_:GoodsInfo in _goodsListByPos)
         {
            if(_loc4_.bagType == param2 && param1.indexOf(_loc4_.templateInfo.SonType) != -1)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function getBagCountInPlayerAndStoneBySonType(param1:Array) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(isStoreOrPlayerBag(_loc3_) && param1.indexOf(_loc3_.templateInfo.SonType) != -1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getBagCountByTempId(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         for each(var _loc4_:GoodsInfo in _goodsListByPos)
         {
            if(_loc4_.bagType == param1 && _loc4_.templateId == param2)
            {
               _loc3_ += _loc4_.count;
            }
         }
         return _loc3_;
      }
      
      public function getBagCountInPlayerAndStoneByTempId(param1:int) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(isStoreOrPlayerBag(_loc3_) && _loc3_.templateId == param1)
            {
               _loc2_ += _loc3_.count;
            }
         }
         return _loc2_;
      }
      
      public function getBindCountByTempId(param1:int, param2:int, param3:Boolean) : int
      {
         var _loc4_:int = 0;
         for each(var _loc5_:GoodsInfo in _goodsListByPos)
         {
            if(_loc5_.bagType == param1 && _loc5_.templateId == param2 && _loc5_.isBinds == param3)
            {
               _loc4_ += _loc5_.count;
            }
         }
         return _loc4_;
      }
      
      public function findPosById(param1:int, param2:int = 1) : int
      {
         var _loc3_:int = -1;
         for each(var _loc4_:GoodsInfo in _goodsListByPos)
         {
            if(_loc4_.bagType == param2 && _loc4_.templateId == param1)
            {
               _loc3_ = _loc4_.pos;
            }
         }
         return _loc3_;
      }
      
      public function getHeroEquipBagAndPlayerBagList() : SimpleDictionary
      {
         var _loc2_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc1_:GoodsInfo in _goodsListByPos)
         {
            if(isGneralBagGoods(_loc1_) || isGneralStoreBagGoods(_loc1_) || _loc1_.bagType == 4 || _loc1_.bagType == 0)
            {
               _loc2_.add(_loc1_.id,_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function isGneralBagGoods(param1:GoodsInfo) : Boolean
      {
         if(param1.objectId == 0 && param1.bagType == 1)
         {
            return true;
         }
         return false;
      }
      
      public function isGneralStoreBagGoods(param1:GoodsInfo) : Boolean
      {
         if(param1.objectId == 0 && param1.bagType == 1)
         {
            return true;
         }
         if(param1.bagType == 34)
         {
            return true;
         }
         return false;
      }
      
      public function get consoritaBagList() : SimpleDictionary
      {
         var _loc1_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(_loc2_.bagType == 6)
            {
               _loc1_.add(_loc2_.id,_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getConsoritaBagGoodsNumByTempId(param1:int) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_:GoodsInfo in consoritaBagList)
         {
            if(_loc3_.bagType == 6 && _loc3_.templateId == param1)
            {
               _loc2_ += _loc3_.count;
            }
         }
         return _loc2_;
      }
      
      public function get equipBagList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(_loc2_.objectId == 0 && _loc2_.templateInfo.MasterType == 1 && _loc2_.bagType == 1)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function get skillBagList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(_loc2_.objectId == 0 && _loc2_.templateInfo.MasterType == 3 && _loc2_.bagType == 1)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function findEmputyPos() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < playerInfo.bagTotalCount)
         {
            if(!_goodsListByPos[_loc1_ + "_" + 0 + "_" + 1])
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function findStroeEmputyPos() : int
      {
         var _loc1_:int = 0;
         var _loc3_:SimpleDictionary = getStroeBagList();
         var _loc2_:Array = new Array(280);
         for each(var _loc4_:GoodsInfo in _loc3_)
         {
            if(_loc4_)
            {
               _loc2_[_loc4_.pos] = _loc4_;
            }
         }
         _loc1_ = 0;
         while(_loc1_ < 280)
         {
            if(!_loc2_[_loc1_])
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function findChildEmputyPos() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 80)
         {
            if(!_goodsListByPos[_loc1_ + "_" + 0 + "_" + 28])
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function getEmputyPosCount() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < playerInfo.bagTotalCount)
         {
            if(!_goodsListByPos[_loc2_ + "_" + 0 + "_" + 1])
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function findEmputyPosByPageAndBagType(param1:int = 1, param2:int = 1) : int
      {
         var _loc4_:int = 0;
         var _loc3_:int = (param1 - 1) * 56;
         var _loc5_:int = param1 * 56;
         if(param1 == 5 && param2 == 1)
         {
            _loc3_ = (param1 - 2) * 56 + playerInfo.bagCount - 126;
            _loc5_ = _loc3_ + 49;
         }
         else if(param1 == 6 && param2 == 1)
         {
            _loc3_ = (param1 - 3) * 56 + 49 + playerInfo.bagTotalCount - 266;
            _loc5_ = _loc3_ + 49;
         }
         _loc4_ = _loc3_;
         while(_loc4_ < _loc5_)
         {
            if(param2 == 1 && _loc4_ >= playerInfo.bagTotalCount)
            {
               return -1;
            }
            if(param2 == 34 && _loc4_ >= 280)
            {
               return -1;
            }
            if(!_goodsListByPos[_loc4_ + "_" + 0 + "_" + param2])
            {
               return _loc4_;
            }
            _loc4_++;
         }
         return -1;
      }
      
      public function findNullCount() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 322)
         {
            if(_loc2_ >= playerInfo.bagTotalCount)
            {
               return _loc1_;
            }
            if(!_goodsListByPos[_loc2_ + "_" + 0 + "_" + 1])
            {
               _loc1_++;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function findSuperpositionPos(param1:GoodsInfo) : int
      {
         var _loc2_:GoodsInfo = null;
         for(var _loc3_:String in _goodsListByPos)
         {
            _loc2_ = _goodsListByPos[_loc3_];
            if(_loc2_ && _loc2_.bagType == 1 && _loc2_.templateId == param1.templateId && _loc2_.templateInfo.MaxCount > 1 && _loc2_.isBinds == param1.isBinds)
            {
               return int(_loc3_.charAt(0));
            }
         }
         return -1;
      }
      
      public function getGoodsByTemplateId(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.templateId == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getBagGoodsByTemplateId(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.templateId == param1 && (_loc3_.bagType == 1 || _loc3_.bagType == 0))
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getBagGoodsStrengthenMaxByTemplateId(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.templateId == param1 && (_loc3_.bagType == 4 || _loc3_.bagType == 1))
            {
               if(_loc3_.strengthenGrade == _loc3_.templateInfo.StrengthenMax)
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         return _loc2_;
      }
      
      public function getMailGoodsByTemplateId(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.templateId == param1 && _loc3_.bagType == 10)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getBottleGoodsByTemplateId(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.templateId == param1 && _loc3_.bagType == 22)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getGoodsCountByBagType(param1:int) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.bagType == param1)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function getGoodsByBagType(param1:int) : Array
      {
         var _loc4_:GoodsInfo = null;
         var _loc5_:int = 0;
         var _loc2_:Array = [];
         var _loc6_:Array = _goodsListByPos.getList();
         var _loc3_:int = int(_loc6_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc6_[_loc5_];
            if(_loc4_.bagType == param1)
            {
               _loc2_.push(_loc4_);
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function isExitByTemplateId(param1:int) : Boolean
      {
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(_loc2_.templateId == param1 && _loc2_.bagType == 1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getHeroEquipListById(param1:int) : SimpleDictionary
      {
         var _loc3_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(isHeroGoods(param1,_loc2_))
            {
               _loc3_.add(_loc2_.pos + "_" + _loc2_.bagType,_loc2_);
            }
         }
         return _loc3_;
      }
      
      private function isPetGoods(param1:int, param2:GoodsInfo) : Boolean
      {
         if(param1 == 0)
         {
            return false;
         }
         if(param2.bagType == 26 && param2.objectId == param1 && param2.templateInfo.MasterType == 5)
         {
            return true;
         }
         return false;
      }
      
      private function isChildGoods(param1:int, param2:GoodsInfo) : Boolean
      {
         if(param1 == 0)
         {
            return false;
         }
         if(param2.bagType == 30 && param2.objectId == param1 && param2.templateInfo.MasterType == 6)
         {
            return true;
         }
         return false;
      }
      
      public function getHeroHonorListById(param1:int) : SimpleDictionary
      {
         var _loc3_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(_loc2_.bagType == 3 && _loc2_.objectId == param1)
            {
               _loc3_.add(_loc2_.pos,_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function isHeroGoods(param1:int, param2:GoodsInfo) : Boolean
      {
         if(param1 == 0)
         {
            return false;
         }
         if(param2.bagType == 4 && param2.objectId == param1 && param2.templateInfo.MasterType == 1)
         {
            return true;
         }
         return false;
      }
      
      public function getHeroSkillListById(param1:int) : SimpleDictionary
      {
         var _loc3_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(_loc2_.objectId == param1 && _loc2_.templateInfo.MasterType == 3)
            {
               _loc3_.add(_loc2_.id,_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getHeroGoodsListByTypeAndId(param1:int, param2:int) : SimpleDictionary
      {
         var _loc4_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.objectId == param2 && _loc3_.templateInfo.MasterType == param1)
            {
               _loc4_.add(_loc3_.pos + "_" + _loc3_.bagType,_loc3_);
            }
         }
         return _loc4_;
      }
      
      public function getPetGoodsListById(param1:int) : SimpleDictionary
      {
         var _loc3_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(_loc2_.objectId == param1)
            {
               _loc3_.add(_loc2_.pos,_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getBattleRunes() : SimpleDictionary
      {
         var _loc2_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc1_:GoodsInfo in _goodsListByPos)
         {
            if(_loc1_.bagType == 2)
            {
               _loc2_.add(_loc1_.pos,_loc1_);
            }
         }
         return _loc2_;
      }
      
      public function getBattleRunesByTempId(param1:int) : GoodsInfo
      {
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(_loc2_.bagType == 2 && _loc2_.templateId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getEmputyBattleRunesPos() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:GoodsInfo = null;
         if(thane.grades >= 40)
         {
            _loc1_ = 3;
         }
         else if(thane.grades >= 30)
         {
            _loc1_ = 2;
         }
         else if(thane.grades >= 20)
         {
            _loc1_ = 1;
         }
         else
         {
            _loc1_ = 0;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = _goodsListByPos[_loc2_ + "_0_2"];
            if(!_loc3_)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         if(_loc1_ != 0)
         {
            return 0;
         }
         return -1;
      }
      
      public function getHeroHonerEquip(param1:int) : SimpleDictionary
      {
         var _loc2_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.bagType == 3 && _loc3_.objectId == param1)
            {
               _loc2_.add(_loc3_.pos,_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getEmputyHonerPos() : int
      {
         var _loc1_:int = 0;
         var _loc2_:GoodsInfo = null;
         _loc1_ = 0;
         while(_loc1_ < 1)
         {
            _loc2_ = _goodsListByPos[_loc1_ + "_" + thane.id + "_" + 3];
            if(!_loc2_)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function getHeroGoodsListBySonTypeAndId(param1:int, param2:int) : SimpleDictionary
      {
         var _loc4_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.objectId == param2 && _loc3_.templateInfo.SonType == param1)
            {
               _loc4_.add(_loc3_.pos + "_" + _loc3_.bagType,_loc3_);
            }
         }
         return _loc4_;
      }
      
      public function getGoodsByGoodsTId(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.templateId == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getGoodsByGoodsIdFromGeneralBag(param1:int) : GoodsInfo
      {
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(isGneralBagGoods(_loc2_) && _loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getHeroEquipByPos(param1:int, param2:int) : GoodsInfo
      {
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.objectId == param1 && _loc3_.pos == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getGoodsByObjectIdAndGoodID(param1:int, param2:int) : GoodsInfo
      {
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.objectId == param1 && _loc3_.templateId == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getHideBagItemByPos(param1:int) : GoodsInfo
      {
         return _goodsListByPos[param1 + "_0_" + 0] as GoodsInfo;
      }
      
      public function getItemByPOB(param1:int, param2:int, param3:int) : GoodsInfo
      {
         return _goodsListByPos[param1 + "_" + param2 + "_" + param3] as GoodsInfo;
      }
      
      public function get goodsListByPos() : SimpleDictionary
      {
         return _goodsListByPos;
      }
      
      public function get goodsCountByTempId() : SimpleDictionary
      {
         return _goodsCountByTempId;
      }
      
      public function getGoodsNumByTempId(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:SimpleDictionary = TheseussoulManager.Instance.model.armorBagDic;
         for each(var _loc5_:WarFrameItemInfo in _loc3_)
         {
            if(_loc5_.templateId == param1 && _loc5_.type == 1 && !_loc5_.isEquip && _loc5_.strengthen == 0 && _loc5_.reform == _loc5_.warTempInfo.Profile)
            {
               _loc2_ += _loc5_.count;
            }
            if(_loc5_.templateId == param1 && _loc5_.type == 2)
            {
               _loc2_ += _loc5_.count;
            }
         }
         for each(var _loc4_:GoodsInfo in _goodsListByPos)
         {
            if(_loc4_.objectId == 0 && _loc4_.bagType == 1 && _loc4_.templateId == param1)
            {
               _loc2_ += _loc4_.count;
            }
         }
         return _loc2_;
      }
      
      public function isBagGoodsEnough(param1:int, param2:int, param3:int = 1) : Boolean
      {
         var _loc4_:int = 0;
         for each(var _loc5_:GoodsInfo in _goodsListByPos)
         {
            if(_loc5_.objectId == 0 && _loc5_.bagType == param3 && _loc5_.templateId == param1)
            {
               _loc4_ += _loc5_.count;
            }
         }
         return _loc4_ >= param2;
      }
      
      public function getGoodsNumByTempIdAndNotLock(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:SimpleDictionary = TheseussoulManager.Instance.model.armorBagDic;
         for each(var _loc5_:WarFrameItemInfo in _loc3_)
         {
            if(_loc5_.templateId == param1 && _loc5_.type == 1 && !_loc5_.isEquip && !_loc5_.isLock && _loc5_.strengthen == 0 && _loc5_.reform == _loc5_.warTempInfo.Profile)
            {
               _loc2_ += _loc5_.count;
            }
            if(_loc5_.templateId == param1 && _loc5_.type == 2)
            {
               _loc2_ += _loc5_.count;
            }
         }
         for each(var _loc4_:GoodsInfo in _goodsListByPos)
         {
            if(_loc4_.objectId == 0 && isStoreOrPlayerBag(_loc4_) && _loc4_.templateId == param1 && _loc4_.isLock == false)
            {
               _loc2_ += _loc4_.count;
            }
         }
         return _loc2_;
      }
      
      public function getGoodsArrBySonTypeAndPropertyAndNotLock(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         for each(var _loc4_:GoodsInfo in _goodsListByPos)
         {
            if(_loc4_.objectId == 0 && _loc4_.bagType == 1 && _loc4_.templateInfo.SonType == param1 && _loc4_.templateInfo.Property1 == param2 && _loc4_.isLock == false)
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_;
      }
      
      public function getGoodsBySontypeFromBagType(param1:int, param2:int) : Array
      {
         var _loc6_:GoodsInfo = null;
         var _loc3_:Array = [];
         var _loc4_:SimpleDictionary = TheseussoulManager.Instance.model.armorBagDic;
         for each(var _loc7_:WarFrameItemInfo in _loc4_)
         {
            if(_loc7_.warTempInfo.SonType == param1 && _loc7_.warTempInfo.MasterType == 10)
            {
               _loc6_ = new GoodsInfo();
               _loc6_.templateId = _loc7_.templateId;
               _loc6_.count = _loc7_.count;
               _loc6_.pos = _loc6_.id;
               _loc6_.bagType = 10;
               _loc3_.push(_loc6_);
            }
         }
         for each(var _loc5_:GoodsInfo in _goodsListByPos)
         {
            if(_loc5_.objectId == 0 && _loc5_.bagType == param2 && _loc5_.templateInfo.SonType == param1)
            {
               _loc3_.push(_loc5_);
            }
         }
         return _loc3_;
      }
      
      public function getGoodsNumByIdAndNotLockInEquipBag(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc3_:SimpleDictionary = TheseussoulManager.Instance.model.armorBagDic;
         for each(var _loc5_:WarFrameItemInfo in _loc3_)
         {
            if(_loc5_.templateId == param1 && _loc5_.type == 1 && !_loc5_.isEquip && !_loc5_.isLock && _loc5_.strengthen == 0 && _loc5_.reform == _loc5_.warTempInfo.Profile)
            {
               _loc2_ += _loc5_.count;
            }
         }
         for each(var _loc4_:GoodsInfo in _goodsListByPos)
         {
            if((isHeroGoods(thane.id,_loc4_) || isGneralBagGoods(_loc4_) || isGneralStoreBagGoods(_loc4_)) && _loc4_.templateId == param1 && _loc4_.isLock == false)
            {
               _loc2_ += _loc4_.count;
            }
         }
         return _loc2_;
      }
      
      public function getGoodsNumByTempIdInHeroEquipBayAndPlayerBag(param1:int) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if((isHeroGoods(thane.id,_loc3_) || isGneralBagGoods(_loc3_)) && _loc3_.templateId == param1)
            {
               _loc2_ += _loc3_.count;
            }
         }
         return _loc2_;
      }
      
      public function getGoodsNumBySonType(param1:int) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.objectId == 0 && _loc3_.bagType == 1 && _loc3_.templateInfo.SonType == param1)
            {
               _loc2_ += _loc3_.count;
            }
         }
         return _loc2_;
      }
      
      public function getGoodsBySonType(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.templateInfo.SonType == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getGeneralBagEquipList() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:SimpleDictionary = getGeneralBagList();
         for each(var _loc3_:GoodsInfo in _loc2_)
         {
            if(_loc3_.templateInfo.MasterType == 1)
            {
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function getGeneralBagPropList() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:SimpleDictionary = getGeneralBagList();
         for each(var _loc3_:GoodsInfo in _loc2_)
         {
            if(_loc3_.templateInfo.MasterType == 2)
            {
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function getStoreBagPropList() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:SimpleDictionary = getStroeBagList();
         for each(var _loc3_:GoodsInfo in _loc2_)
         {
            if(_loc3_.templateInfo.MasterType == 2)
            {
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function getDemonRoadShopResloves() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(_loc2_.templateInfo.SonType == 693)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getMonsterBagGoodsInfo(param1:int) : GoodsInfo
      {
         var _loc3_:GoodsInfo = null;
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(_loc2_.bagType == 37 && _loc2_.objectId == param1)
            {
               _loc3_ = _loc2_;
               break;
            }
         }
         return _loc3_;
      }
      
      public function getMonsterBagList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(_loc2_.bagType == 36 && _loc2_.templateInfo.SonType == 232)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getMonsterAccessoriesBagList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(_loc2_.templateInfo.SonType == 232)
            {
               if(_loc2_.bagType == 36 || _loc2_.bagType == 37)
               {
                  _loc1_.push(_loc2_);
               }
            }
         }
         return _loc1_;
      }
      
      public function getMonsterPropBagList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(_loc2_.bagType == 36 && _loc2_.templateInfo.SonType != 232)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getGeneralBagPetEquipList() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:SimpleDictionary = getGeneralBagList();
         for each(var _loc3_:GoodsInfo in _loc2_)
         {
            if(_loc3_.templateInfo.MasterType == 5)
            {
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function getGeneralBagChildEquipList(param1:int = 1, param2:int = 5) : Array
      {
         var _loc5_:int = 0;
         var _loc6_:GoodsInfo = null;
         var _loc3_:Array = [];
         var _loc4_:Array = getGoodsByBagType(28);
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc6_ = _loc4_[_loc5_] as GoodsInfo;
            if(_loc6_.templateInfo.MasterType == 6 && _loc6_.templateInfo.Profile >= param1 && _loc6_.templateInfo.Profile <= param2)
            {
               _loc3_.push(_loc6_);
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function getGeneralBagPetEquipListByQuality(param1:int, param2:int) : Array
      {
         var _loc3_:Array = [];
         var _loc4_:SimpleDictionary = getGeneralBagList();
         for each(var _loc5_:GoodsInfo in _loc4_)
         {
            if(_loc5_.templateInfo.MasterType == 5 && _loc5_.templateInfo.Profile >= param1 && _loc5_.templateInfo.Profile <= param2)
            {
               _loc3_.push(_loc5_);
            }
         }
         return _loc3_;
      }
      
      public function getPetEquipListById(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(isPetGoods(param1,_loc3_))
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function getChildEquipListById(param1:int, param2:int = 1, param3:int = 5) : Array
      {
         var _loc6_:int = 0;
         var _loc7_:GoodsInfo = null;
         var _loc4_:Array = [];
         var _loc5_:Array = getGoodsByBagType(30);
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc7_ = _loc5_[_loc6_] as GoodsInfo;
            if(isChildGoods(param1,_loc7_) && _loc7_.templateInfo.Profile >= param2 && _loc7_.templateInfo.Profile <= param3)
            {
               _loc4_.push(_loc7_);
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public function getPetEquipListByIdAndQuality(param1:int, param2:int, param3:int) : SimpleDictionary
      {
         var _loc5_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc4_:GoodsInfo in _goodsListByPos)
         {
            if(isPetGoods(param1,_loc4_))
            {
               if(_loc4_.templateInfo.Profile >= param2 && _loc4_.templateInfo.Profile <= param3)
               {
                  _loc5_.add(_loc4_.pos,_loc4_);
               }
            }
         }
         return _loc5_;
      }
      
      public function getGeneralBagGoodsBySonType(param1:int, param2:int = -1) : Array
      {
         var _loc4_:SimpleDictionary = getGeneralBagList();
         var _loc3_:Array = [];
         for each(var _loc5_:GoodsInfo in _loc4_)
         {
            if(param2 == -1)
            {
               if(_loc5_.templateInfo.SonType == param1)
               {
                  _loc3_.push(_loc5_);
               }
            }
            else if(_loc5_.templateInfo.SonType == param1 && _loc5_.templateInfo.Property1 == param2)
            {
               _loc3_.push(_loc5_);
            }
         }
         return _loc3_;
      }
      
      public function getStoneBagGoodsBySonType(param1:int, param2:int = -1) : Array
      {
         var _loc4_:SimpleDictionary = getStroeBagList();
         var _loc3_:Array = [];
         for each(var _loc5_:GoodsInfo in _loc4_)
         {
            if(param2 == -1)
            {
               if(_loc5_.templateInfo.SonType == param1)
               {
                  _loc3_.push(_loc5_);
               }
            }
            else if(_loc5_.templateInfo.SonType == param1 && _loc5_.templateInfo.Property1 == param2)
            {
               _loc3_.push(_loc5_);
            }
         }
         return _loc3_;
      }
      
      public function checkExistGoodsByTempIdInAllBag(param1:int) : Boolean
      {
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(_loc2_.templateId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function checkHeroHasEmpty() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         var _loc3_:SimpleDictionary = getHeroEquipListById(thane.id);
         _loc2_ = 0;
         for(; _loc2_ < 8; _loc2_++)
         {
            if(_loc3_[_loc2_])
            {
               continue;
            }
            switch(_loc2_)
            {
               case 0:
                  _loc1_.push(101);
                  break;
               case 1:
                  _loc1_.push(103);
                  break;
               case 2:
                  _loc1_.push(104);
                  break;
               case 3:
                  _loc1_.push(106);
                  break;
               case 4:
               case 5:
                  _loc1_.push(107);
                  break;
               case 6:
               case 7:
                  _loc1_.push(108);
            }
         }
         return _loc1_;
      }
      
      public function checkCanEquip(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.bagType == 1 && _loc3_.templateInfo.SonType != 214 && GoodsCheck.checkGoodsCanEquip(_loc3_,thane) && GoodsCheck.isGradeFix(thane,_loc3_.templateInfo,false) && param1 == _loc3_.templateInfo.SonType)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public function checkCanIntensify() : Boolean
      {
         var _loc1_:SimpleDictionary = getHeroEquipListById(thane.id);
         for each(var _loc2_:GoodsInfo in _loc1_)
         {
            if(!isFashion(_loc2_) && _loc2_.strengthenGrade == 0 && ResourceManager.instance.gold.count >= 10000)
            {
               return true;
            }
         }
         return false;
      }
      
      public function checkCanMountByGrade() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:Array = GoodsManager.instance.getGeneralBagPropList();
         var _loc3_:SimpleDictionary = getHeroEquipListById(thane.id);
         _loc1_ = 0;
         loop0:
         while(_loc1_ < _loc2_.length)
         {
            var _loc6_:int = 0;
            var _loc5_:SimpleDictionary = _loc3_;
            do
            {
               for each(var _loc4_:GoodsInfo in _loc5_)
               {
               }
               _loc1_++;
               continue loop0;
            }
            while(!(_loc2_[_loc1_].templateInfo.SonType == 205 && _loc4_.existLessGradeJewel(_loc2_[_loc1_].templateId.toString())));
            return true;
         }
         return false;
      }
      
      public function checkCanMountByGrade2() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:Array = GoodsManager.instance.getGeneralBagPropList();
         var _loc3_:SimpleDictionary = getHeroEquipListById(thane.id);
         _loc1_ = 0;
         loop0:
         while(_loc1_ < _loc2_.length)
         {
            var _loc6_:int = 0;
            var _loc5_:SimpleDictionary = _loc3_;
            do
            {
               for each(var _loc4_:GoodsInfo in _loc5_)
               {
               }
               _loc1_++;
               continue loop0;
            }
            while(!(_loc2_[_loc1_].templateInfo.SonType == 205 && _loc4_.existLessGradeJewel2(_loc2_[_loc1_].templateId.toString())));
            return true;
         }
         return false;
      }
      
      public function checkCanRefreshByGrade() : Boolean
      {
         var _loc1_:int = 0;
         var _loc2_:Array = GoodsManager.instance.getGeneralBagPropList();
         var _loc3_:SimpleDictionary = getHeroEquipListById(thane.id);
         _loc1_ = 0;
         loop0:
         while(_loc1_ < _loc2_.length)
         {
            var _loc6_:int = 0;
            var _loc5_:SimpleDictionary = _loc3_;
            do
            {
               for each(var _loc4_:GoodsInfo in _loc5_)
               {
               }
               _loc1_++;
               continue loop0;
            }
            while(!(!isFashion(_loc4_) && existLessRefreshGrade(_loc4_)));
            return true;
         }
         return false;
      }
      
      private function existLessRefreshGrade(param1:GoodsInfo) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.templateId).Profile;
         var _loc4_:int = GoodsManager.instance.getGoodsNumByTempId(param1.templateInfo.Refresh);
         switch(_loc3_ - 1)
         {
            case 0:
            case 1:
               _loc2_ = 1;
               break;
            case 2:
               _loc2_ = 4;
               break;
            case 3:
            case 4:
               _loc2_ = 18;
               break;
            case 5:
               _loc2_ = 24;
         }
         if(_loc3_ < 4)
         {
            return false;
         }
         if(_loc2_ <= _loc4_)
         {
            return true;
         }
         return false;
      }
      
      public function filterGoodsInGeneralAndConsortiaBag() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.bagType == 1 && !_loc3_.checkIsFilterGoods())
            {
               _loc2_ = int(_loc3_.pos / 56) + 1;
               if(_loc1_.indexOf(_loc2_) < 0)
               {
                  _loc1_.push(_loc2_);
               }
            }
         }
         NotificationManager.instance.sendNotification("FILTER_GOODS");
         return _loc1_;
      }
      
      public function isType(param1:GoodsInfo, param2:int) : Boolean
      {
         var _loc3_:Boolean = false;
         switch(param2)
         {
            case 0:
            case 3:
               if(param1.templateInfo.MasterType == 1)
               {
                  if(!isFashion(param1))
                  {
                     _loc3_ = true;
                  }
               }
               break;
            case 1:
               if(param1.templateInfo.MasterType == 1)
               {
                  if(isFashion(param1))
                  {
                     _loc3_ = true;
                  }
               }
               break;
            case 2:
               if(param1.templateInfo.MasterType == 2 || param1.templateInfo.MasterType == 3)
               {
                  if(!isJewel(param1))
                  {
                     _loc3_ = true;
                  }
               }
               break;
            case 4:
               if(param1.templateInfo.MasterType == 2 || param1.templateInfo.MasterType == 3)
               {
                  if(isJewel(param1))
                  {
                     _loc3_ = true;
                  }
               }
         }
         return _loc3_;
      }
      
      public function setSellPos(param1:GoodsInfo, param2:Boolean, param3:Boolean = false) : void
      {
         if(_sellPosList == null)
         {
            _sellPosList = new Vector.<GoodsInfo>();
         }
         if(param3)
         {
            while(_sellPosList.length > 0)
            {
               _sellPosList.pop();
            }
            return;
         }
         if(param2)
         {
            _sellPosList.push(param1);
         }
         else if(_sellPosList.indexOf(param1) >= 0)
         {
            _sellPosList.splice(_sellPosList.indexOf(param1),1);
         }
      }
      
      public function hasSellPos() : Boolean
      {
         if(_sellPosList == null || _sellPosList.length <= 0)
         {
            return false;
         }
         return true;
      }
      
      public function isSellPos(param1:GoodsInfo) : Boolean
      {
         if(_sellPosList == null)
         {
            return false;
         }
         return _sellPosList.indexOf(param1) >= 0;
      }
      
      public function isInSellPos(param1:int) : Boolean
      {
         if(_sellPosList == null)
         {
            return false;
         }
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(_sellPosList.indexOf(_loc2_) >= 0 && _loc2_.templateInfo.SonType == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isFashion(param1:GoodsInfo) : Boolean
      {
         if(param1.templateInfo.SonType == 109)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 110)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 112)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 111)
         {
            return true;
         }
         return false;
      }
      
      private function isJewel(param1:GoodsInfo) : Boolean
      {
         if(param1.templateInfo.SonType == 205)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 228)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 312)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 224)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 329)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 343)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 344)
         {
            return true;
         }
         if(param1.templateId == 208028)
         {
            return true;
         }
         return false;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function checkEquipUpgrade(param1:int) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:ComposeGoodsInfo = new ComposeGoodsInfo();
         _loc3_.templateId = param1;
         _loc4_ = 1;
         while(_loc4_ <= 4)
         {
            if(StoreModel.checkIsAvengerCompose(_loc3_.template.Types))
            {
               _loc5_ = int(_loc3_.template["Material" + _loc4_]);
               if(_loc5_ > 0)
               {
                  _loc2_ = 0;
                  _loc6_ = GoodsManager.instance.getBagCountByTempId(1,_loc5_);
                  if(avengerModel.armorBagDic[_loc5_])
                  {
                     _loc2_ = int(avengerModel.armorBagDic[_loc5_].count);
                  }
                  _loc3_["ownCount" + _loc4_] = _loc2_ + _loc6_;
               }
               else
               {
                  _loc3_["ownCount" + _loc4_] = -1;
               }
            }
            else
            {
               _loc3_["ownCount" + _loc4_] = _loc3_.template["Material" + _loc4_] ? getGoodsNumByTempIdInHeroEquipBayAndPlayerBag(_loc3_.template["Material" + _loc4_]) : -1;
            }
            _loc4_++;
         }
         _loc3_.canMakeCount = _loc3_.getCanMakeCount();
         if(_loc3_.canMakeCount > 0)
         {
            return true;
         }
         return false;
      }
      
      public function getMazeBagList() : SimpleDictionary
      {
         var _loc1_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(isMazeBagGoods(_loc2_))
            {
               _loc1_.add(_loc2_.id,_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function isMazeBagGoods(param1:GoodsInfo) : Boolean
      {
         if(param1.objectId == 0 && param1.bagType == 24)
         {
            return true;
         }
         return false;
      }
      
      public function getGoldRoadBagList() : SimpleDictionary
      {
         var _loc1_:SimpleDictionary = new SimpleDictionary(true);
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(isGoldRoadBagGoods(_loc2_))
            {
               _loc1_.add(_loc2_.id,_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function isGoldRoadBagGoods(param1:GoodsInfo) : Boolean
      {
         if(param1.objectId == 0 && param1.bagType == 25)
         {
            return true;
         }
         return false;
      }
      
      public function getGoodsNumByIdAndLockInEquipBag(param1:int) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if((isHeroGoods(thane.id,_loc3_) || isGneralBagGoods(_loc3_)) && _loc3_.templateId == param1 && _loc3_.isLock == true)
            {
               _loc2_ += _loc3_.count;
            }
         }
         return _loc2_;
      }
      
      public function isStoreBagGoods(param1:GoodsInfo) : Boolean
      {
         if(param1.templateInfo.SonType == 205)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 228)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 312)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 224)
         {
            return true;
         }
         if(param1.templateInfo.SonType == 329)
         {
            return true;
         }
         return false;
      }
      
      public function isStoreOrPlayerBag(param1:GoodsInfo) : Boolean
      {
         if(param1.bagType == 1)
         {
            return true;
         }
         if(param1.bagType == 34)
         {
            return true;
         }
         return false;
      }
      
      public function getGoodsNumInAllBySonType(param1:int) : int
      {
         var _loc2_:int = 0;
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.objectId == 0 && isStoreOrPlayerBag(_loc3_) && _loc3_.templateInfo.SonType == param1)
            {
               _loc2_ += _loc3_.count;
            }
         }
         return _loc2_;
      }
      
      public function getGoodsNumInAllBySonTypeAndPorp1(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         for each(var _loc4_:GoodsInfo in _goodsListByPos)
         {
            if(_loc4_.objectId == 0 && isStoreOrPlayerBag(_loc4_) && _loc4_.templateInfo.SonType == param1 && _loc4_.templateInfo.Property1 == param2)
            {
               _loc3_ += _loc4_.count;
            }
         }
         return _loc3_;
      }
      
      private function get avengerModel() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      public function getTreasureBagListByType(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(_loc3_.bagType == 38 && _loc3_.templateInfo.SonType == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sort(sortCallBack);
         return _loc2_;
      }
      
      public function getTreasureListByType(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if((_loc3_.bagType == 38 || _loc3_.bagType == 39) && _loc3_.templateInfo.SonType == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sort(sortCallBack);
         return _loc2_;
      }
      
      private function sortCallBack(param1:GoodsInfo, param2:GoodsInfo) : int
      {
         if(param1.bagType == 39 && param2.bagType == 38)
         {
            return -1;
         }
         if(param1.bagType == 38 && param2.bagType == 39)
         {
            return 1;
         }
         if(param1.templateInfo.Profile > param2.templateInfo.Profile)
         {
            return -1;
         }
         if(param1.templateInfo.Profile < param2.templateInfo.Profile)
         {
            return 1;
         }
         if(param1.strengthenGrade > param2.strengthenGrade)
         {
            return -1;
         }
         if(param1.strengthenGrade < param2.strengthenGrade)
         {
            return 1;
         }
         if(param1.templateId > param2.templateId)
         {
            return 1;
         }
         if(param1.templateId < param2.templateId)
         {
            return -1;
         }
         return 0;
      }
      
      public function getTreasureEquipBagList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:GoodsInfo in _goodsListByPos)
         {
            if(_loc2_.bagType == 39)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function getTreasureEquipByPos(param1:int) : GoodsInfo
      {
         var _loc4_:GoodsInfo = null;
         var _loc2_:Array = getTreasureEquipBagList();
         for each(var _loc3_:GoodsInfo in _loc2_)
         {
            if(_loc3_.pos == param1)
            {
               _loc4_ = _loc3_;
               break;
            }
         }
         return _loc4_;
      }
      
      public function getGoodsInfoByTempId(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:GoodsInfo in _goodsListByPos)
         {
            if(isStoreOrPlayerBag(_loc3_) && _loc3_.templateId == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
   }
}

