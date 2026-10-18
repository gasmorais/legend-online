package mvc.module.mounts
{
   import events.MountsEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   [Event(name="mountListChange",type="events.MountsEvent")]
   [Event(name="mountItemChange",type="events.MountsEvent")]
   public final class WildSoulCollection extends EventDispatcher
   {
      
      public static const PAGE_SIZE:int = 8;
      
      public static const MOUNT_UPGRADE_TYPE:int = 109;
      
      private var _currentIndex:int = 1;
      
      private var _data:SimpleDictionary;
      
      private var _kingMountDic:SimpleDictionary;
      
      public var _normalMountTemplateList:Array;
      
      public var _magicMountTemplateList:Array;
      
      public var _livestockMountTemplateList:Array;
      
      public var _beastMountTemplateList:Array;
      
      public var _technologyMountTemplateList:Array;
      
      public var _spMountTemplateList:Array;
      
      private var _allMountTempLen:int;
      
      private var _currentType:int = 0;
      
      public function WildSoulCollection()
      {
         super();
         if(!_normalMountTemplateList)
         {
            _normalMountTemplateList = [];
         }
         if(!_magicMountTemplateList)
         {
            _magicMountTemplateList = [];
         }
         if(!_livestockMountTemplateList)
         {
            _livestockMountTemplateList = [];
         }
         if(!_beastMountTemplateList)
         {
            _beastMountTemplateList = [];
         }
         if(!_technologyMountTemplateList)
         {
            _technologyMountTemplateList = [];
         }
         if(!_spMountTemplateList)
         {
            _spMountTemplateList = [];
         }
         var _loc2_:Dictionary = TempleteManager.instance.mountTemplateDic;
         _allMountTempLen = 0;
         for each(var _loc1_:MountTemplate in _loc2_)
         {
            _allMountTempLen = _allMountTempLen + 1;
            if(_loc1_.Area == 0)
            {
               _normalMountTemplateList.push(_loc1_);
            }
            else if(_loc1_.Area == 1)
            {
               _magicMountTemplateList.push(_loc1_);
            }
            else if(_loc1_.Area == 2)
            {
               _livestockMountTemplateList.push(_loc1_);
            }
            else if(_loc1_.Area == 3)
            {
               _beastMountTemplateList.push(_loc1_);
            }
            else if(_loc1_.Area == 4)
            {
               _technologyMountTemplateList.push(_loc1_);
            }
            if(_loc1_.Area != 0)
            {
               _spMountTemplateList.push(_loc1_);
            }
         }
         _normalMountTemplateList.sort(sortMount);
         _magicMountTemplateList.sort(sortMount);
         _livestockMountTemplateList.sort(sortMount);
         _beastMountTemplateList.sort(sortMount);
         _technologyMountTemplateList.sort(sortMount);
         _data = new SimpleDictionary(true);
         _kingMountDic = new SimpleDictionary(true);
         _currentIndex = 1;
         _currentType = 0;
      }
      
      public function get allMountTempLen() : int
      {
         return _allMountTempLen;
      }
      
      public function get data() : SimpleDictionary
      {
         return _data;
      }
      
      public function get kingMountDic() : SimpleDictionary
      {
         return _kingMountDic;
      }
      
      private function sortMount(param1:MountTemplate, param2:MountTemplate) : int
      {
         if(param1.MountType == 4 && param2.MountType != 4)
         {
            return -1;
         }
         if(param2.MountType == 4 && param1.MountType != 4)
         {
            return 1;
         }
         if(param1.MountType == 3 && param2.MountType != 3)
         {
            return -1;
         }
         if(param2.MountType == 3 && param1.MountType != 3)
         {
            return 1;
         }
         if(_data && isLightTemplate(param1.TemplateId) && !isLightTemplate(param2.TemplateId))
         {
            return -1;
         }
         if(_data && !isLightTemplate(param1.TemplateId) && isLightTemplate(param2.TemplateId))
         {
            return 1;
         }
         if(param1.Power + param1.Speed > param2.Power + param2.Speed)
         {
            return -1;
         }
         if(param1.Power + param1.Speed < param2.Power + param2.Speed)
         {
            return 1;
         }
         if(param1.TemplateName < param2.TemplateName)
         {
            return -1;
         }
         if(param1.TemplateName > param2.TemplateName)
         {
            return 1;
         }
         return 0;
      }
      
      private function sortMountGoodsInfo(param1:ShopGoodsInfo, param2:ShopGoodsInfo) : int
      {
         var _loc4_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.ItemId);
         var _loc6_:MountTemplate = TempleteManager.instance.mountTemplateDic[_loc4_.Property1];
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param2.ItemId);
         var _loc5_:MountTemplate = TempleteManager.instance.mountTemplateDic[_loc3_.Property1];
         if(_loc6_.Area < _loc5_.Area)
         {
            return -1;
         }
         if(_loc6_.Area > _loc5_.Area)
         {
            return 1;
         }
         if(_loc6_.GradeType > _loc5_.GradeType)
         {
            return -1;
         }
         if(_loc6_.GradeType < _loc5_.GradeType)
         {
            return 1;
         }
         if(_loc6_.TemplateId < _loc5_.TemplateId)
         {
            return -1;
         }
         if(_loc6_.TemplateId > _loc5_.TemplateId)
         {
            return 1;
         }
         return 0;
      }
      
      private function sortMount3(param1:MountTemplate, param2:MountTemplate) : int
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc8_:Array = null;
         var _loc7_:Array = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(param1.MountType == 3)
         {
            return -1;
         }
         if(param2.MountType == 3)
         {
            return 1;
         }
         _loc3_ = param1.StarAddition;
         _loc4_ = param2.StarAddition;
         _loc8_ = _loc3_.split(",");
         _loc7_ = _loc4_.split(",");
         _loc6_ = int(_loc8_[_loc8_.length - 1]);
         _loc5_ = int(_loc7_[_loc7_.length - 1]);
         if(_loc6_ < _loc5_)
         {
            return 1;
         }
         if(_loc6_ > _loc5_)
         {
            return -1;
         }
         if(param1.TemplateId < param2.TemplateId)
         {
            return -1;
         }
         if(param1.TemplateId > param2.TemplateId)
         {
            return 1;
         }
         return 0;
      }
      
      private function sortMount2(param1:Array) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc3_:MountTemplate = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc9_:MountTemplate = null;
         var _loc15_:int = int(param1.length);
         var _loc2_:Array = [];
         var _loc17_:Array = [];
         var _loc16_:Array = [];
         var _loc12_:Array = [];
         var _loc18_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc15_)
         {
            if(isLightTemplate((param1[_loc4_] as MountTemplate).TemplateId))
            {
               _loc2_.push(param1[_loc4_]);
            }
            else
            {
               _loc17_.push(param1[_loc4_]);
            }
            _loc4_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc6_ = _loc2_.length - 1;
            while(_loc6_ > _loc5_)
            {
               _loc10_ = (_loc2_[_loc6_] as MountTemplate).Property2;
               _loc11_ = (_loc2_[_loc6_ - 1] as MountTemplate).Property2;
               if(_loc10_ < _loc11_)
               {
                  _loc3_ = _loc2_[_loc6_];
                  _loc2_[_loc6_] = _loc2_[_loc6_ - 1];
                  _loc2_[_loc6_ - 1] = _loc3_;
               }
               _loc6_--;
            }
            _loc5_++;
         }
         _loc7_ = 0;
         while(_loc7_ < _loc17_.length)
         {
            _loc8_ = _loc17_.length - 1;
            while(_loc8_ > _loc7_)
            {
               _loc13_ = (_loc17_[_loc8_] as MountTemplate).Property2;
               _loc14_ = (_loc17_[_loc8_ - 1] as MountTemplate).Property2;
               if(_loc13_ < _loc14_)
               {
                  _loc9_ = _loc17_[_loc8_];
                  _loc17_[_loc8_] = _loc17_[_loc8_ - 1];
                  _loc17_[_loc8_ - 1] = _loc9_;
               }
               _loc8_--;
            }
            _loc7_++;
         }
         return _loc2_.concat(_loc17_);
      }
      
      public function addWildSoul(param1:WildSoulInfo) : void
      {
         _data.add(param1.templateId,param1);
         var _loc2_:MountTemplate = param1.template;
         if(_loc2_.MountType == 2)
         {
            putHideMountToSpecialList(_loc2_);
         }
      }
      
      public function addKingMount(param1:MountKingInfo) : void
      {
         _kingMountDic.add(param1.templateId,param1);
         var _loc2_:MountTemplate = param1.template;
         if(_loc2_.MountType == 2)
         {
            putHideMountToSpecialList(_loc2_);
         }
      }
      
      private function putHideMountToSpecialList(param1:MountTemplate) : void
      {
         if(param1.MountType != 2)
         {
            return;
         }
         var _loc2_:Boolean = specialMountListHasTemplate(param1.TemplateId);
         if(!_loc2_)
         {
            _spMountTemplateList.push(param1);
            _spMountTemplateList.sort(sortMount);
         }
      }
      
      private function specialMountListHasTemplate(param1:int) : Boolean
      {
         var _loc3_:Boolean = false;
         for each(var _loc2_:MountTemplate in _spMountTemplateList)
         {
            if(_loc2_.TemplateId == param1)
            {
               _loc3_ = true;
               break;
            }
         }
         return _loc3_;
      }
      
      public function clearWildSoulList() : void
      {
         _data.clear();
      }
      
      public function clearKingList() : void
      {
         for(var _loc1_:String in _kingMountDic)
         {
            delete _kingMountDic[_loc1_];
         }
      }
      
      public function reset() : void
      {
         currentType = 0;
         currentIndex = 1;
      }
      
      public function get totalPage() : int
      {
         return Math.max(Math.ceil(mountTemplates.length / 8),1);
      }
      
      public function dispatchChangeEvent() : void
      {
         this.dispatchEvent(new MountsEvent("mountListChange",this));
      }
      
      public function dispatchSoulInfoChangedEvent(param1:WildSoulInfo) : void
      {
         this.dispatchEvent(new MountsEvent("mountItemChange",param1));
      }
      
      public function dispatchKingInfoChangedEvent(param1:MountKingInfo) : void
      {
         this.dispatchEvent(new MountsEvent("mountKingInfoChange",param1));
      }
      
      public function dispatchShopRefreshEvent() : void
      {
         this.dispatchEvent(new MountsEvent("mountShopInfoChange"));
      }
      
      public function dispatchShopPreviewEvent() : void
      {
         this.dispatchEvent(new MountsEvent("MOUNT_SHOP_PREVIEW"));
      }
      
      public function get currentIndex() : int
      {
         return _currentIndex;
      }
      
      public function set currentIndex(param1:int) : void
      {
         if(param1 > totalPage)
         {
            return;
         }
         _currentIndex = param1;
         dispatchEvent(new MountsEvent("pageIndexChange",pageData));
      }
      
      public function get pageData() : Array
      {
         var _loc1_:int = (_currentIndex - 1) * 8;
         var _loc2_:int = int(mountTemplates.length);
         if(_loc1_ + 8 < _loc2_)
         {
            _loc2_ = _loc1_ + 8;
         }
         return mountTemplates.slice(_loc1_,_loc2_);
      }
      
      public function get currentType() : int
      {
         return _currentType;
      }
      
      public function set currentType(param1:int) : void
      {
         if(_currentType == param1)
         {
            return;
         }
         _currentType = param1;
         this.currentIndex = 1;
      }
      
      private function get mountTemplates() : Array
      {
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         if(_currentType == 0)
         {
            _normalMountTemplateList = sortMount2(_normalMountTemplateList);
            _loc2_ = _normalMountTemplateList;
         }
         else if(_currentType == 1)
         {
            _magicMountTemplateList.sort(sortMount);
            _loc2_ = _magicMountTemplateList;
         }
         else if(_currentType == 2)
         {
            _livestockMountTemplateList.sort(sortMount);
            _loc2_ = _livestockMountTemplateList;
         }
         else if(_currentType == 3)
         {
            _beastMountTemplateList.sort(sortMount);
            _loc2_ = _beastMountTemplateList;
         }
         else
         {
            if(_currentType != 4)
            {
               return null;
            }
            _technologyMountTemplateList.sort(sortMount);
            _loc2_ = _technologyMountTemplateList;
         }
         for each(var _loc1_:MountTemplate in _loc2_)
         {
            if(_loc1_)
            {
               if(!(_loc1_.MountType == 4 && ArmyManager.instance.thane.grades < 70))
               {
                  _loc3_.push(_loc1_);
               }
            }
         }
         return _loc3_;
      }
      
      private function get allMountTemplates() : Array
      {
         return _normalMountTemplateList.concat(_spMountTemplateList);
      }
      
      public function get firstBless() : Boolean
      {
         var _loc1_:WildSoulInfo = null;
         var _loc4_:Array = allMountTemplates;
         var _loc3_:uint = 0;
         var _loc2_:uint = 0;
         for each(var _loc5_:MountTemplate in _loc4_)
         {
            _loc1_ = getWildSoulInfo(_loc5_.TemplateId);
            if(_loc1_)
            {
               _loc3_ += _loc1_.bless;
               _loc2_ += _loc1_.star;
            }
         }
         if(ArmyManager.instance.thane.grades >= 70 && _loc3_ == 0 && _loc2_ == 0)
         {
            return true;
         }
         return false;
      }
      
      public function isLightTemplate(param1:int) : Boolean
      {
         return _data[param1] != null;
      }
      
      public function getWildSoulInfo(param1:int) : WildSoulInfo
      {
         return _data[param1];
      }
      
      public function getMountKingInfo(param1:int) : MountKingInfo
      {
         return _kingMountDic[param1];
      }
      
      public function getSpeedMaxMount() : int
      {
         var _loc3_:int = 0;
         var _loc1_:MountTemplate = null;
         for(var _loc2_:String in _data)
         {
            _loc1_ = TempleteManager.instance.mountTemplateDic[_loc2_];
            if(_loc1_ && _loc1_.Speed > _loc3_)
            {
               _loc3_ = _loc1_.Speed;
            }
         }
         return _loc3_;
      }
      
      public function getMountKingUpGradeTemplateByGrade(param1:int) : UpgradeTemplateInfo
      {
         var _loc2_:Array = TempleteManager.instance.getTemplatesByType(109);
         for each(var _loc3_:UpgradeTemplateInfo in _loc2_)
         {
            if(_loc3_.Grades == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

