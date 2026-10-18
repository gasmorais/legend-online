package mvc.module.theseus
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.RoyaltyTempInfo;
   import yishi.manager.PlayerManager;
   import yishi.manager.RoyaltyBossManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseussoulModel extends EventDispatcher
   {
      
      public static const VIRTUALBAG_TYPE:int = 4;
      
      public static const THESEUSCOLLEN_BAG_TYPE:int = 5;
      
      public static const EVENT_THESEUS_BAG_UPDATE:String = "EVENT_THESEUS_BAG_UPDATE";
      
      public static const EVENT_CHOOSE_SUIT:String = "EVENT_CHOOSE_SUIT";
      
      public static const THESEUS_STORE_BAG_UPDATE:String = "THESEUS_STORE_BAG_UPDATE";
      
      public static const THESEUS_ALL_RESOLVE:String = "THESEUS_ALL_RESOLVE";
      
      public static const THESEUS_RESOLVE_TYPE:int = 3;
      
      public static const TREASURE_RESOLVE_TYPE:int = 4;
      
      public static const SONTYPES:Array = [0,2,3,4,1,5,8,8,9,9,6,7];
      
      private var _level:int;
      
      private var _itemDic:SimpleDictionary;
      
      private var _armorBagDic:SimpleDictionary;
      
      private var _suitInfo:TheseusSuitInfo;
      
      private var _propertys:TheseusPropertys;
      
      private var _yiDic:SimpleDictionary;
      
      private var _treasurePros:TreasurePropertys;
      
      private var _currSuitIdx:int = 1;
      
      public var hokeInfo:String;
      
      public var coreLevel:int = 0;
      
      public var resolveLv:String = "10";
      
      public var resolveType:String = "2";
      
      public var color:String = "ffffff";
      
      public var _itemSort:Array = [];
      
      public var resolveBagDic:SimpleDictionary;
      
      public var resolveBagDic1:SimpleDictionary;
      
      public var isAllResolve:Boolean = false;
      
      private var _redDic:Dictionary = new Dictionary();
      
      public function TheseussoulModel()
      {
         super();
         _armorBagDic = new SimpleDictionary();
         _suitInfo = new TheseusSuitInfo();
         _propertys = new TheseusPropertys();
         _yiDic = new SimpleDictionary();
         resolveBagDic = new SimpleDictionary();
         resolveBagDic1 = new SimpleDictionary();
         _treasurePros = new TreasurePropertys();
      }
      
      public function updateSuite1(param1:int, param2:int, param3:String) : void
      {
         var _loc4_:Array = this.suitInfo[param3].split(",");
         if(param1 >= 0 && param1 < _loc4_.length)
         {
            _loc4_[param1] = param2.toString();
            this.suitInfo[param3] = _loc4_.join(",");
         }
      }
      
      public function updateSuite2(param1:int, param2:String) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Array = this.suitInfo[param2].split(",");
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(int(_loc3_[_loc4_]) == param1)
            {
               _loc3_[_loc4_] = "0";
            }
            _loc4_++;
         }
         this.suitInfo[param2] = _loc3_.join(",");
      }
      
      public function get armorBagDic() : SimpleDictionary
      {
         return _armorBagDic;
      }
      
      public function get itemSort() : Array
      {
         return _itemSort;
      }
      
      public function set level(param1:int) : void
      {
         this._level = param1;
      }
      
      public function getItemInfo(param1:int) : WarFrameItemInfo
      {
         return _armorBagDic[param1];
      }
      
      public function sortArmorBagDic() : void
      {
         var item:WarFrameItemInfo;
         _itemSort = [];
         for each(item in _armorBagDic)
         {
            _itemSort.push(item);
         }
         _itemSort.sort(function(param1:WarFrameItemInfo, param2:WarFrameItemInfo):int
         {
            if(param1.isEquip != param2.isEquip)
            {
               return param1.isEquip ? -1 : 1;
            }
            if(param1.reform != param2.reform)
            {
               return param2.reform - param1.reform;
            }
            if(param1.strengthen != param2.strengthen)
            {
               return param2.strengthen - param1.strengthen;
            }
            if(param1.warTempInfo.TemplateId != param2.warTempInfo.TemplateId)
            {
               return param2.warTempInfo.TemplateId - param1.warTempInfo.TemplateId;
            }
            return param2.warTempInfo.Property4 - param1.warTempInfo.Property4;
         });
      }
      
      public function putItem(param1:int, param2:WarFrameItemInfo) : void
      {
         if(param2 == null)
         {
            return;
         }
         if(getItemInfo(param1))
         {
            _armorBagDic.del(param1);
         }
         if(param2.count > 0)
         {
            _armorBagDic.add(param1,param2);
         }
      }
      
      public function delItem(param1:int) : void
      {
         _armorBagDic.del(param1);
      }
      
      public function getRoyaltyLevel(param1:int) : int
      {
         if(playInfo.userId == param1)
         {
            return RoyaltyBossManager.instance.model.royaltyLevel;
         }
         return _level;
      }
      
      public function get playInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function get suitInfo() : TheseusSuitInfo
      {
         return _suitInfo;
      }
      
      public function get propertys() : TheseusPropertys
      {
         return _propertys;
      }
      
      public function get treasurePros() : TreasurePropertys
      {
         return _treasurePros;
      }
      
      public function get yiDic() : SimpleDictionary
      {
         return _yiDic;
      }
      
      public function get currSuitIdx() : int
      {
         return _currSuitIdx;
      }
      
      public function set currSuitIdx(param1:int) : void
      {
         if(_currSuitIdx == param1)
         {
            return;
         }
         _currSuitIdx = param1;
         this.dispatchEvent(new Event("EVENT_CHOOSE_SUIT"));
      }
      
      public function moveBagToResolve(param1:WarFrameItemInfo) : void
      {
         if(param1.isLock)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AllResolvePopFrame.Avenger.name2"));
            return;
         }
         var _loc2_:WarFrameItemInfo = new WarFrameItemInfo();
         _loc2_ = param1.clone();
         _loc2_.count = 1;
         resolveBagDic.add(param1.id,_loc2_);
      }
      
      public function moveResolveToBag(param1:WarFrameItemInfo) : void
      {
         if(resolveBagDic[param1.id])
         {
            resolveBagDic.del(param1.id);
         }
      }
      
      public function allResolve(param1:WarFrameItemInfo) : void
      {
         var _loc3_:int = 0;
         if(param1.isLock)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AllResolvePopFrame.Avenger.name2"));
            return;
         }
         if(param1.count <= 0)
         {
            return;
         }
         var _loc2_:WarFrameItemInfo = new WarFrameItemInfo();
         _loc2_ = param1.clone();
         _loc3_ = 0;
         while(_loc3_ < _itemSort.length)
         {
            if(_loc2_.id == _itemSort[_loc3_].id && _itemSort[_loc3_].isExist && !_itemSort[_loc3_].isEquip)
            {
               resolveBagDic1.add(_loc2_.id,_loc2_);
            }
            _loc3_++;
         }
      }
      
      public function allResolveToBag(param1:WarFrameItemInfo) : void
      {
         if(resolveBagDic1[param1.id])
         {
            resolveBagDic1.del(param1.id);
         }
      }
      
      public function resetResolveBagList() : void
      {
         resolveBagDic.clear();
         resolveBagDic1.clear();
         isAllResolve = false;
      }
      
      public function get redDic() : Dictionary
      {
         return this._redDic;
      }
      
      public function isAllRed() : Boolean
      {
         for each(var _loc1_:Boolean in _redDic)
         {
            if(_loc1_)
            {
               return _loc1_;
            }
         }
         return false;
      }
      
      public function checkOneSuitRed(param1:int) : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc2_:int = int(SONTYPES.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1 + "_" + _loc4_;
            if(_redDic[_loc3_])
            {
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function checkEquipRed() : void
      {
         var _loc5_:String = null;
         var _loc1_:Array = null;
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:WarFrameItemInfo = null;
         var _loc4_:* = null;
         var _loc8_:Boolean = false;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc9_:int = RoyaltyBossManager.instance.model.royaltyLevel;
         var _loc2_:RoyaltyTempInfo = TempleteManager.instance.royaltyTempCate.getTempInfoByLevel(_loc9_);
         _loc7_ = 1;
         while(_loc7_ <= 9)
         {
            if(!(!_loc2_ || _loc2_.OpenTheseus < _loc7_))
            {
               _loc3_ = this.getSuitEquipList(_loc7_);
               _loc1_ = this.suitInfo.getSuitArray(_loc7_);
               _loc6_ = int(_loc1_.length);
               _loc10_ = 0;
               while(_loc10_ < _loc6_)
               {
                  _loc5_ = _loc7_ + "_" + _loc10_;
                  _loc11_ = int(_loc1_[_loc10_]);
                  _loc8_ = false;
                  if(_loc11_ > 0)
                  {
                     _loc12_ = _armorBagDic[_loc11_];
                     if(_loc12_ && _loc12_.warTempInfo)
                     {
                        _loc8_ = this.checkInGoodsRed(_loc3_,_loc12_.warTempInfo.Property3,_loc12_.warTempInfo.Property4,_loc12_);
                     }
                  }
                  else
                  {
                     _loc8_ = this.checkInGoodsRed(_loc3_,SONTYPES[_loc10_],-1);
                  }
                  _redDic[_loc5_] = _loc8_;
                  _loc10_++;
               }
            }
            _loc7_++;
         }
      }
      
      private function getSuitEquipList(param1:int) : Array
      {
         var _loc4_:GoodsTemplateInfo = null;
         var _loc2_:Array = [];
         var _loc3_:Array = _armorBagDic.getList();
         for each(var _loc5_:WarFrameItemInfo in _loc3_)
         {
            _loc4_ = _loc5_.warTempInfo;
            if(_loc4_ && _loc5_.type == 1 && _loc4_.Property1 == param1)
            {
               _loc2_.push(_loc5_);
            }
         }
         return _loc2_;
      }
      
      private function getSuitIsEquipList(param1:int) : Array
      {
         var _loc4_:GoodsTemplateInfo = null;
         var _loc2_:Array = [];
         var _loc3_:Array = _armorBagDic.getList();
         for each(var _loc5_:WarFrameItemInfo in _loc3_)
         {
            _loc4_ = _loc5_.warTempInfo;
            if(_loc4_ && _loc4_.Property1 == param1 && _loc5_.isEquip)
            {
               _loc2_.push(_loc5_);
            }
         }
         return _loc2_;
      }
      
      public function getSuitEquipZhangjValue(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc2_:Array = getSuitIsEquipList(param1);
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ += getEquipZhangjValue(_loc2_[_loc4_]);
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getEquipZhangjValue(param1:WarFrameItemInfo) : int
      {
         var _loc2_:int = param1.warTempInfo.Property5;
         if(param1.warReformTempInfo)
         {
            _loc2_ += param1.warReformTempInfo.Fraction;
         }
         if(param1.warStrengthTempInfo)
         {
            _loc2_ += param1.warStrengthTempInfo.Fraction;
         }
         return _loc2_;
      }
      
      private function checkInGoodsRed(param1:Array, param2:int, param3:int, param4:WarFrameItemInfo = null) : Boolean
      {
         var _loc5_:GoodsTemplateInfo = null;
         for each(var _loc6_:WarFrameItemInfo in param1)
         {
            _loc5_ = _loc6_.warTempInfo;
            if(param4)
            {
               if(_loc5_ && _loc6_.type == 1 && !_loc6_.isEquip && _loc5_.Property3 == param2 && fightSort(_loc6_) > fightSort(param4))
               {
                  return true;
               }
            }
            else if(_loc5_ && _loc6_.type == 1 && !_loc6_.isEquip && _loc5_.Property3 == param2 && _loc5_.Property4 > param3)
            {
               return true;
            }
         }
         return false;
      }
      
      private function fightSort(param1:WarFrameItemInfo) : Number
      {
         var _loc2_:Number = 0;
         _loc2_ = param1.warTempInfo.Property5;
         if(param1.warReformTempInfo)
         {
            _loc2_ += param1.warReformTempInfo.CountFraction;
         }
         if(param1.warStrengthTempInfo)
         {
            _loc2_ += param1.warStrengthTempInfo.CountFraction;
         }
         return _loc2_;
      }
   }
}

