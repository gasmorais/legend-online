package armyII.viewII.battleGuard
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.ArmyModel;
   import mvc.module.planeswar.PlanesWarModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.BattleGuardInfo;
   import yishi.datas.playerinfo.BattleGuardSocketInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseIconView;
   import yishi.view.newGuildHelp.NewGuildFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class BattleGuardView extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _iconList:Vector.<BaseIconView>;
      
      private var _itemList:Vector.<BattleGuardItemView>;
      
      private var _gemMc:MovieClip;
      
      private var _battleWillItemView:BattleGuardItemView;
      
      private var _helpbtn:BaseButton;
      
      private var _onlyReady:Boolean;
      
      private var _thaneInfo:ThaneInfo;
      
      private var _selectedItem:BattleGuardItemView;
      
      private var _data:BattleGuardInfo;
      
      public function BattleGuardView(param1:Boolean, param2:ThaneInfo)
      {
         _onlyReady = param1;
         _thaneInfo = param2;
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:BattleGuardItemView = null;
         var _loc2_:int = 0;
         var _loc3_:BaseIconView = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("BattleGuardView.bg");
         addChild(_bg);
         var _loc4_:Array = [{
            "x":262,
            "y":56
         },{
            "x":265,
            "y":165
         },{
            "x":152,
            "y":255
         },{
            "x":38,
            "y":166
         },{
            "x":38,
            "y":56
         },{
            "x":152,
            "y":14
         }];
         _itemList = new Vector.<BattleGuardItemView>(6);
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("BattleGuardBagView.BattleGuardItemView",[_loc2_ + 1,_thaneInfo]);
            _loc1_.buttonMode = true;
            _loc1_.x = _loc4_[_loc2_].x;
            _loc1_.y = _loc4_[_loc2_].y;
            _loc1_.addEventListener("click",__itemClickHandler);
            addChild(_loc1_);
            _itemList[_loc2_] = _loc1_;
            _loc2_++;
         }
         _gemMc = ComponentFactory.Instance.creat("asset.battleguard.GemMC");
         _gemMc.mouseEnabled = false;
         _gemMc.x = 44;
         _gemMc.y = 342;
         _iconList = new Vector.<BaseIconView>(3);
         _loc2_ = 0;
         while(_loc2_ < _iconList.length)
         {
            _loc3_ = ComponentFactory.Instance.creatCustomObject("BattleGuardView.iconView");
            _loc3_.graphics.beginFill(16777215,0);
            _loc3_.graphics.drawRect(0,0,_loc3_.iconWidth,_loc3_.iconHeight);
            _loc3_.graphics.endFill();
            _loc3_.mouseChildren = false;
            _loc3_.pos = 10000 + _loc2_;
            _iconList[_loc2_] = _loc3_;
            _gemMc["pos" + (_loc2_ + 1)].addChild(_loc3_);
            if(!_onlyReady)
            {
               _loc3_.doubleClickEnabled = true;
               _loc3_.addEventListener("doubleClick",__removeGemHandler);
            }
            _loc2_++;
         }
         addChild(_gemMc);
         _battleWillItemView = ComponentFactory.Instance.creatComponentByStylename("BattleGuardBagView.BattleGuardItemView",[7,_thaneInfo]);
         _battleWillItemView.x = 160;
         _battleWillItemView.y = 116;
         _battleWillItemView.addEventListener("click",__itemClickHandler);
         if(!_onlyReady)
         {
            _battleWillItemView.name = "battlewill_1_0_0";
         }
         addChild(_battleWillItemView);
      }
      
      private function uintView() : void
      {
         if(_battleWillItemView)
         {
            _battleWillItemView.removeEventListener("click",__itemClickHandler);
            _battleWillItemView.dispose();
            _battleWillItemView = null;
         }
         for each(var _loc1_:BattleGuardItemView in _itemList)
         {
            _loc1_.removeEventListener("click",__itemClickHandler);
         }
         _itemList = null;
         if(_selectedItem && _selectedItem.data)
         {
            _selectedItem.data.removeEventListener("change",__refreshSocketListHandler);
         }
         for each(var _loc2_:BaseIconView in _iconList)
         {
            _loc2_.removeEventListener("doubleClick",__removeGemHandler);
            _loc2_.dispose();
         }
         _iconList = null;
      }
      
      private function __openHelpFrame(param1:MouseEvent) : void
      {
         var _loc3_:NewGuildFrame = ComponentFactory.Instance.creatComponentByStylename("core.newGuildHelpFrame");
         var _loc2_:Object = {};
         _loc2_.frameName = "battleguard.NewGuildFrame";
         _loc2_.index = 1;
         _loc3_.data = _loc2_;
         _loc3_.show();
      }
      
      private function __removeGemHandler(param1:MouseEvent) : void
      {
         var _loc3_:BaseIconView = param1.currentTarget as BaseIconView;
         if(!_loc3_.name)
         {
            return;
         }
         if(!data)
         {
            return;
         }
         var _loc6_:Array = _loc3_.name.split("_");
         var _loc5_:int = int(_loc6_[1]);
         var _loc7_:int = int(_loc6_[2]);
         var _loc2_:int = int(_loc6_[3]);
         var _loc4_:BattleGuardSocketInfo = data.getSocketInfo(_loc5_,_loc7_);
         if(_loc4_.getTempByPos(_loc2_))
         {
            confirmRemoveGem(_loc5_,_loc7_,_loc2_);
         }
      }
      
      private function confirmRemoveGem(param1:int, param2:int, param3:int) : void
      {
         SimpleAlertHelper.instance.data = [confirmRemoveGemBack,param1,param2,param3];
         var _loc4_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc5_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc6_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc7_:String = LanguageMgr.GetTranslation("wanttoremove");
         SimpleAlertHelper.instance.popAlerFrame(_loc6_,_loc7_,_loc4_,_loc5_);
      }
      
      private function confirmRemoveGemBack(param1:Boolean, param2:Boolean, param3:int, param4:int, param5:int) : void
      {
         if(param1)
         {
            PlayerManager.instance.sendRemoveBattleGem(param3,param4,param5);
         }
      }
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:BattleGuardItemView = param1.currentTarget as BattleGuardItemView;
         if(!_loc2_.data)
         {
            return;
         }
         if(_loc2_.data.state == 0)
         {
            if(_onlyReady)
            {
               return;
            }
            activeItem(_loc2_.data);
         }
         else
         {
            selectedItem = _loc2_;
         }
      }
      
      private function get model() : ArmyModel
      {
         return control.model;
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function activeItem(param1:BattleGuardSocketInfo) : void
      {
         var _loc10_:UpgradeTemplateInfo = null;
         var _loc9_:int = 0;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc2_:Array = TempleteManager.instance.getTemplatesByType(28);
         var _loc8_:Array = LanguageMgr.GetTranslation("BattleGuardItemNames").split(",");
         if(param1.type == 1)
         {
            _loc9_ = param1.pos + 7;
            _loc11_ = _loc8_[0];
         }
         else
         {
            _loc9_ = param1.pos + 1;
            _loc11_ = _loc8_[_loc9_];
         }
         for each(var _loc4_:UpgradeTemplateInfo in _loc2_)
         {
            if(_loc4_.ActiveObject == _loc9_)
            {
               _loc10_ = _loc4_;
               break;
            }
         }
         if(!_loc10_)
         {
            return;
         }
         var _loc7_:ThaneInfo = ArmyManager.instance.thane;
         if(_loc7_.grades < _loc10_.Grades)
         {
            _loc12_ = LanguageMgr.GetTranslation("BattleGuardView.needGrade",_loc10_.Grades);
            MessageTipManager.instance().show(_loc12_);
            return;
         }
         if(_loc9_ == 7)
         {
            PlayerManager.instance.sendOpenBattleItem(param1.type,param1.pos);
            return;
         }
         if(_loc10_.Data <= 0 && _loc10_.TemplateId <= 0)
         {
            PlayerManager.instance.sendOpenBattleItem(param1.type,param1.pos);
            return;
         }
         var _loc6_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc13_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = "";
         if(_loc9_ == 6)
         {
            if(_loc10_.Data > 0)
            {
               _loc5_ = LanguageMgr.GetTranslation("BattleGuardItemTip.pointTip",_loc10_.Data);
            }
            _loc5_ = LanguageMgr.GetTranslation("BattleGuardView.openContent",_loc5_,_loc11_);
            SimpleAlertHelper.instance.data = [activeItemback2,param1];
            SimpleAlertHelper.instance.popAlerFrame(_loc13_,_loc5_,_loc6_,_loc3_,false,true,false,2,"USEBINDPOINT_ALERT");
         }
         else
         {
            activeItemback(true,true,param1,null);
         }
      }
      
      private function activeItemback2(param1:Boolean, param2:Boolean, param3:BattleGuardSocketInfo) : void
      {
         var _loc4_:int = 0;
         if(!param1)
         {
            return;
         }
         var _loc5_:int = 0;
         if(param2)
         {
            _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         else
         {
            _loc5_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         }
         if(_loc5_ < 1000)
         {
            RechargeAlertMannager.show();
         }
         else
         {
            _loc4_ = param2 ? 2 : 1;
            PlayerManager.instance.sendOpenBattleItem(param3.type,param3.pos,_loc4_);
         }
      }
      
      private function activeItemback(param1:Boolean, param2:Boolean, param3:BattleGuardSocketInfo, param4:GoodsTemplateInfo) : void
      {
         var _loc6_:int = 0;
         var _loc5_:String = null;
         if(!param1)
         {
            return;
         }
         if(param4)
         {
            _loc6_ = int(GoodsManager.instance.getBagCountByTempId(1,param4.TemplateId));
            if(_loc6_ > 0)
            {
               PlayerManager.instance.sendOpenBattleItem(param3.type,param3.pos);
            }
            else
            {
               _loc5_ = LanguageMgr.GetTranslation("BattleGuardView.noGoods",param4.TemplateName);
               MessageTipManager.instance().show(_loc5_);
            }
         }
         else
         {
            PlayerManager.instance.sendOpenBattleItem(param3.type,param3.pos);
         }
      }
      
      public function get selectedItem() : BattleGuardItemView
      {
         return _selectedItem;
      }
      
      public function set selectedItem(param1:BattleGuardItemView) : void
      {
         var _loc5_:int = 0;
         var _loc4_:BaseIconView = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc6_:GoodsInfo = null;
         if(_selectedItem == param1)
         {
            return;
         }
         if(_selectedItem && _selectedItem.data)
         {
            _selectedItem.data.removeEventListener("change",__refreshSocketListHandler);
         }
         for each(var _loc2_:BattleGuardItemView in _itemList)
         {
            _loc2_.selected = false;
         }
         _battleWillItemView.selected = false;
         _selectedItem = param1;
         _loc2_ = _selectedItem;
         _loc2_.refresh();
         _loc2_.selected = true;
         _gemMc.gotoAndStop(1);
         var _loc7_:BattleGuardSocketInfo = _loc2_.data;
         _loc5_ = 0;
         while(_loc5_ < _loc7_.length)
         {
            _loc4_ = _iconList[_loc5_];
            _loc3_ = _loc7_.getTempByPos(_loc5_);
            if(_loc3_)
            {
               _loc4_.icon = IconFactory.getGoodsIconByTID(_loc3_.TemplateId);
               _loc6_ = new GoodsInfo();
               _loc6_.templateId = _loc3_.TemplateId;
               _loc4_.tipData = _loc6_;
            }
            else
            {
               _loc4_.icon = null;
               _loc4_.tipData = null;
            }
            if(!_onlyReady)
            {
               _loc4_.name = _loc2_.name + "_" + _loc5_;
            }
            _loc5_++;
         }
         _selectedItem.data.addEventListener("change",__refreshSocketListHandler);
         _gemMc.play();
      }
      
      private function __refreshSocketListHandler(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:BaseIconView = null;
         var _loc2_:GoodsTemplateInfo = null;
         var _loc5_:GoodsInfo = null;
         var _loc6_:BattleGuardSocketInfo = param1.currentTarget as BattleGuardSocketInfo;
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc3_ = _iconList[_loc4_];
            _loc2_ = _loc6_.getTempByPos(_loc4_);
            if(_loc2_)
            {
               _loc3_.icon = IconFactory.getGoodsIconByTID(_loc2_.TemplateId);
               _loc5_ = new GoodsInfo();
               _loc5_.templateId = _loc2_.TemplateId;
               _loc3_.tipData = _loc5_;
            }
            else
            {
               _loc3_.icon = null;
               _loc3_.tipData = null;
            }
            _loc4_++;
         }
      }
      
      public function get data() : BattleGuardInfo
      {
         return _data;
      }
      
      public function set data(param1:BattleGuardInfo) : void
      {
         removeEvent();
         _data = param1;
         if(_data)
         {
            refresh();
            addEvent();
            defaultView();
         }
      }
      
      private function addEvent() : void
      {
         if(_data)
         {
            _data.addEventListener("OPEN_BATTLEGUARD_ITEM",__newItemOpenHandler);
         }
         NotificationManager.instance.addEventListener("DOUBLE_CLICK",__doubleClickBagItemHandler);
      }
      
      private function removeEvent() : void
      {
         if(_data)
         {
            _data.removeEventListener("OPEN_BATTLEGUARD_ITEM",__newItemOpenHandler);
         }
         NotificationManager.instance.removeEventListener("DOUBLE_CLICK",__doubleClickBagItemHandler);
      }
      
      private function __newItemOpenHandler(param1:NotificationEvent) : void
      {
         var _loc2_:BattleGuardItemView = null;
         var _loc3_:BattleGuardSocketInfo = param1.data as BattleGuardSocketInfo;
         if(!_loc3_)
         {
            return;
         }
         if(_loc3_.type == 1)
         {
            _loc2_ = _battleWillItemView;
         }
         else
         {
            _loc2_ = _itemList[_loc3_.pos];
         }
         selectedItem = _loc2_;
      }
      
      private function __doubleClickBagItemHandler(param1:NotificationEvent) : void
      {
         var _loc3_:BaseIconView = null;
         var _loc6_:int = 0;
         var _loc5_:BaseIconView = null;
         var _loc8_:Array = null;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:String = null;
         var _loc10_:GoodsInfo = param1.data as GoodsInfo;
         if(!_loc10_)
         {
            return;
         }
         if(_loc10_.templateInfo.SonType != 312)
         {
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < _iconList.length)
         {
            _loc5_ = _iconList[_loc6_];
            if(_loc5_.icon == null)
            {
               _loc3_ = _loc5_;
               break;
            }
            _loc6_++;
         }
         if(_loc3_)
         {
            _loc8_ = _loc5_.name.split("_");
            _loc7_ = int(_loc8_[1]);
            _loc9_ = int(_loc8_[2]);
            _loc4_ = int(_loc8_[3]);
            PlayerManager.instance.sendAddBattleGem(_loc7_,_loc9_,_loc4_,_loc10_,_loc10_.bagType);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.command04");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function refresh() : void
      {
         var _loc1_:BattleGuardItemView = null;
         for each(var _loc2_:BattleGuardSocketInfo in _data.notchList)
         {
            _loc1_ = _itemList[_loc2_.pos];
            _loc1_.name = "battleguard_" + _loc2_.type + "_" + _loc2_.pos;
            _loc1_.data = _loc2_;
            if(_onlyReady && _loc2_.state == 0)
            {
               _loc1_.buttonMode = false;
            }
         }
         _loc2_ = _data.battleWillPower;
         _battleWillItemView.data = _loc2_;
         _battleWillItemView.name = "battleguard_" + _loc2_.type + "_" + _loc2_.pos;
      }
      
      private function defaultView() : void
      {
         var _loc1_:BattleGuardItemView = _itemList[0];
         _loc1_.dispatchEvent(new MouseEvent("click"));
      }
      
      private function get planesModel() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uintView();
         super.dispose();
      }
   }
}

