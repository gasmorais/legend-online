package mvc.controler
{
   import bag.helper.GoodsCheck;
   import cell.view.storebag.StoreJewelCell;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.store.StoreRspMsg;
   import events.StoreEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.StoreSocketOutManager;
   import managers.TheseussoulManager;
   import mvc.FrameController;
   import mvc.ModuleFrameInfo;
   import mvc.module.avenger.AvengerModel;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.store.ComposeGoodsInfo;
   import mvc.module.store.StoreModel;
   import mvc.module.theseus.TheseussoulModel;
   import yishi.comm.PackageIn;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ComposeGoodsTemplete;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.AvengerManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.SimpleDictionary;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class StoreControler extends FrameController
   {
      
      public static const SKILL:String = "SKILL";
      
      private var _model:StoreModel;
      
      public var mountViewEquipIsBinds:Boolean;
      
      public var currComposeType:int = 0;
      
      private var _useBind:Boolean;
      
      private var _materialPayType:Boolean;
      
      private var _extendsMould:Boolean;
      
      private var _canComposeList:Vector.<ComposeGoodsInfo>;
      
      private var mountTypeDic:SimpleDictionary;
      
      private var _toOpenPos:int;
      
      private var _refreshLock:Boolean;
      
      private var _clcikLockFirst:Boolean;
      
      public function StoreControler()
      {
         super();
         _model = new StoreModel();
         _canComposeList = new Vector.<ComposeGoodsInfo>();
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override protected function showFrame() : void
      {
         super.showFrame();
         addEvent();
         _frame["show"](_data);
      }
      
      override public function get frameClassName() : String
      {
         var _loc1_:String = "store.MakeFrame";
         if(_data && _data.openType == "SKILL")
         {
            _loc1_ = "store.makeFrame.lifeskill";
         }
         return _loc1_;
      }
      
      override protected function exitFrame() : void
      {
         moveGoodsBack();
         removeEvent();
         super.exitFrame();
      }
      
      public function startFrameByType(param1:String, param2:Object = null) : void
      {
         initComposeInfo();
         _model.defalutPanel = param1;
         FrameControllerManager.instance.openControllerByInfo("store",null,param2);
      }
      
      private function initComposeInfo() : void
      {
         _model.allTemList.length = 0;
         _model.propertyTemList.length = 0;
         _model.equipTemList.length = 0;
         _model.gemTemList.length = 0;
         _model.revengeTemList.length = 0;
         _model.theseusTemList.length = 0;
         var _loc2_:Dictionary = TempleteManager.instance.getComposeTempleteList();
         for each(var _loc1_:ComposeGoodsTemplete in _loc2_)
         {
            addComposeToTemp(_loc1_);
         }
         _model.allTemList.sort(sortList);
         _model.propertyTemList.sort(sortList);
         _model.equipTemList.sort(sortList);
         _model.gemTemList.sort(sortList);
         _model.revengeTemList.sort(sortList);
         _model.theseusTemList.sort(sortList);
      }
      
      private function sortList(param1:ComposeGoodsInfo, param2:ComposeGoodsInfo) : int
      {
         var _loc4_:int = param1.template.NewMaterial;
         var _loc3_:int = param2.template.NewMaterial;
         if(_loc4_ > _loc3_)
         {
            return 1;
         }
         if(_loc4_ < _loc3_)
         {
            return -1;
         }
         return 0;
      }
      
      private function addComposeToTemp(param1:ComposeGoodsTemplete) : void
      {
         if(!checkOwn(param1))
         {
            return;
         }
         var _loc2_:ComposeGoodsInfo = new ComposeGoodsInfo();
         _loc2_.templateId = param1.Id;
         if(param1.Types == 1 || param1.Types == 5 || param1.Types == 9 || param1.Types == 20 || param1.Types == 13 || param1.Types == 17 || param1.Types == 18 && VersionSwitch.COMPOSE_TYPE_3TURN || param1.Types == 19 && VersionSwitch.COMPOSE_TYPE_3WENZHANG)
         {
            _model.equipTemList.push(_loc2_);
         }
         else if(param1.Types == 2)
         {
            _model.propertyTemList.push(_loc2_);
         }
         else if(param1.Types == 3 || param1.Types == 8 || param1.Types == 6 || param1.Types == 12)
         {
            _model.gemTemList.push(_loc2_);
         }
         else if(StoreModel.checkIsAvengerCompose(param1.Types))
         {
            _model.revengeTemList.push(_loc2_);
         }
         else if(StoreModel.checkIsTheseusCompose(param1.Types))
         {
            _model.theseusTemList.push(_loc2_);
         }
         if(_loc2_)
         {
            _model.allTemList.push(_loc2_);
         }
      }
      
      public function getComposeInfoByTemId(param1:int, param2:GoodsInfo) : ComposeGoodsInfo
      {
         var _loc3_:* = undefined;
         if(param2 == null)
         {
            return null;
         }
         switch(param1 - 1)
         {
            case 0:
               _loc3_ = _model.equipTemList;
               break;
            case 1:
               _loc3_ = _model.propertyTemList;
               break;
            case 2:
               _loc3_ = _model.gemTemList;
               break;
            case 3:
               _loc3_ = _model.revengeTemList;
               break;
            case 4:
               _loc3_ = _model.theseusTemList;
         }
         if(_loc3_)
         {
            for each(var _loc4_:ComposeGoodsInfo in _loc3_)
            {
               if(_loc4_.template.Material1 == param2.templateId)
               {
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      private function checkOwn(param1:ComposeGoodsTemplete) : Boolean
      {
         if(playerInfo.composeList.indexOf(param1.Id) >= 0)
         {
            return true;
         }
         return false;
      }
      
      private function addEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 89,__onComposeCallback);
      }
      
      private function removeEvent() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 89,__onComposeCallback);
      }
      
      private function __onComposeCallback(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:StoreRspMsg = new StoreRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as StoreRspMsg;
         model.composeComplete = true;
      }
      
      public function openHelpFrame() : void
      {
         var _loc1_:SimpleHelpFrame = null;
         switch(model.selectedPanel)
         {
            case "STORE_PANEL_INTENSIFY":
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("core.StoreHelpFrame_1");
               break;
            case "STORE_PANEL_MOUNT":
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("core.StoreHelpFrame_2");
               break;
            case "STORE_PANEL_COMPOSE":
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("core.StoreHelpFrame_3_" + currComposeType);
               break;
            case "STORE_PANEL_REFRESH":
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("core.StoreHelpFrame_4");
               break;
            case "STORE_PANEL_RESOLVE":
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("core.StoreHelpFrame_5");
               break;
            case "STORE_PANEL_SWITCH":
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("core.StoreHelpFrame_6");
               break;
            case "STORE_PANEL_CAST":
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("core.StoreHelpFrame_7");
               break;
            case "STORE_PANEL_ENCHANT":
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("core.StoreHelpFrame_8");
         }
         _loc1_.show();
      }
      
      public function mountJewel(param1:GoodsInfo, param2:StoreJewelCell) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(checkType(param1,param2.pos) == -1)
         {
            return;
         }
         if(param2.data && param2.data.templateInfo)
         {
            SimpleAlertHelper.instance.data = [__mountCallBack,param1,param2];
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("store.StoreControler.content",param2.data.templateInfo.Property3);
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc3_,_loc4_);
         }
         else
         {
            sendItemMount(param2.pos,param1.pos,param1.bagType);
         }
      }
      
      private function __mountCallBack(param1:Boolean, param2:Boolean, param3:GoodsInfo, param4:StoreJewelCell) : void
      {
         var _loc5_:String = null;
         if(param1)
         {
            if(param4.data.templateInfo.Property3 > ResourceManager.instance.gold.count)
            {
               _loc5_ = LanguageMgr.GetTranslation("public.gold");
               MessageTipManager.instance().show(_loc5_);
               return;
            }
            SoundManager.instance.play("023",true);
            sendItemMount(param4.pos,param3.pos,param3.bagType);
         }
      }
      
      private function checkType(param1:GoodsInfo, param2:int) : int
      {
         var _loc5_:GoodsTemplateInfo = null;
         var _loc3_:String = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc4_:GoodsInfo = GoodsManager.instance.getHideBagItemByPos(0);
         if(_loc4_)
         {
            mountTypeDic = new SimpleDictionary();
            _loc6_ = -1;
            if(param1.templateInfo.SonType == 205)
            {
               _loc7_ = param1.templateInfo.Property1;
               mountTypeDic[_loc7_] = 1;
            }
            else if(param1.templateInfo.SonType == 228)
            {
               _loc7_ = param1.templateInfo.Property1;
               mountTypeDic[_loc7_] = 1;
               _loc7_ = param1.templateInfo.Property2;
               mountTypeDic[_loc7_] = 1;
            }
            _loc8_ = 1;
            while(_loc8_ < 4 + 1)
            {
               if(_loc4_["join" + _loc8_] > 0)
               {
                  _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(int(_loc4_["join" + _loc8_]));
                  if(param1.templateInfo.SonType == 205 || param1.templateInfo.SonType == 228)
                  {
                     if(_loc5_.SonType == param1.templateInfo.SonType)
                     {
                        if(_loc5_.SonType == 205 && _loc5_.Property1 == param1.templateInfo.Property1)
                        {
                           if(_loc8_ != param2)
                           {
                              _loc3_ = LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.command03");
                              MessageTipManager.instance().show(_loc3_);
                              return -1;
                           }
                           return 1;
                        }
                        if(_loc5_.SonType == 228 && _loc5_.Property1 == param1.templateInfo.Property1 && _loc5_.Property2 == param1.templateInfo.Property2)
                        {
                           if(_loc8_ != param2)
                           {
                              _loc3_ = LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.command03");
                              MessageTipManager.instance().show(_loc3_);
                              return -1;
                           }
                           return 1;
                        }
                     }
                  }
               }
               _loc8_++;
            }
            if(_loc6_ != -1)
            {
               _loc3_ = LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.command09",getJewelPropertyName(_loc6_));
               MessageTipManager.instance().show(_loc3_);
               return -1;
            }
            return 1;
         }
         return 0;
      }
      
      public function getJewelPropertyName(param1:int) : String
      {
         switch(param1 - 1)
         {
            case 0:
               return LanguageMgr.GetTranslation("public.jewel.AttackProperty");
            case 1:
               return LanguageMgr.GetTranslation("public.jewel.DefenceProperty");
            case 2:
               return LanguageMgr.GetTranslation("public.jewel.MagicAttackProperty");
            case 3:
               return LanguageMgr.GetTranslation("public.jewel.MagicDefenceProperty");
            case 4:
               return LanguageMgr.GetTranslation("public.jewel.ForceHitProperty");
            case 5:
               return LanguageMgr.GetTranslation("public.jewel.LiveProperty");
            case 6:
               return LanguageMgr.GetTranslation("public.jewel.ConatProperty");
            case 7:
               return LanguageMgr.GetTranslation("public.jewel.ParryProperty");
            default:
               return "";
         }
      }
      
      public function openHole(param1:int) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc5_:String = null;
         _toOpenPos = param1;
         var _loc2_:Array = GoodsManager.instance.getGoodsByGoodsTId(208004);
         var _loc6_:Boolean = false;
         for each(var _loc7_:GoodsInfo in _loc2_)
         {
            if(_loc7_.bagType == 1 || _loc7_.bagType == 6)
            {
               _loc6_ = true;
               break;
            }
         }
         if(_loc6_)
         {
            SimpleAlertHelper.instance.data = [confirmback];
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc8_ = LanguageMgr.GetTranslation("public.prompt");
            _loc9_ = LanguageMgr.GetTranslation("store.StoreControler.content02");
            SimpleAlertHelper.instance.popAlerFrame(_loc8_,_loc9_,_loc3_,_loc4_);
         }
         else
         {
            _loc5_ = LanguageMgr.GetTranslation("store.StoreControler.command01");
            MessageTipManager.instance().show(_loc5_);
            CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
         }
      }
      
      private function quickUIcallback() : void
      {
         var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         var _loc2_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(208004);
         _loc1_.data(_loc2_);
         _loc1_.show();
         _loc1_.callback = shopBuyBack;
      }
      
      override public function start(param1:ModuleFrameInfo = null) : void
      {
         super.start(param1);
      }
      
      private function confirmback(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendPunch(_toOpenPos,true,param2);
         }
      }
      
      private function shopBuyBack(param1:Boolean, param2:Object = null) : void
      {
         if(param1)
         {
            SocketSendManager.instance.sendPunch(_toOpenPos,true);
         }
      }
      
      public function moveGoodsBack() : void
      {
         var _loc1_:Array = GoodsManager.instance.getGoodsByBagType(0);
         for each(var _loc2_:GoodsInfo in _loc1_)
         {
            PlayerManager.instance.moveBagToBag(_loc2_.bagType,_loc2_.objectId,_loc2_.pos,1,0,0,1);
         }
      }
      
      public function sendItemMount(param1:int, param2:int, param3:int) : void
      {
         inlayConfirm(true,false,param1,param2,param3);
      }
      
      private function inlayConfirm(param1:Boolean, param2:Boolean, param3:int, param4:int, param5:int) : void
      {
         if(param1)
         {
            StoreSocketOutManager.sendItemMount(param3,param4,param5);
         }
      }
      
      public function sendItemIntensify(param1:int = 0) : void
      {
         StoreSocketOutManager.sendItemIntensify(param1);
      }
      
      public function sendItemMould(param1:int = 0) : void
      {
         StoreSocketOutManager.sendItemMould(param1);
      }
      
      public function sendCompose(param1:Boolean, param2:Boolean = false) : void
      {
         if(showAlert(startAlertBack))
         {
            return;
         }
         if(_model.selectedCompose.template.Types == 5)
         {
            if(_model.getCurrentUpgradeEquipGoodsInfo())
            {
               StoreSocketOutManager.sendUpdateEquip(_model.selectedCompose.templateId,1,param1,param2);
            }
         }
         else
         {
            StoreSocketOutManager.sendCompose(_model.selectedCompose.template.Id,_model.currentComposeCount,_model.autoBuy,param1,param2);
         }
      }
      
      private function showAlert(param1:Function = null) : Boolean
      {
         var _loc3_:Date = SharedManager.instance.storeComposeCheckDate;
         var _loc4_:Date = new Date();
         return false;
      }
      
      private function startAlertBack(param1:Boolean) : void
      {
         SharedManager.instance.storeCompose = param1;
         SharedManager.instance.storeComposeCheckDate = new Date();
         SharedManager.instance.saveComposeTipCheck();
         if(_model.selectedCompose.template.Types == 5)
         {
            if(_model.getCurrentUpgradeEquipGoodsInfo())
            {
               StoreSocketOutManager.sendUpdateEquip(_model.selectedCompose.templateId,1,useBind,extendsMould);
            }
         }
         else
         {
            StoreSocketOutManager.sendCompose(_model.selectedCompose.template.Id,_model.currentComposeCount,_model.autoBuy,useBind,extendsMould);
         }
         if(model)
         {
            model.dispatchEvent(new StoreEvent("UPDATE_COMPOSE_MAX_COUNT"));
         }
         StageReferance.stage.focus = _frame;
      }
      
      private function cancelBack() : void
      {
         if(model)
         {
            model.dispatchEvent(new StoreEvent("UPDATE_COMPOSE_MAX_COUNT"));
         }
         StageReferance.stage.focus = _frame;
      }
      
      private function calcGoodNumber() : void
      {
         _model.goodsNumList.clear();
         var _loc2_:SimpleDictionary = GoodsManager.instance.getHeroEquipBagAndPlayerBagList();
         for each(var _loc1_:GoodsInfo in _loc2_)
         {
            if(_model.goodsNumList[_loc1_.templateId])
            {
               _model.goodsNumList[_loc1_.templateId] = int(_model.goodsNumList[_loc1_.templateId]) + _loc1_.count;
            }
            else
            {
               _model.goodsNumList[_loc1_.templateId] = _loc1_.count;
            }
         }
      }
      
      public function initComposeGoodsCount() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc10_:GoodsInfo = null;
         var _loc11_:int = 0;
         var _loc7_:Array = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:Array = null;
         var _loc9_:GoodsTemplateInfo = null;
         _model.currentComposeCount = 0;
         _model.canComposeEquipList.length = 0;
         calcGoodNumber();
         for each(var _loc12_:ComposeGoodsInfo in model.allTemList)
         {
            _loc2_ = 1;
            while(_loc2_ <= 4)
            {
               _loc3_ = 0;
               _loc1_ = 0;
               _loc5_ = 0;
               if(StoreModel.checkIsAvengerCompose(_loc12_.template.Types))
               {
                  _loc3_ = int(_loc12_.template["Material" + _loc2_]);
                  if(_loc3_ > 0)
                  {
                     _loc5_ = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_loc3_);
                     if(avengerModel.armorBagDic[_loc3_])
                     {
                        _loc1_ = int(avengerModel.armorBagDic[_loc3_].count);
                     }
                     _loc12_["ownCount" + _loc2_] = _loc1_ + _loc5_;
                  }
                  else
                  {
                     _loc12_["ownCount" + _loc2_] = 0;
                  }
               }
               else if(StoreModel.checkIsTheseusCompose(_loc12_.template.Types))
               {
                  _loc3_ = int(_loc12_.template["Material" + _loc2_]);
                  if(_loc3_ > 0)
                  {
                     _loc5_ = GoodsManager.instance.getBagCountByTempId(1,_loc3_);
                     if(theseussoulModel.armorBagDic[_loc3_])
                     {
                        _loc1_ = int(theseussoulModel.armorBagDic[_loc3_].count);
                     }
                     _loc10_ = new GoodsInfo();
                     _loc10_.templateId = _loc3_;
                     _loc11_ = 0;
                     if(_loc10_.templateInfo && _loc10_.templateInfo.SonType == 761)
                     {
                        _loc5_ += GoodsManager.instance.getBagCountByTempId(34,_loc3_);
                     }
                     if(_loc10_.templateInfo && _loc10_.templateInfo.SonType == 720)
                     {
                        _loc7_ = theseussoulModel.suitInfo.getSuitArray(_loc10_.templateInfo.Property1);
                        _loc8_ = 0;
                        if(_loc7_ && _loc7_.length > 0)
                        {
                           _loc6_ = 0;
                           while(_loc6_ < _loc7_.length)
                           {
                              _loc8_ = int(_loc7_[_loc6_]);
                              if(_loc8_ == _loc3_)
                              {
                                 _loc11_++;
                              }
                              _loc6_++;
                           }
                        }
                     }
                     _loc4_ = [361,362,363,364,365,366,367,368,369];
                     if(_loc4_.indexOf(_loc12_.template.Types) != -1)
                     {
                        _loc5_ = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(_loc3_);
                     }
                     _loc12_["ownCount" + _loc2_] = _loc1_ + _loc5_ + _loc11_;
                     if(StoreModel.checkIsTheseusWarCompose(_loc12_.template.Types))
                     {
                        _loc12_["ownCount" + _loc2_] = GoodsManager.instance.getGoodsNumByTempIdAndNotLock(_loc12_.template["Material" + _loc2_]);
                     }
                  }
                  else
                  {
                     _loc12_["ownCount" + _loc2_] = 0;
                  }
               }
               else
               {
                  _loc12_["ownCount" + _loc2_] = _loc12_.template["Material" + _loc2_] ? getNumByTempId(_loc12_.template["Material" + _loc2_]) : -1;
               }
               _loc2_++;
            }
            _loc12_.canMakeCount = _loc12_.getCanMakeCount();
            if(_loc12_.canMakeCount && checkCanEquip(_loc12_) && (_loc12_.template.Types == 1 || _loc12_.template.Types == 5))
            {
               model.canComposeEquipList.push(_loc12_);
            }
            if(!thane.isChangeJob)
            {
               _loc9_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc12_.template.NewMaterial);
               if(_loc9_ && _loc9_.NeedChangeJob == 1)
               {
                  _loc12_.canMakeCount = 0;
               }
            }
            if(!thane.isAvenger)
            {
               _loc9_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc12_.template.NewMaterial);
               if(_loc9_ && _loc9_.NeedChangeJob == 2)
               {
                  _loc12_.canMakeCount = 0;
               }
            }
         }
      }
      
      private function checkCanEquip(param1:ComposeGoodsInfo) : Boolean
      {
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.template.NewMaterial);
         if(!_loc2_)
         {
            return false;
         }
         if(thane.grades >= 80)
         {
            if(!_loc2_.NeedChangeJob)
            {
               return true;
            }
            if(_loc2_.NeedChangeJob == 1)
            {
               return playerInfo.vocationGrades > 0;
            }
            return playerInfo.vocationIndex >= 3;
         }
         return thane.grades >= _loc2_.NeedGrades;
      }
      
      public function get checkHasBetterAlert() : Boolean
      {
         var _loc3_:GoodsTemplateInfo = null;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc2_:int = 0;
         initComposeInfo();
         initComposeGoodsCount();
         var _loc1_:Array = [101,102,103,104,105,106,107,108,117,118];
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc4_ = getHeroEquipTempBySontype(_loc1_[_loc2_]);
            for each(var _loc5_:ComposeGoodsInfo in model.canComposeEquipList)
            {
               _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_.template.NewMaterial);
               if(_loc3_.NeedGrades >= thane.grades - 10)
               {
                  if(!_loc4_)
                  {
                     if(_loc3_.SonType == _loc1_[_loc2_])
                     {
                        return true;
                     }
                  }
                  else if(_loc3_.SonType == _loc4_.SonType && (_loc3_.NeedGrades > _loc4_.NeedGrades || _loc3_.Profile > _loc4_.Profile))
                  {
                     return true;
                  }
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      private function getHeroEquipTempBySontype(param1:int) : GoodsTemplateInfo
      {
         var _loc2_:SimpleDictionary = GoodsManager.instance.getHeroGoodsListByTypeAndId(1,thane.id);
         for each(var _loc3_:GoodsInfo in _loc2_)
         {
            if(_loc3_.templateInfo.SonType == param1)
            {
               return _loc3_.templateInfo;
            }
         }
         return null;
      }
      
      private function getNumByTempId(param1:int) : int
      {
         if(_model.goodsNumList[param1])
         {
            return int(_model.goodsNumList[param1]);
         }
         return 0;
      }
      
      public function setComposeCount(param1:int, param2:Boolean) : void
      {
         if(param1 == 0)
         {
            return;
         }
         if(_model.selectedCompose)
         {
            switch(param1 - 1)
            {
               case 0:
                  if(_model.currentComposeCount > 1)
                  {
                     _model.currentComposeCount = 1;
                  }
                  break;
               case 1:
                  if(_model.currentComposeCount > 1)
                  {
                     _model.currentComposeCount--;
                  }
                  break;
               case 2:
                  if(_model.currentComposeCount < _model.selectedCompose.canMakeCount && !param2)
                  {
                     _model.currentComposeCount++;
                  }
                  else if(param2 && _model.currentComposeCount < 9)
                  {
                     _model.currentComposeCount++;
                  }
                  break;
               case 3:
                  if(_model.currentComposeCount < _model.selectedCompose.canMakeCount && !param2)
                  {
                     _model.currentComposeCount = _model.selectedCompose.canMakeCount;
                     break;
                  }
                  if(param2 && _model.currentComposeCount < 9)
                  {
                     _model.currentComposeCount = 9;
                  }
            }
         }
      }
      
      public function composeNumTxtChangeHandler(param1:int, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(model.selectedCompose)
         {
            if(param2)
            {
               if(param1 > 9)
               {
                  param1 = 9;
               }
            }
            else
            {
               _loc3_ = _model.selectedCompose.canMakeCount;
               if(param1 > _loc3_)
               {
                  param1 = _loc3_;
               }
            }
         }
         _model.currentComposeCount = param1;
      }
      
      public function get model() : StoreModel
      {
         return _model;
      }
      
      public function get refreshLock() : Boolean
      {
         return _refreshLock;
      }
      
      public function set refreshLock(param1:Boolean) : void
      {
         _refreshLock = param1;
      }
      
      public function get clcikLockFirst() : Boolean
      {
         return _clcikLockFirst;
      }
      
      public function set clcikLockFirst(param1:Boolean) : void
      {
         _clcikLockFirst = param1;
      }
      
      public function get useBind() : Boolean
      {
         return _useBind;
      }
      
      public function set useBind(param1:Boolean) : void
      {
         _useBind = param1;
      }
      
      public function get materialPayType() : Boolean
      {
         return _materialPayType;
      }
      
      public function set materialPayType(param1:Boolean) : void
      {
         _materialPayType = param1;
      }
      
      public function get extendsMould() : Boolean
      {
         return _extendsMould;
      }
      
      public function set extendsMould(param1:Boolean) : void
      {
         _extendsMould = param1;
      }
      
      public function get frame() : Frame
      {
         return _frame;
      }
      
      public function getGoodsPosForRelove(param1:GoodsInfo) : int
      {
         var _loc2_:String = null;
         var _loc4_:GoodsTemplateInfo = param1.templateInfo;
         var _loc3_:int = -1;
         if(_loc4_.MasterType == 2 && _loc4_.SonType == 626)
         {
            _loc3_ = getEmptyPos();
         }
         else if(!(_loc4_.MasterType == 1 || _loc4_.SonType == 218 || _loc4_.SonType == 228 || _loc4_.SonType == 343 || _loc4_.SonType == 344 || _loc4_.MasterType == 11))
         {
            _loc2_ = LanguageMgr.GetTranslation("cell.mediator.storebag.IntensifyBagCellDropMediator.command01");
            _loc3_ = -2;
         }
         else if(_loc4_.MasterType == 1 && param1.existJewel())
         {
            _loc2_ = LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.command01");
            MessageTipManager.instance().show(_loc2_);
            _loc3_ = -1;
         }
         else if(_loc4_.Refresh == -1)
         {
            _loc2_ = LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.command05");
            _loc3_ = -2;
         }
         else
         {
            _loc3_ = getEmptyPos();
            if(_loc3_ == -1)
            {
               _loc2_ = LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.command02");
            }
         }
         if(_loc2_)
         {
            MessageTipManager.instance().show(_loc2_);
         }
         return _loc3_;
      }
      
      private function getEmptyPos() : int
      {
         var _loc2_:int = 0;
         var _loc3_:GoodsInfo = null;
         var _loc1_:* = -1;
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc3_ = GoodsManager.instance.getHideBagItemByPos(_loc2_);
            if(_loc3_ == null)
            {
               _loc1_ = _loc2_;
               break;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function checkSelectResolveItemValid(param1:GoodsInfo) : Boolean
      {
         var _loc4_:GoodsInfo = null;
         var _loc2_:Boolean = true;
         var _loc5_:uint = 12;
         var _loc3_:int = 0;
         if(param1.templateInfo.SonType == 228 || param1.templateInfo.SonType == 343 || param1.templateInfo.SonType == 344)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc4_ = GoodsManager.instance.getHideBagItemByPos(_loc3_);
               if(_loc4_ != null && _loc4_.templateId != param1.templateId)
               {
                  _loc2_ = false;
                  break;
               }
               _loc3_++;
            }
         }
         else if(param1.templateInfo.SonType == 626)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc4_ = GoodsManager.instance.getHideBagItemByPos(_loc3_);
               if(_loc4_ != null && _loc4_.templateId != param1.templateId)
               {
                  if(_loc4_.templateInfo.SonType == 228 || _loc4_.templateInfo.SonType == 343 || _loc4_.templateInfo.SonType == 344)
                  {
                     _loc2_ = false;
                     break;
                  }
               }
               _loc3_++;
            }
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               _loc4_ = GoodsManager.instance.getHideBagItemByPos(_loc3_);
               if(_loc4_ != null)
               {
                  if(_loc4_.templateInfo.SonType == 228 || _loc4_.templateInfo.SonType == 343 || _loc4_.templateInfo.SonType == 344)
                  {
                     _loc2_ = false;
                     break;
                  }
               }
               _loc3_++;
            }
         }
         if(!_loc2_)
         {
            if(param1.templateInfo.SonType == 228)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("mvc.controler.StoreControler.resovleSelectTip01"));
            }
            if(param1.templateInfo.SonType >= 101 && param1.templateInfo.SonType <= 108)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("mvc.controler.StoreControler.resovleSelectTip02"));
            }
            if(param1.templateInfo.SonType == 343 || param1.templateInfo.SonType == 344)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("mvc.controler.StoreControler.resovleSelectTip03"));
            }
            if(param1.templateInfo.SonType == 626)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("mvc.controler.StoreControler.resovleSelectTip04"));
            }
         }
         return _loc2_;
      }
      
      public function showResolveAlertForMountCard(param1:Function, param2:Function = null) : void
      {
         var backFun:Function;
         var frame:TodayNotAlertFrame;
         var content:String;
         var checkTxt:String;
         var callBack:Function = param1;
         var closeFun:Function = param2;
         if(SharedManager.instance.showResolveAlertForMountCard)
         {
            callBack();
            return;
         }
         backFun = function(param1:Boolean):void
         {
            if(param1)
            {
               SharedManager.instance.showResolveAlertForMountCard = true;
            }
            callBack();
         };
         frame = ComponentFactory.Instance.creatComponentByStylename("store.ComposeTipFrame2");
         content = LanguageMgr.GetTranslation("storeControler.showResolveAlertForMountCard");
         checkTxt = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         frame.show(content,checkTxt,backFun,closeFun,"center",1,true);
      }
      
      public function showResolveAlertForFashion(param1:Function, param2:Function = null) : void
      {
         var backFun:Function;
         var frame:TodayNotAlertFrame;
         var content:String;
         var checkTxt:String;
         var callBack:Function = param1;
         var closeFun:Function = param2;
         if(SharedManager.instance.showResolveAlertForFashion)
         {
            callBack();
            return;
         }
         backFun = function(param1:Boolean):void
         {
            if(param1)
            {
               SharedManager.instance.showResolveAlertForFashion = true;
            }
            callBack();
         };
         frame = ComponentFactory.Instance.creatComponentByStylename("store.ComposeTipFrame2");
         content = LanguageMgr.GetTranslation("storeControler.showResolveAlertForFashion");
         checkTxt = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         frame.show(content,checkTxt,backFun,closeFun,"center",1,true);
      }
      
      public function showResolveAlert(param1:Function, param2:Function = null) : void
      {
         var backFun:Function;
         var frame:TodayNotAlertFrame;
         var content:String;
         var checkTxt:String;
         var callBack:Function = param1;
         var closeFun:Function = param2;
         if(SharedManager.instance.resolveStrengthen)
         {
            callBack();
            return;
         }
         backFun = function(param1:Boolean):void
         {
            if(param1)
            {
               SharedManager.instance.resolveStrengthen = true;
            }
            callBack();
         };
         frame = ComponentFactory.Instance.creatComponentByStylename("store.ComposeTipFrame");
         content = LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.resolveStrengthenAlert");
         checkTxt = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         frame.show(content,checkTxt,backFun,closeFun);
      }
      
      public function showResolveAlertForTreasure(param1:Function, param2:Function = null) : void
      {
         var backFun:Function;
         var frame:TodayNotAlertFrame;
         var content:String;
         var checkTxt:String;
         var callBack:Function = param1;
         var closeFun:Function = param2;
         if(SharedManager.instance.resolveStrengthen)
         {
            callBack();
            return;
         }
         backFun = function(param1:Boolean):void
         {
            if(param1)
            {
               SharedManager.instance.resolveStrengthen = true;
            }
            callBack();
         };
         frame = ComponentFactory.Instance.creatComponentByStylename("store.ComposeTipFrame");
         content = LanguageMgr.GetTranslation("cell.mediator.storebag.treasure.command02");
         checkTxt = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         frame.show(content,checkTxt,backFun,closeFun);
      }
      
      public function canShowForReslove(param1:GoodsInfo) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1.templateInfo.SonType == 215 || param1.templateInfo.SonType == 228 || param1.templateInfo.SonType == 205 || param1.templateId == 2120043 || param1.templateInfo.SonType == 343 || param1.templateInfo.SonType == 344)
         {
            _loc2_ = true;
         }
         if(param1.templateInfo.MasterType == 1 && param1.templateInfo.Profile < 6 && param1.templateInfo.Refresh != 0 && param1.objectId != ArmyManager.instance.thane.id)
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
      
      public function canReslove(param1:GoodsInfo) : Boolean
      {
         var _loc2_:GoodsTemplateInfo = param1.templateInfo;
         if(_loc2_.SonType == 218 || GoodsCheck.isFashion(_loc2_))
         {
            return _loc2_.Refresh != -1;
         }
         if(_loc2_.MasterType == 1 && _loc2_.Refresh != 0 && param1.objectId != ArmyManager.instance.thane.id)
         {
            return true;
         }
         if(_loc2_.MasterType == 11 && _loc2_.Refresh != 0 && param1.objectId != ArmyManager.instance.thane.id)
         {
            return true;
         }
         return false;
      }
      
      private function get avengerModel() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      private function get theseussoulModel() : TheseussoulModel
      {
         return TheseussoulManager.Instance.model;
      }
   }
}

