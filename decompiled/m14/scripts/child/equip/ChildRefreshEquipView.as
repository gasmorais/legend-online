package child.equip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.store.RefreshPropertyRepMsg;
   import com.road.yishi.proto.store.SmithFreshRspMsg;
   import events.StoreEvent;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.StoreSocketOutManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import mvc.module.shop.ShopGoodsInfo;
   import utils.LogicUtils;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildRefreshEquipView extends Component
   {
      
      private var _equipBag:ChildEquipBagView;
      
      private var _bg:MutipleImage;
      
      private var _item:ChildBagCell;
      
      private var _effectBack:MovieImage;
      
      private var _jewel:BaseItemView;
      
      private var _countTxt:FilterFrameText;
      
      private var _needTxt:FilterFrameText;
      
      private var _refreshBtn:IconButton;
      
      private var _replaceBtn:BaseButton;
      
      private var _nameTxt1:FilterFrameText;
      
      private var _nameTxt2:FilterFrameText;
      
      private var _attList:Array;
      
      private var _attNameDic:Dictionary;
      
      private var _itemVbox:VBox;
      
      private var _itemList:Vector.<ChildRefreshAttItem>;
      
      private var _lockCount:int;
      
      private var _lockArr:Array;
      
      private var lockPoint:int;
      
      private var _shopGoodsInfo:ShopGoodsInfo;
      
      private var _needPoint:int;
      
      private var _hasMaterialCount:int;
      
      private var _time:Number;
      
      public function ChildRefreshEquipView()
      {
         super();
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         _attList = ["Power","Agility","Intellect","Physique","Attack","Defence","MagicAttack","MagicDefence","ForceHit","Live","Conat","Parry","Penetrate","StunAttr"];
         _attNameDic = new Dictionary();
         _attNameDic["Power"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01");
         _attNameDic["Agility"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02");
         _attNameDic["Intellect"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03");
         _attNameDic["Physique"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04");
         _attNameDic["Attack"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip13");
         _attNameDic["Defence"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip14");
         _attNameDic["MagicAttack"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip15");
         _attNameDic["MagicDefence"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip16");
         _attNameDic["ForceHit"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10");
         _attNameDic["Live"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
         _attNameDic["Conat"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip17");
         _attNameDic["Parry"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19");
         _attNameDic["Penetrate"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
         _attNameDic["StunAttr"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip27");
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildRefreshEquipView.bg");
         _item = ComponentFactory.Instance.creatCustomObject("ChildIntensifyEquipView.item",[true]);
         _jewel = ComponentFactory.Instance.creatCustomObject("ChildIntensifyEquipView.jewel");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.countTxt");
         _needTxt = ComponentFactory.Instance.creatComponentByStylename("ChildRefreshEquipView.needTxt");
         _replaceBtn = ComponentFactory.Instance.creatComponentByStylename("ChildRefreshEquipView.replaceBtn");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("ChildRefreshEquipView.refreshBtn");
         _nameTxt1 = ComponentFactory.Instance.creatComponentByStylename("ChildRefreshEquipView.nameTxt1");
         _nameTxt2 = ComponentFactory.Instance.creatComponentByStylename("ChildRefreshEquipView.nameTxt2");
         _itemVbox = ComponentFactory.Instance.creatComponentByStylename("ChildRefreshEquipView.itemVbox");
         _effectBack = ComponentFactory.Instance.creatComponentByStylename("ChildIntensifyEquipView.EquipSelectedEff");
         _effectBack.mouseChildren = _effectBack.mouseEnabled = false;
         _effectBack.movie.stop();
         _effectBack.visible = false;
         _equipBag = new ChildEquipBagView(2,11);
         _itemList = new Vector.<ChildRefreshAttItem>();
         addChild(_bg);
         addChild(_item);
         addChild(_effectBack);
         addChild(_jewel);
         addChild(_countTxt);
         addChild(_needTxt);
         addChild(_replaceBtn);
         addChild(_refreshBtn);
         addChild(_nameTxt1);
         addChild(_nameTxt2);
         addChild(_itemVbox);
         addChild(_equipBag);
         lockPoint = int(TempleteManager.instance.getConfigInfoByConfigName("Lock_Point").ConfigValue);
         _refreshBtn.tipData = LanguageMgr.GetTranslation("store.view.refresh.RefreshView.refreshAttributeBtn");
         _item.bagType = 29;
         _item.celltType = "CELL_HIDE";
         _equipBag.x = 6;
         _equipBag.y = 306;
         _lockArr = [];
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _lockArr.push(false);
            _loc1_++;
         }
         refreshView();
      }
      
      private function initEvent() : void
      {
         if(_refreshBtn)
         {
            _refreshBtn.addEventListener("click",_refreshHandler);
         }
         if(_replaceBtn)
         {
            _replaceBtn.addEventListener("click",_replaceHandler);
         }
         MsgMan.addObserver("ChildEvent.HIDE_CHANGE",this,__bagItemUpdateHandler);
         MsgMan.addObserver("ChildEvent.START_DROP",this,__startDropHandler);
         MsgMan.addObserver("ChildEvent.END_DROP",this,__endDropHandler);
         NotificationManager.instance.addEventListener("REFRESH_LOCK_CHANGE",_itemLockHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4258,__refreshSkillHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4368,__refreshProperty);
      }
      
      private function removeEvent() : void
      {
         if(_refreshBtn)
         {
            _refreshBtn.removeEventListener("click",_refreshHandler);
         }
         if(_replaceBtn)
         {
            _replaceBtn.removeEventListener("click",_replaceHandler);
         }
         MsgMan.removeObserver("ChildEvent.HIDE_CHANGE",this,__bagItemUpdateHandler);
         MsgMan.removeObserver("ChildEvent.START_DROP",this,__startDropHandler);
         MsgMan.removeObserver("ChildEvent.END_DROP",this,__endDropHandler);
         NotificationManager.instance.removeEventListener("REFRESH_LOCK_CHANGE",_itemLockHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4258,__refreshSkillHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4368,__refreshProperty);
      }
      
      private function __refreshSkillHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:ChildRefreshAttItem = null;
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:SmithFreshRspMsg = new SmithFreshRspMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as SmithFreshRspMsg;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.randomSkill.length)
         {
            if(_loc4_ >= _itemList.length)
            {
               _loc3_ = new ChildRefreshAttItem();
               _loc3_.selected = false;
               _loc3_.randomSkill = model.hideGoods["randomSkill" + (_loc4_ + 1)];
               _loc3_.randomNewSkill = -1;
               _itemVbox.addChild(_loc3_);
               _itemList.push(_loc3_);
            }
            _itemList[_loc4_].randomNewSkill = _loc2_.randomSkill[_loc4_];
            _loc4_++;
         }
         _replaceBtn.enable = true;
         _nameTxt2.visible = true;
      }
      
      private function __refreshProperty(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:ChildRefreshAttItem = null;
         if(model.hideGoods == null)
         {
            return;
         }
         var _loc5_:PackageIn = param1.data as PackageIn;
         var _loc2_:RefreshPropertyRepMsg = new RefreshPropertyRepMsg();
         _loc2_ = _loc5_.readBody(_loc2_) as RefreshPropertyRepMsg;
         if(_loc2_.result == 1)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_.randomSkill.length)
            {
               if(_loc4_ >= _itemList.length)
               {
                  _loc3_ = new ChildRefreshAttItem();
                  _loc3_.selected = false;
                  _loc3_.randomSkill = model.hideGoods["randomSkill" + (_loc4_ + 1)];
                  _loc3_.randomNewSkill = -1;
                  _itemVbox.addChild(_loc3_);
                  _itemList.push(_loc3_);
               }
               _itemList[_loc4_].randomNewSkill = _loc2_.randomSkill[_loc4_];
               _itemList[_loc4_].selected = _loc2_.lockPos[_loc4_];
               if(TempleteManager.instance.getSkillTemplateInfoById(_loc2_.randomSkill[_loc4_]))
               {
                  _replaceBtn.enable = true;
                  _nameTxt2.visible = true;
               }
               _loc4_++;
            }
         }
         _refreshBtn.enable = true;
         _itemLockHandler(null);
      }
      
      private function refreshView() : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:ChildRefreshAttItem = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         clean();
         if(model.hideGoods)
         {
            _item.data = model.hideGoods;
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = model.hideGoods.templateInfo.Refresh;
            _jewel.data = _loc5_;
            _countTxt.text = GoodsManager.instance.getBagCountByTempId(1,_loc5_.templateId) + "/" + getNeedCountProfile(model.hideGoods.templateInfo.Profile);
            _nameTxt1.text = _nameTxt2.text = model.hideGoods.templateInfo.TemplateName;
            _shopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(_loc5_.templateId);
            _needPoint = _lockCount * lockPoint;
            _loc2_ = getNeedCountProfile(model.hideGoods.templateInfo.Profile);
            _hasMaterialCount = GoodsManager.instance.getBagCountByTempId(1,model.hideGoods.templateInfo.Refresh);
            _loc4_ = _loc2_ - _hasMaterialCount;
            if(_loc4_ < 0)
            {
               _loc4_ = 0;
            }
            if(_shopGoodsInfo)
            {
               _needPoint += _shopGoodsInfo.price * _loc4_;
            }
            if(model.hideGoods.templateInfo.Profile >= 1 && model.hideGoods.templateInfo.Profile <= 5)
            {
               _nameTxt1.setFrame(model.hideGoods.templateInfo.Profile);
               _nameTxt2.setFrame(model.hideGoods.templateInfo.Profile);
            }
            else
            {
               _nameTxt1.setFrame(1);
               _nameTxt2.setFrame(1);
            }
            _loc6_ = 0;
            while(_loc6_ < 5)
            {
               if(model.hideGoods["randomSkill" + (_loc6_ + 1)] <= 0)
               {
                  _loc3_ = int(_itemList.length);
                  _loc7_ = _loc6_;
                  while(_loc7_ < _loc3_)
                  {
                     _itemList.pop().dispose();
                     _loc7_++;
                  }
                  break;
               }
               if(_itemList.length <= _loc6_)
               {
                  _loc1_ = new ChildRefreshAttItem();
                  _itemVbox.addChild(_loc1_);
                  _itemList.push(_loc1_);
               }
               else
               {
                  _loc1_ = _itemList[_loc6_];
               }
               _loc1_.selected = _lockArr[_loc6_];
               _loc1_.randomSkill = model.hideGoods["randomSkill" + (_loc6_ + 1)];
               _loc1_.randomNewSkill = -1;
               _loc6_++;
            }
         }
         else
         {
            _itemVbox.disposeAllChildren();
            _itemList.length = 0;
         }
      }
      
      private function clean() : void
      {
         _itemVbox.disposeAllChildren();
         _itemList.length = 0;
         _item.data = null;
         _jewel.data = null;
         _refreshBtn.enable = false;
         _replaceBtn.enable = false;
         _nameTxt1.text = _nameTxt2.text = "";
         _nameTxt2.visible = false;
         _needTxt.text = "";
         _countTxt.text = "";
      }
      
      private function _itemLockHandler(param1:StoreEvent) : void
      {
         var _loc5_:int = 0;
         _lockCount = 0;
         _loc5_ = 0;
         while(_loc5_ < _itemList.length)
         {
            if(_itemList[_loc5_].selected)
            {
               _lockCount = _lockCount + 1;
            }
            _loc5_++;
         }
         _needTxt.text = _lockCount * lockPoint + "";
         _needPoint = _lockCount * lockPoint;
         var _loc2_:int = getNeedCountProfile(model.hideGoods.templateInfo.Profile);
         var _loc3_:int = int(GoodsManager.instance.getBagCountByTempId(1,model.hideGoods.templateInfo.Refresh));
         var _loc4_:int = _loc2_ - _loc3_;
         if(_loc4_ < 0)
         {
            _loc4_ = 0;
         }
         if(_shopGoodsInfo)
         {
            _needPoint += _shopGoodsInfo.price * _loc4_;
         }
      }
      
      private function __startDropHandler(param1:String, param2:Object) : void
      {
         _effectBack.visible = true;
         _effectBack.movie.play();
      }
      
      private function __endDropHandler(param1:String, param2:Object) : void
      {
         _effectBack.visible = false;
         _effectBack.movie.stop();
      }
      
      private function __bagItemUpdateHandler(param1:String, param2:Object) : void
      {
         refreshView();
         if(model.hideGoods)
         {
            StoreSocketOutManager.sendRefreshProperty(model.hideGoods.id);
         }
      }
      
      private function _refreshHandler(param1:MouseEvent) : void
      {
         var _loc7_:int = 0;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc2_:String = "";
         if(getTimer() - _time < 500)
         {
            _loc2_ = LanguageMgr.GetTranslation("activity.view.ActivityItem.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(model.hideGoods == null)
         {
            return;
         }
         _time = getTimer();
         _loc7_ = 0;
         while(_loc7_ < 5)
         {
            if(_loc7_ < _itemList.length)
            {
               _lockArr[_loc7_] = _itemList[_loc7_].selected;
            }
            else
            {
               _lockArr[_loc7_] = false;
            }
            _loc7_++;
         }
         if(model.hideGoods.templateInfo.RandomSkillCount <= _lockCount)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.equipstore.PetEquipRefineryView.isAllLocked");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_itemList)
         {
            _loc6_ = int(_itemList.length);
            _loc8_ = 0;
            while(_loc8_ < _loc6_)
            {
               _loc5_ = check(_itemList[_loc8_] as ChildRefreshAttItem);
               if(_loc5_)
               {
                  break;
               }
               _loc8_++;
            }
         }
         if(_loc5_)
         {
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc9_ = LanguageMgr.GetTranslation("public.prompt");
            _loc10_ = LanguageMgr.GetTranslation("Store.refreshView.refreshConfirm");
            SimpleAlertHelper.instance.data = [_refreshConfirm,_lockArr];
            SimpleAlertHelper.instance.popAlerFrame(_loc9_,_loc10_,_loc3_,_loc4_,true,true,false);
         }
         else
         {
            sendRefreshEquip();
         }
      }
      
      private function sendRefreshEquip() : void
      {
         if(_needPoint <= 0)
         {
            refresheResultHandler(true,true);
            return;
         }
         SimpleAlertHelper.instance.data = [refresheResultHandler];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc3_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc4_:String = LanguageMgr.GetTranslation("child.equip.ChildRefreshEquipView.refreshContent",_needPoint);
         SimpleAlertHelper.instance.popAlerFrame(_loc3_,_loc4_,_loc1_,_loc2_,true,true,true,2,"USEBINDPOINT_ALERT",195,"",null,"SimpleAlert");
      }
      
      private function refresheResultHandler(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1)
         {
            _loc6_ = getNeedCountProfile(model.hideGoods.templateInfo.Profile);
            if(param2)
            {
               _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
            }
            else
            {
               _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
            }
            if(_loc3_ >= _needPoint || _hasMaterialCount >= _loc6_ && _lockCount == 0)
            {
               _loc4_ = param2 ? 0 : 1;
               _loc5_ = param2 ? 0 : 1;
               ChildSender.refreshEquip(_lockArr,0,_loc4_,_loc5_);
            }
            else
            {
               RechargeAlertMannager.show();
            }
         }
      }
      
      private function check(param1:ChildRefreshAttItem) : Boolean
      {
         var _loc2_:String = param1.refineryAttributeNewTxt.text;
         var _loc4_:String = LanguageMgr.GetTranslation("store.refresh.start.tip1");
         var _loc3_:String = LanguageMgr.GetTranslation("store.refresh.start.tip2");
         if(StringHelper.isNullOrEmpty(_loc2_))
         {
            return false;
         }
         if(_loc2_.indexOf(_loc4_) != -1 && !param1.selected || _loc2_.indexOf(_loc3_) != -1 && !param1.selected)
         {
            return true;
         }
         return false;
      }
      
      private function _refreshConfirm(param1:Boolean, param2:Boolean, param3:Array) : void
      {
         if(param1)
         {
            sendRefreshEquip();
         }
      }
      
      private function _replaceHandler(param1:MouseEvent) : void
      {
         if(curSelectChild.fightUserId > 0 && curSelectChild.fightUserId != playerInfo.userId)
         {
            if(model.hideGoods.userId > 0)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.cannotop"));
               return;
            }
         }
         ChildSender.confirmRefreshEquip();
      }
      
      private function getNeedCountProfile(param1:int) : int
      {
         var _loc2_:int = 1;
         switch(param1 - 1)
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
         }
         return _loc2_;
      }
      
      private function get curSelectChild() : ChildData
      {
         return ChildManager.instance.curSelectChild;
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_equipBag);
         _equipBag = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_effectBack);
         _effectBack = null;
         ObjectUtils.disposeObject(_jewel);
         _jewel = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeObject(_needTxt);
         _needTxt = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_replaceBtn);
         _replaceBtn = null;
         ObjectUtils.disposeObject(_nameTxt1);
         _nameTxt1 = null;
         ObjectUtils.disposeObject(_nameTxt2);
         _nameTxt2 = null;
         ObjectUtils.disposeObject(_itemVbox);
         _itemVbox = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         _attList = null;
         _attNameDic = null;
         _shopGoodsInfo = null;
         super.dispose();
      }
   }
}

