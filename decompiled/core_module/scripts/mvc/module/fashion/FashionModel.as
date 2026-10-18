package mvc.module.fashion
{
   import bag.helper.GoodsCheck;
   import com.road.yishi.proto.fashion.FashionInfoMsg;
   import events.FashionEvent;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.consant.JobType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.FashionPolishTemplateInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.tips.MessageTipManager;
   
   public class FashionModel extends EventDispatcher
   {
      
      public static const INDENTITY_OPEN_GRADE:int = 27;
      
      public static const FASHION_COMPOSE_PANEL:String = "FASHION_COMPOSE_PANEL";
      
      public static const FASHION_SWITCH_PANEL:String = "FASHION_SWITCH_PANEL";
      
      public static const FASHION_REFRESH_PANEL:String = "FASHION_REFRESH_PANEL";
      
      public static const FASHION_PANEL:String = "FASHION_PANEL";
      
      public static const EQUIP_PANEL:String = "EQUIP_PANEL";
      
      public static const SHOP_SCENE:String = "SHOP_SCENE";
      
      public static const FASHION_STORE_SCENE:String = "FASHION_STORE_SCENE";
      
      public static const TRY_ON:String = "TRY_ON";
      
      public static const GET_OFF:String = "GET_OFF";
      
      public static const FASHION_SOUL:int = 208020;
      
      public static const FASHION_LUCKYCHARM:int = 208021;
      
      public static const FASHION_SONYTYPE:int = 278;
      
      public static const FASHION_JOB:String = "99";
      
      public var to_pos:int;
      
      private var _selectedPanel:String;
      
      private var _openScene:String;
      
      private var _showThane:ThaneInfo;
      
      private var _showDic:SimpleDictionary;
      
      private var _stepList:Vector.<FashionTryInfo>;
      
      public var opState:int = 0;
      
      public var tryOnShopInfo:ShopGoodsInfo;
      
      public var tapNum:int = 0;
      
      private var _fashionIds:Vector.<int> = new Vector.<int>();
      
      private var _bookList:SimpleDictionary;
      
      private var _saveList:Dictionary;
      
      private var _dragonTalkerSaveList:Dictionary;
      
      public var identityedList:Vector.<FashionInfo> = new Vector.<FashionInfo>();
      
      public var polishList:Vector.<FashionPolishInfo> = new Vector.<FashionPolishInfo>();
      
      public var lookDragonTalkerFashion:Boolean;
      
      private var _weaponTems:Array = [];
      
      private var _clothesTems:Array = [];
      
      private var _hatTems:Array = [];
      
      private var _wingTems:Array = [];
      
      private var _playerWeaponTems:Array = [];
      
      private var _playerClothesTems:Array = [];
      
      private var _playerHatTems:Array = [];
      
      private var _playerWingTems:Array = [];
      
      private var _dragonTalkerWeaponTems:Array = [];
      
      private var _dragonTalkerClothesTems:Array = [];
      
      private var _dragonTalkerHatTems:Array = [];
      
      private var _dragonTalkerWingTems:Array = [];
      
      public function FashionModel(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function get dragonTalkerWingTems() : Array
      {
         return _dragonTalkerWingTems;
      }
      
      public function get dragonTalkerHatTems() : Array
      {
         return _dragonTalkerHatTems;
      }
      
      public function get dragonTalkerClothesTems() : Array
      {
         return _dragonTalkerClothesTems;
      }
      
      public function get dragonTalkerWeaponTems() : Array
      {
         return _dragonTalkerWeaponTems;
      }
      
      public function get playerWingTems() : Array
      {
         return _playerWingTems;
      }
      
      public function get playerHatTems() : Array
      {
         return _playerHatTems;
      }
      
      public function get playerClothesTems() : Array
      {
         return _playerClothesTems;
      }
      
      public function get playerWeaponTems() : Array
      {
         return _playerWeaponTems;
      }
      
      public function get stepList() : Vector.<FashionTryInfo>
      {
         if(!_stepList)
         {
            _stepList = new Vector.<FashionTryInfo>();
         }
         return _stepList;
      }
      
      public function get showThane() : ThaneInfo
      {
         if(!_showThane)
         {
            _showThane = new ThaneInfo();
            _showThane.templateId = thane.templateId;
            _showThane.wingAvata = thane.wingEquipAvata;
            _showThane.hairFashionAvata = thane.hairFashionAvata;
            _showThane.bodyFashionAvata = thane.bodyFashionAvata;
            _showThane.armsFashionAvata = thane.armsFashionAvata;
         }
         _showThane.hairEquipAvata = thane.hairEquipAvata;
         _showThane.bodyEquipAvata = thane.bodyEquipAvata;
         _showThane.armsEquipAvata = thane.armsEquipAvata;
         return _showThane;
      }
      
      public function get canGotoPreStep() : Boolean
      {
         return _stepList.length > 0;
      }
      
      public function get showDic() : SimpleDictionary
      {
         if(!_showDic)
         {
            initShowDic();
         }
         return _showDic;
      }
      
      public function initShowDic() : void
      {
         var _loc2_:int = 0;
         if(!_showDic)
         {
            _showDic = new SimpleDictionary(true);
         }
         var _loc1_:Array = this.fashionEquipList;
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _showDic.add(getSonTypeByInfo(_loc1_[_loc2_]),_loc1_[_loc2_]);
            _loc2_++;
         }
         dispatchEvent(new FashionEvent("REFRESH_BAG",null));
      }
      
      public function wearFahion(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:int = getSonTypeByInfo(param1);
         var _loc3_:FashionTryInfo = new FashionTryInfo();
         _loc3_.sonType = _loc2_;
         _loc3_.oldInfo = showDic[_loc2_];
         switch(_loc2_ - 109)
         {
            case 0:
               if(getAvataByInfo(param1) != "")
               {
                  if(checkFashionType(param1,true))
                  {
                     showThane.wingAvata = getAvataByInfo(param1);
                     break;
                  }
                  showThane.wingAvata = "";
               }
               break;
            case 1:
               if(getAvataByInfo(param1) != "")
               {
                  if(checkFashionType(param1,true))
                  {
                     showThane.hairFashionAvata = getAvataByInfo(param1);
                  }
                  else
                  {
                     showThane.hairFashionAvata = "";
                  }
               }
               break;
            case 2:
               if(getAvataByInfo(param1) != "")
               {
                  if(checkFashionType(param1,true))
                  {
                     showThane.armsFashionAvata = getAvataByInfo(param1);
                  }
                  else
                  {
                     showThane.armsFashionAvata = "";
                  }
               }
               break;
            case 3:
               if(getAvataByInfo(param1) != "")
               {
                  if(checkFashionType(param1,true))
                  {
                     showThane.bodyFashionAvata = getAvataByInfo(param1);
                  }
                  else
                  {
                     showThane.bodyFashionAvata = "";
                  }
               }
         }
         stepList.push(_loc3_);
         showDic.add(_loc2_,param1);
         showThane.commit();
         dispatchEvent(new FashionEvent("REFRESH_BAG",null));
      }
      
      private function checkFashionType(param1:Object, param2:Boolean = false) : Boolean
      {
         var _loc5_:GoodsTemplateInfo = null;
         var _loc4_:ShopGoodsInfo = param1 as ShopGoodsInfo;
         var _loc7_:GoodsInfo = param1 as GoodsInfo;
         var _loc6_:Boolean = true;
         var _loc3_:String = LanguageMgr.GetTranslation("fashion.tip.JobValidate",JobType.getJobName(thane.templateInfo.Job));
         if(_loc4_)
         {
            _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_.ItemId);
         }
         if(_loc7_)
         {
            if(_loc7_.isViceEquip)
            {
               _loc6_ = false;
            }
         }
         if(!_loc6_ && param2)
         {
            MessageTipManager.instance().show(_loc3_);
         }
         return _loc6_;
      }
      
      public function getOffFashion(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:FashionTryInfo = new FashionTryInfo();
         _loc2_.sonType = getSonTypeByInfo(param1);
         _loc2_.oldInfo = showDic[getSonTypeByInfo(param1)];
         switch(getSonTypeByInfo(param1) - 109)
         {
            case 0:
               showThane.wingAvata = "";
               break;
            case 1:
               showThane.hairFashionAvata = "";
               break;
            case 2:
               showThane.armsFashionAvata = "";
               break;
            case 3:
               showThane.bodyFashionAvata = "";
         }
         stepList.push(_loc2_);
         showDic.add(getSonTypeByInfo(param1),null);
         showThane.commit();
         dispatchEvent(new FashionEvent("REFRESH_BAG",null));
      }
      
      public function gotoPreStep() : void
      {
         var _loc1_:int = 0;
         if(stepList.length <= 0)
         {
            return;
         }
         showDic.add(stepList[stepList.length - 1].sonType,stepList[stepList.length - 1].oldInfo);
         showThane.hairFashionAvata = "";
         showThane.bodyFashionAvata = "";
         showThane.armsFashionAvata = "";
         showThane.wingAvata = "";
         _loc1_ = 0;
         while(_loc1_ < showDic.getList().length)
         {
            switch(getSonTypeByInfo(showDic.getList()[_loc1_]) - 109)
            {
               case 0:
                  if(checkFashionType(showDic.getList()[_loc1_]))
                  {
                     showThane.wingAvata = getAvataByInfo(showDic.getList()[_loc1_]);
                  }
                  break;
               case 1:
                  if(checkFashionType(showDic.getList()[_loc1_]))
                  {
                     showThane.hairFashionAvata = getAvataByInfo(showDic.getList()[_loc1_]);
                  }
                  break;
               case 2:
                  if(checkFashionType(showDic.getList()[_loc1_]))
                  {
                     showThane.armsFashionAvata = getAvataByInfo(showDic.getList()[_loc1_]);
                  }
                  break;
               case 3:
                  if(checkFashionType(showDic.getList()[_loc1_]))
                  {
                     showThane.bodyFashionAvata = getAvataByInfo(showDic.getList()[_loc1_]);
                  }
            }
            _loc1_++;
         }
         stepList.pop();
         showThane.commit();
         dispatchEvent(new FashionEvent("REFRESH_BAG",null));
      }
      
      private function getSonTypeByInfo(param1:Object) : int
      {
         var _loc3_:GoodsTemplateInfo = null;
         var _loc2_:ShopGoodsInfo = param1 as ShopGoodsInfo;
         var _loc4_:GoodsInfo = param1 as GoodsInfo;
         if(_loc2_)
         {
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.ItemId);
            return _loc3_.SonType;
         }
         if(_loc4_)
         {
            return _loc4_.templateInfo.SonType;
         }
         return 0;
      }
      
      private function getIdByInfo(param1:Object) : int
      {
         var _loc2_:ShopGoodsInfo = param1 as ShopGoodsInfo;
         var _loc3_:GoodsInfo = param1 as GoodsInfo;
         if(_loc2_)
         {
            return _loc2_.ItemId;
         }
         if(_loc3_)
         {
            return _loc3_.templateId;
         }
         return 0;
      }
      
      private function getAvataByInfo(param1:Object) : String
      {
         var _loc3_:GoodsTemplateInfo = null;
         var _loc2_:ShopGoodsInfo = param1 as ShopGoodsInfo;
         var _loc4_:GoodsInfo = param1 as GoodsInfo;
         if(_loc2_)
         {
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.ItemId);
            return _loc3_.Avata;
         }
         if(_loc4_)
         {
            return _loc4_.templateInfo.Avata;
         }
         return "";
      }
      
      public function get selectedPanel() : String
      {
         return _selectedPanel;
      }
      
      public function set selectedPanel(param1:String) : void
      {
         if(_selectedPanel == param1)
         {
            return;
         }
         _selectedPanel = param1;
         dispatchEvent(new FashionEvent("FASHION_STORE_CHANGE",null));
      }
      
      public function get scene() : String
      {
         return _openScene;
      }
      
      public function set scene(param1:String) : void
      {
         _openScene = param1;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get fashionList() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         if(_openScene == "FASHION_STORE_SCENE")
         {
            if(_selectedPanel == "FASHION_SWITCH_PANEL")
            {
               _loc1_ = _loc1_.concat(fashionEquipList).concat(fashionBagList);
            }
            else
            {
               _loc1_ = _loc1_.concat(fashionBagList).concat(fashionSoulBagList).concat(fashionLuckyBagList);
            }
         }
         else if(_openScene == "SHOP_SCENE")
         {
            _loc1_ = _loc1_.concat(fashionEquipList).concat(fashionBagList);
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               _loc3_ = 0;
               while(_loc3_ < showDic.getList().length)
               {
                  if(showDic.getList()[_loc3_] is GoodsInfo)
                  {
                     if(_loc1_[_loc2_] && (_loc1_[_loc2_] as GoodsInfo).id == showDic.getList()[_loc3_].id)
                     {
                        _loc1_.splice(_loc2_,1);
                        _loc2_ = -1;
                     }
                  }
                  _loc3_++;
               }
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public function hasFashionAtSonType(param1:int) : Boolean
      {
         if(param1 != 111 && param1 != 112 && param1 != 110 && param1 != 109)
         {
            return false;
         }
         for each(var _loc2_:GoodsInfo in fashionEquipList)
         {
            if(_loc2_.templateInfo.SonType == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get fashionEquipList() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:Array = GoodsManager.instance.getHeroEquipListById(thane.id).getList();
         for each(var _loc3_:GoodsInfo in _loc2_)
         {
            if(isFashion(_loc3_))
            {
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function get fashionBagList() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:Array = GoodsManager.instance.getGeneralBagEquipList();
         for each(var _loc3_:GoodsInfo in _loc2_)
         {
            if(isFashion(_loc3_))
            {
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function get fashionLuckyBagList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:GoodsInfo in GoodsManager.instance.getGoodsByGoodsTId(208021))
         {
            if(_loc2_.bagType == 1)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function get fashionSoulBagList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:GoodsInfo in GoodsManager.instance.getGoodsByGoodsTId(208020))
         {
            if(_loc2_.bagType == 1)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function get fashionSoulBagCount() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:GoodsInfo in fashionSoulBagList)
         {
            _loc1_ += _loc2_.count;
         }
         return _loc1_;
      }
      
      public function get fashionSoulBagBindList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:GoodsInfo in fashionSoulBagList)
         {
            if(_loc2_.isBinds)
            {
               _loc1_.push(_loc2_);
            }
         }
         return _loc1_;
      }
      
      public function get fashionSoulBagBindCount() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:GoodsInfo in fashionSoulBagBindList)
         {
            _loc1_ += _loc2_.count;
         }
         return _loc1_;
      }
      
      public function moveGoodsBack() : void
      {
         var _loc1_:Array = GoodsManager.instance.getGoodsByBagType(0);
         for each(var _loc2_:GoodsInfo in _loc1_)
         {
            PlayerManager.instance.moveBagToBag(_loc2_.bagType,_loc2_.objectId,_loc2_.pos,1,0,0,1);
         }
      }
      
      public function isFashion(param1:GoodsInfo) : Boolean
      {
         if(!param1 || !param1.templateInfo)
         {
            return false;
         }
         return GoodsCheck.isFashion(param1.templateInfo);
      }
      
      public function isFashionBySonType(param1:int) : Boolean
      {
         if(param1 == 112)
         {
            return true;
         }
         if(param1 == 110)
         {
            return true;
         }
         if(param1 == 111)
         {
            return true;
         }
         if(param1 == 109)
         {
            return true;
         }
         return false;
      }
      
      public function resetMovieclip() : void
      {
         opState = 0;
         this.dispatchEvent(new FashionEvent("RESET_MOVIECLIP",this));
      }
      
      public function get fashionIds() : Vector.<int>
      {
         return _fashionIds;
      }
      
      public function set fashionIds(param1:Vector.<int>) : void
      {
         var _loc2_:GoodsTemplateInfo = null;
         _fashionIds = param1;
         _weaponTems.length = 0;
         _clothesTems.length = 0;
         _hatTems.length = 0;
         _wingTems.length = 0;
         _playerWeaponTems.length = 0;
         _playerClothesTems.length = 0;
         _playerHatTems.length = 0;
         _playerWingTems.length = 0;
         _dragonTalkerWeaponTems.length = 0;
         _dragonTalkerClothesTems.length = 0;
         _dragonTalkerHatTems.length = 0;
         _dragonTalkerWingTems.length = 0;
         for each(var _loc3_:int in param1)
         {
            _loc2_ = getTemplateByID(_loc3_);
            if(!_loc2_)
            {
               continue;
            }
            switch(_loc2_.SonType - 109)
            {
               case 0:
                  _wingTems.push(_loc2_);
                  if(isDragonFashion(_loc3_))
                  {
                     _dragonTalkerWingTems.push(_loc2_);
                  }
                  else
                  {
                     _playerWingTems.push(_loc2_);
                  }
                  break;
               case 1:
                  _hatTems.push(_loc2_);
                  if(isDragonFashion(_loc3_))
                  {
                     _dragonTalkerHatTems.push(_loc2_);
                  }
                  else
                  {
                     _playerHatTems.push(_loc2_);
                  }
                  break;
               case 2:
                  _weaponTems.push(_loc2_);
                  if(isDragonFashion(_loc3_))
                  {
                     _dragonTalkerWeaponTems.push(_loc2_);
                  }
                  else
                  {
                     _playerWeaponTems.push(_loc2_);
                  }
                  break;
               case 3:
                  _clothesTems.push(_loc2_);
                  if(isDragonFashion(_loc3_))
                  {
                     _dragonTalkerClothesTems.push(_loc2_);
                  }
                  else
                  {
                     _playerClothesTems.push(_loc2_);
                  }
            }
         }
         _weaponTems.sort(fashionCompareFunction);
         _clothesTems.sort(fashionCompareFunction);
         _hatTems.sort(fashionCompareFunction);
         _wingTems.sort(fashionCompareFunction);
         _playerWeaponTems.sort(fashionCompareFunction);
         _playerClothesTems.sort(fashionCompareFunction);
         _playerHatTems.sort(fashionCompareFunction);
         _playerWingTems.sort(fashionCompareFunction);
         _dragonTalkerWeaponTems.sort(fashionCompareFunction);
         _dragonTalkerClothesTems.sort(fashionCompareFunction);
         _dragonTalkerHatTems.sort(fashionCompareFunction);
         _dragonTalkerWingTems.sort(fashionCompareFunction);
      }
      
      private function fashionCompareFunction(param1:GoodsTemplateInfo, param2:GoodsTemplateInfo) : int
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1.TransformId < param2.TransformId)
         {
            return -1;
         }
         if(param1.TransformId > param2.TransformId)
         {
            return 1;
         }
         _loc3_ = getFashionPropity(param1);
         _loc4_ = getFashionPropity(param2);
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(param1.TemplateId > param2.TemplateId)
         {
            return -1;
         }
         if(param1.TemplateId < param2.TemplateId)
         {
            return 1;
         }
         return 0;
      }
      
      private function getFashionPropity(param1:GoodsTemplateInfo) : int
      {
         var _loc2_:int = 3;
         if(param1.Property4 == 0)
         {
            _loc2_ = 1;
         }
         else if(param1.Property4 == 2)
         {
            _loc2_ = 2;
         }
         else
         {
            _loc2_ = 3;
         }
         return _loc2_;
      }
      
      public function get newFashionDic() : Dictionary
      {
         var _loc1_:GoodsTemplateInfo = null;
         var _loc3_:Dictionary = new Dictionary();
         _loc3_["weapon"] = 0;
         _loc3_["clothes"] = 0;
         _loc3_["hat"] = 0;
         _loc3_["wing"] = 0;
         for(var _loc2_:String in bookList)
         {
            if(bookList[_loc2_] == false)
            {
               _loc1_ = getTemplateByID(int(_loc2_));
               if(_loc1_.SonType == 112 && _loc1_.Job != "99")
               {
                  _loc3_["clothes"]++;
               }
               if(_loc1_.SonType == 110 && _loc1_.Job != "99")
               {
                  _loc3_["hat"]++;
               }
               if(_loc1_.SonType == 111 && _loc1_.Job != "99")
               {
                  _loc3_["weapon"]++;
               }
               if(_loc1_.SonType == 109 && _loc1_.Job != "99")
               {
                  _loc3_["wing"]++;
               }
            }
         }
         return _loc3_;
      }
      
      public function get dragontalkerNewFashionDic() : Dictionary
      {
         var _loc1_:GoodsTemplateInfo = null;
         var _loc3_:Dictionary = new Dictionary();
         _loc3_["weapon"] = 0;
         _loc3_["clothes"] = 0;
         _loc3_["hat"] = 0;
         _loc3_["wing"] = 0;
         for(var _loc2_:String in bookList)
         {
            if(bookList[_loc2_] == false)
            {
               _loc1_ = getTemplateByID(int(_loc2_));
               if(_loc1_.SonType == 112 && _loc1_.Job == "99")
               {
                  _loc3_["clothes"]++;
               }
               if(_loc1_.SonType == 110 && _loc1_.Job == "99")
               {
                  _loc3_["hat"]++;
               }
               if(_loc1_.SonType == 111 && _loc1_.Job == "99")
               {
                  _loc3_["weapon"]++;
               }
               if(_loc1_.SonType == 109 && _loc1_.Job == "99")
               {
                  _loc3_["wing"]++;
               }
            }
         }
         return _loc3_;
      }
      
      private function getTemplateByID(param1:int) : GoodsTemplateInfo
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
      }
      
      public function get weaponTems() : Array
      {
         return _weaponTems;
      }
      
      public function get clothesTems() : Array
      {
         return _clothesTems;
      }
      
      public function get hatTems() : Array
      {
         return _hatTems;
      }
      
      public function get wingTems() : Array
      {
         return _wingTems;
      }
      
      public function get bookList() : SimpleDictionary
      {
         if(_bookList == null)
         {
            _bookList = new SimpleDictionary();
         }
         return _bookList;
      }
      
      public function isInBookList(param1:int) : Boolean
      {
         if(param1 in bookList)
         {
            return true;
         }
         return false;
      }
      
      public function get newFashionCount() : int
      {
         var _loc1_:int = 0;
         for(var _loc2_:String in bookList)
         {
            if(bookList[_loc2_] == false && !isDragonFashion(int(_loc2_)))
            {
               _loc1_ += 1;
            }
         }
         return _loc1_;
      }
      
      private function isDragonFashion(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
         if(_loc3_)
         {
            if(_loc3_.Job == "99")
            {
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      public function get newFashionDragonTalkerCount() : int
      {
         var _loc1_:int = 0;
         for(var _loc2_:String in bookList)
         {
            if(bookList[_loc2_] == false && isDragonFashion(int(_loc2_)))
            {
               _loc1_ += 1;
            }
         }
         return _loc1_;
      }
      
      public function get saveList() : Dictionary
      {
         if(_saveList == null)
         {
            _saveList = new Dictionary();
         }
         return _saveList;
      }
      
      public function isInSaveList(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         for(var _loc3_:String in saveList)
         {
            if(saveList[_loc3_] == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get dragonTalkerSaveList() : Dictionary
      {
         if(_dragonTalkerSaveList == null)
         {
            _dragonTalkerSaveList = new Dictionary();
         }
         return _dragonTalkerSaveList;
      }
      
      public function isInDragonTalkerSaveList(param1:int) : Boolean
      {
         var _loc2_:Boolean = false;
         for(var _loc3_:String in dragonTalkerSaveList)
         {
            if(dragonTalkerSaveList[_loc3_] == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getCountForIdentityBook(param1:GoodsTemplateInfo) : int
      {
         return param1.Property1;
      }
      
      public function getCountForRefresh(param1:GoodsTemplateInfo) : int
      {
         return param1.Property2;
      }
      
      public function getSuccessRateForIdentityBook(param1:GoodsTemplateInfo) : int
      {
         var _loc2_:Array = [100,100,100,100,100,100];
         return _loc2_[param1.TransformId];
      }
      
      public function getFashionObjectSkillTemplate(param1:GoodsTemplateInfo) : SkillTempInfo
      {
         var _loc2_:SkillTempInfo = null;
         for each(var _loc3_:FashionInfo in identityedList)
         {
            if(_loc3_.fashionTempId == param1.TemplateId)
            {
               _loc2_ = TempleteManager.instance.getSkillTemplateInfoById(_loc3_.appraisalSkill);
            }
         }
         return _loc2_;
      }
      
      public function hasIdentityedBook(param1:int) : Boolean
      {
         for each(var _loc2_:FashionInfo in identityedList)
         {
            if(_loc2_.fashionTempId == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function hasRefreshFull(param1:int) : Boolean
      {
         var _loc2_:SkillTempInfo = null;
         for each(var _loc3_:FashionInfo in identityedList)
         {
            if(_loc3_.fashionTempId == param1)
            {
               _loc2_ = TempleteManager.instance.getSkillTemplateInfoById(_loc3_.appraisalSkill);
               if(_loc2_ && _loc2_.Grades == 5)
               {
                  return true;
               }
               return false;
            }
         }
         return false;
      }
      
      public function getIdentityedProperties() : Array
      {
         var _loc2_:GoodsTemplateInfo = null;
         var _loc3_:SkillPropertyTempInfo = null;
         var _loc1_:Array = [0,0,0,0];
         for each(var _loc4_:FashionInfo in identityedList)
         {
            _loc2_ = getTemplateByID(_loc4_.fashionTempId);
            if(_loc2_)
            {
               _loc3_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc4_.appraisalSkill);
               if(_loc3_)
               {
                  var _loc5_:int = 0;
                  var _loc6_:Number = _loc1_[_loc5_] + _loc3_.Power;
                  _loc1_[_loc5_] = _loc6_;
                  _loc1_[1] += _loc3_.Agility;
                  _loc1_[2] += _loc3_.Intellect;
                  _loc1_[3] += _loc3_.Physique;
               }
            }
         }
         return _loc1_;
      }
      
      public function getIdentityedAttriteds() : Array
      {
         var _loc6_:SkillTempInfo = null;
         var _loc5_:int = 0;
         var _loc1_:Array = [];
         var _loc3_:FashionInfoMsg = ArmyManager.instance.fashionInfoMsg;
         var _loc7_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc3_.grades,113);
         var _loc4_:String = _loc7_.TemplateName;
         var _loc2_:Array = TempleteManager.instance.getSkillTemplateInfoByIds(_loc4_);
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc6_ = _loc2_[_loc5_] as SkillTempInfo;
            if(_loc6_ && !_loc6_.BufferIds)
            {
               _loc1_ = _loc6_.TemplateName.split("<br>");
            }
            _loc5_++;
         }
         return _loc1_;
      }
      
      public function getBookNum(param1:int) : int
      {
         var _loc2_:Array = null;
         switch(param1)
         {
            case 0:
               _loc2_ = wingTems;
               break;
            case 1:
               _loc2_ = hatTems;
               break;
            case 2:
               _loc2_ = clothesTems;
               break;
            case 3:
               _loc2_ = weaponTems;
               break;
            default:
               _loc2_ = [];
         }
         var _loc4_:int = 0;
         for each(var _loc3_:GoodsTemplateInfo in _loc2_)
         {
            if(_loc3_.TemplateId in bookList)
            {
               _loc4_ += 1;
            }
         }
         return _loc4_;
      }
      
      public function getPolishInfoBySontype(param1:int) : FashionPolishInfo
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case 0:
               _loc2_ = 109;
               break;
            case 1:
               _loc2_ = 110;
               break;
            case 2:
               _loc2_ = 112;
               break;
            case 3:
               _loc2_ = 111;
         }
         var _loc4_:int = 0;
         for each(var _loc3_:FashionPolishInfo in polishList)
         {
            if(_loc3_.sonType == _loc2_)
            {
               return _loc3_;
            }
         }
         if(!_loc3_)
         {
            _loc3_ = new FashionPolishInfo();
            _loc3_.exp = 0;
            _loc3_.level = 0;
            _loc3_.level = _loc2_;
         }
         return _loc3_;
      }
      
      public function hasAllFashioonLevel(param1:int) : Boolean
      {
         var _loc3_:Boolean = false;
         if(polishList.length != 4)
         {
            return _loc3_;
         }
         var _loc4_:int = 0;
         for each(var _loc2_:FashionPolishInfo in polishList)
         {
            if(_loc2_.level < param1)
            {
               return false;
            }
         }
         return true;
      }
      
      public function getAllLevelAdd() : Array
      {
         var _loc11_:int = 0;
         var _loc14_:FashionPolishInfo = null;
         var _loc2_:FashionPolishTemplateInfo = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:Array = [0,1,2,3];
         var _loc13_:Array = [0,0,0,0,0,0];
         var _loc10_:Array = ["Attack","MagicAttack","Defence","MagicDefence","Live"];
         var _loc3_:Array = [];
         var _loc5_:int = 0;
         var _loc8_:int = ArmyManager.instance.fashionInfoMsg.grades;
         var _loc12_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc8_,113);
         if(!_loc12_)
         {
            return _loc13_;
         }
         var _loc9_:int = int(_loc12_.TemplateName.split(",")[1]);
         var _loc4_:SkillPropertyTempInfo = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc9_);
         if(!_loc4_)
         {
            return _loc13_;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc1_.length)
         {
            switch(_loc11_ = int(_loc1_[_loc6_]))
            {
               case 0:
                  _loc3_ = [0,1,2,3,4];
                  break;
               case 1:
                  _loc3_ = [4];
                  break;
               case 2:
                  _loc3_ = [2,3];
                  break;
               case 3:
                  _loc3_ = [0,1];
            }
            _loc14_ = getPolishInfoBySontype(_loc11_);
            if(_loc5_ >= _loc14_.level || _loc5_ == 0)
            {
               _loc5_ = _loc14_.level;
            }
            _loc2_ = getTemplatesByLevelAndPos(_loc14_.level,_loc14_.sonType);
            if(_loc2_)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc3_.length)
               {
                  var _loc15_:* = _loc3_[_loc7_];
                  var _loc16_:Number = _loc13_[_loc15_] + Math.floor(_loc2_.LevelAdd / 100 * _loc4_[_loc10_[_loc3_[_loc7_]]]);
                  _loc13_[_loc15_] = _loc16_;
                  _loc7_ += 1;
               }
            }
            _loc6_ += 1;
         }
         _loc5_ = Math.floor(_loc5_ / 10) * 10;
         _loc2_ = getTemplatesByLevelAndPos(_loc5_,109);
         if(_loc2_ && _loc2_.SpAdd > 0)
         {
            _loc13_[5] = _loc2_.SpAdd;
         }
         return _loc13_;
      }
      
      public function getAllSwitchAdd() : Array
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Array = [3,2,1,0];
         var _loc4_:Array = [0,0,0,0];
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = int(_loc1_[_loc3_]);
            _loc4_[_loc3_] = getItemByIndexSwitchAdd(_loc2_);
            _loc3_ += 1;
         }
         return _loc4_;
      }
      
      public function getItemByIndexSwitchAdd(param1:int) : Number
      {
         var _loc2_:FashionPolishTemplateInfo = null;
         var _loc6_:int = 0;
         var _loc7_:FashionPolishInfo = getPolishInfoBySontype(param1);
         var _loc4_:int = Math.floor(_loc7_.level / 10);
         var _loc5_:int = getBookNum(param1);
         var _loc3_:int = 0;
         _loc6_ = _loc4_;
         while(_loc6_ > 0)
         {
            _loc2_ = getTemplatesByLevelAndPos(_loc6_ * 10,_loc7_.sonType);
            if(_loc5_ >= _loc2_.NeedCount)
            {
               _loc3_ = _loc2_.AppraisalAdd;
               break;
            }
            _loc6_ -= 1;
         }
         return _loc3_;
      }
      
      public function getNextLevelAddBypos(param1:int) : Array
      {
         var _loc12_:Array = ["","","","","",""];
         var _loc11_:Array = ["Attack","MagicAttack","Defence","MagicDefence","Live"];
         var _loc2_:Array = [];
         switch(param1)
         {
            case 0:
               _loc2_ = [0,1,2,3,4];
               break;
            case 1:
               _loc2_ = [4];
               break;
            case 2:
               _loc2_ = [2,3];
               break;
            case 3:
               _loc2_ = [0,1];
         }
         var _loc14_:FashionPolishInfo = getPolishInfoBySontype(param1);
         var _loc6_:int = ArmyManager.instance.fashionInfoMsg.grades;
         var _loc13_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc6_,113);
         var _loc7_:int = int(_loc13_.TemplateName.split(",")[1]);
         var _loc3_:SkillPropertyTempInfo = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc7_);
         var _loc8_:FashionPolishTemplateInfo = getTemplatesByLevelAndPos(_loc14_.level,_loc14_.sonType);
         var _loc9_:FashionPolishTemplateInfo = getTemplatesByLevelAndPos(_loc14_.level + 1,_loc14_.sonType);
         var _loc4_:int = getBookNum(param1);
         var _loc10_:int = int(_loc2_.length);
         var _loc5_:int = 0;
         if(_loc9_ && _loc9_.LevelAdd > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc10_)
            {
               _loc12_[_loc2_[_loc5_]] = int((_loc9_.LevelAdd - _loc8_.LevelAdd) * _loc3_[_loc11_[_loc2_[_loc5_]]] / 100);
               _loc5_ += 1;
            }
         }
         if(_loc9_ && _loc9_.SpAdd > 0)
         {
            _loc12_[5] = String(_loc9_.SpAdd - _loc8_.SpAdd);
         }
         return _loc12_;
      }
      
      private function getTemplatesByLevelAndPos(param1:int, param2:int) : FashionPolishTemplateInfo
      {
         return TempleteManager.instance.fashionPolishTemplateCate.getTemplatesByLevelAndPos(param1,param2);
      }
   }
}

