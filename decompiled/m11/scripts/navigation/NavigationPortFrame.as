package navigation
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.NavigationManager;
   import mvc.module.navigation.NavigationModel;
   import mvc.module.navigation.NavigationPortInfo;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotAlertManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class NavigationPortFrame extends Frame
   {
      
      private var border:ScaleBitmapImage;
      
      private var back:Bitmap;
      
      private var itemBox:VBox;
      
      private var alertIcon:Bitmap;
      
      private var alertText:FilterFrameText;
      
      private var downTime:TimeDownView;
      
      private var dealBtn:IconButton;
      
      private var refuseBtn:IconButton;
      
      private var itemList:Vector.<NavigationTaskItem>;
      
      private var _portInfo:NavigationPortInfo;
      
      private var _portIndex:int = -1;
      
      private var _waitTime:int;
      
      private var _preCostStrength:int;
      
      private var isReached:Boolean;
      
      private var _upgradeBtn:SelectedButton;
      
      private var _tradeBtn:SelectedButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _sprite:Sprite;
      
      private var _bg:Image;
      
      private var _titleTxt:FilterFrameText;
      
      private var _currentLvTxt:FilterFrameText;
      
      private var _currentNumTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _nextLvTxt:FilterFrameText;
      
      private var _nextNumTxt:FilterFrameText;
      
      private var _nextDescTxt:FilterFrameText;
      
      private var _pointsShow:MutipleImage;
      
      private var _pointsShowTxt:FilterFrameText;
      
      private var _upgradeTxt:FilterFrameText;
      
      private var _priceTxt:FilterFrameText;
      
      private var _priceIcon:Image;
      
      private var _pointTxt:FilterFrameText;
      
      private var _pointIcon:Image;
      
      private var _levelBtn:IconButton;
      
      private var _panel:ScrollPanel;
      
      private var _sprite2:Sprite;
      
      private var _refreshBtn:IconButton;
      
      public function NavigationPortFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         border = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.border");
         back = ComponentFactory.Instance.creatBitmap("asset.NavigationPortFrame.back");
         itemBox = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.itemBox");
         alertIcon = ComponentFactory.Instance.creatBitmap("asset.NavigationPortFrame.alertIcon");
         alertText = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.alertText");
         downTime = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.downUpdateTime");
         dealBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.dealBtn");
         refuseBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.refuseBtn");
         _upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.upgradeBtn");
         _tradeBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.tradeBtn");
         _bg = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.bg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.titleTxt");
         _currentLvTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.currentLvTxt");
         _currentNumTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.currentNumTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.descTxt");
         _nextLvTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.nextLvTxt");
         _nextNumTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.nextNumTxt");
         _nextDescTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.nextDescTxt");
         _pointsShow = ComponentFactory.Instance.creatComponentByStylename("NavigationShopFrame.displayShowPoints");
         _pointsShowTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationShopFrame.displayShowTxt");
         _upgradeTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.upgradeTxt");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.priceTxt");
         _priceIcon = ComponentFactory.Instance.creatComponentByStylename("NavigationShopGoodsItem.priceIcon");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.pointTxt");
         _pointIcon = ComponentFactory.Instance.creatComponentByStylename("NavigationShopGoodsItem.pointIcon");
         _levelBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.levelBtn");
         _panel = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.panel");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.refreshBtn");
         _sprite = new Sprite();
         _sprite2 = new Sprite();
         addToContent(border);
         addToContent(back);
         addToContent(_upgradeBtn);
         addToContent(_tradeBtn);
         addToContent(_panel);
         _panel.setView(itemBox);
         addToContent(alertIcon);
         addToContent(alertText);
         addToContent(downTime);
         addToContent(dealBtn);
         addToContent(refuseBtn);
         addToContent(_refreshBtn);
         addToContent(_sprite);
         _sprite.addChild(_bg);
         _sprite.addChild(_titleTxt);
         _sprite.addChild(_currentLvTxt);
         _sprite.addChild(_currentNumTxt);
         _sprite.addChild(_descTxt);
         _sprite.addChild(_sprite2);
         _sprite.addChild(_pointsShow);
         _sprite.addChild(_pointsShowTxt);
         _sprite2.addChild(_nextLvTxt);
         _sprite2.addChild(_nextNumTxt);
         _sprite2.addChild(_nextDescTxt);
         _sprite2.addChild(_upgradeTxt);
         _sprite2.addChild(_priceIcon);
         _sprite2.addChild(_priceTxt);
         _sprite2.addChild(_pointIcon);
         _sprite2.addChild(_pointTxt);
         _sprite2.addChild(_levelBtn);
         _pointsShow.x = 25;
         _pointsShow.y = 346;
         _pointsShowTxt.x = 85;
         _pointsShowTxt.y = 352;
         _priceIcon.x = 331;
         _priceIcon.y = 255;
         _pointIcon.x = 331;
         _pointIcon.y = 300;
         _currentLvTxt.text = LanguageMgr.GetTranslation("NavigationPortFrame.currentLvTxt.text");
         _nextLvTxt.text = LanguageMgr.GetTranslation("NavigationPortFrame.nextLvTxt.text");
         _upgradeTxt.text = LanguageMgr.GetTranslation("NavigationPortFrame.upgradeTxt.text");
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_upgradeBtn);
         _group.addSelectItem(_tradeBtn);
         _group.selectIndex = 0;
         _waitTime = ConfigInfoManager.instance.getNavigationPortTaskRefreshCd();
         _preCostStrength = ConfigInfoManager.instance.getNavigationStrengthShipping();
         alertText.text = LanguageMgr.GetTranslation("NavigationPortFrame.alertText.text1",_waitTime);
      }
      
      private function initListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:NavigationTaskItem = null;
         _panel.beginChanges();
         itemBox.removeAllChild();
         itemList = new Vector.<NavigationTaskItem>();
         _loc2_ = 1;
         while(_loc2_ <= _portInfo.currentTemplte.ActiveObject)
         {
            _loc1_ = new NavigationTaskItem(_loc2_);
            itemBox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         itemBox.commitChanges();
         _panel.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         dealBtn.addEventListener("click",__dealClickHandler);
         refuseBtn.addEventListener("click",__refuseClickHandler);
         downTime.addEventListener("timerDown_complete",__timeCompleteHandler);
         MsgMan.addObserver("NAVIGATION_DATA_CHANGE",this,__updateDataHandler);
         MsgMan.addObserver("NAVIGATION_PATROL_CLOSE",this,__updateFrameHandler);
         _group.addEventListener("change",__changeHandler);
         _levelBtn.addEventListener("click",__levelBtnClickHandler);
         _refreshBtn.addEventListener("click",__refreshBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(dealBtn)
         {
            dealBtn.removeEventListener("click",__dealClickHandler);
         }
         if(refuseBtn)
         {
            refuseBtn.removeEventListener("click",__refuseClickHandler);
         }
         if(downTime)
         {
            downTime.removeEventListener("timerDown_complete",__timeCompleteHandler);
         }
         MsgMan.removeObserver("NAVIGATION_DATA_CHANGE",this,__updateDataHandler);
         MsgMan.removeObserver("NAVIGATION_PATROL_CLOSE",this,__updateFrameHandler);
         _group.removeEventListener("change",__changeHandler);
         _levelBtn.removeEventListener("click",__levelBtnClickHandler);
         _refreshBtn.removeEventListener("click",__refreshBtnClickHandler);
      }
      
      private function __refreshBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = _portInfo.currentTemplte.TemplateId - _portInfo.payBusinessNum;
         if(_loc4_ <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("NavigationPortFrame.refreshBtnClick.text"));
            return;
         }
         var _loc3_:int = int(ConfigInfoManager.instance.navigationRefreshPrice);
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc5_:String = LanguageMgr.GetTranslation("NavigationPortFrame.refreshBtnClick.content",_loc3_,_loc4_);
         NotAlertManager.ins.needAlert("navigation.NavigationShopGoodsItem.buyAlert",refreshResultHandler,_loc2_,_loc5_,false);
      }
      
      private function refreshResultHandler() : void
      {
         var _loc1_:int = int(ConfigInfoManager.instance.navigationRefreshPrice);
         if(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint < _loc1_)
         {
            RechargeAlertMannager.show();
            return;
         }
         NavigationManager.instance.sendNavigationOperate(20,_portInfo.portId,"");
      }
      
      private function __levelBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = "NavigationPortFrame.upgrade.content";
         var _loc3_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc4_:String = LanguageMgr.GetTranslation(_loc2_,price,point);
         NotAlertManager.ins.needAlert("navigation.NavigationShopGoodsItem.buyAlert",upgradeResultHandler,_loc3_,_loc4_,false);
      }
      
      private function upgradeResultHandler() : void
      {
         if(model.currency < price)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("NavigationPortFrame.upgrade.currency.text"));
            return;
         }
         if(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint < point)
         {
            RechargeAlertMannager.show();
            return;
         }
         NavigationManager.instance.sendNavigationOperate(19,_portInfo.portId,"");
      }
      
      private function __changeHandler(param1:Event) : void
      {
         _sprite.visible = _group.selectIndex == 0;
      }
      
      private function __updateFrameHandler(param1:String, param2:Object) : void
      {
         dispose();
      }
      
      private function __updateDataHandler(param1:String, param2:Object) : void
      {
         if(model.op == 17 || model.op == 18)
         {
            return;
         }
         refreshView();
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function __dealClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(model.strength < _preCostStrength)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("navigation.NavigationBoatPatrolFrame.noStrength.Alert"));
            return;
         }
         if(taskList.length <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("navigation.NavigationPortFrame.noSelectList"));
            return;
         }
         var _loc2_:Object = {};
         _loc2_.type = 11;
         _loc2_.data = _portInfo;
         _loc2_.taskList = taskList;
         _loc2_.numList = numList;
         FrameControllerManager.instance.openControllerByInfo("navigation",6,_loc2_);
      }
      
      private function __refuseClickHandler(param1:MouseEvent) : void
      {
         SimpleAlertHelper.instance.data = [cancelTaskResultHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("navigation.NavigationPortFrame.cancelTask.content",_waitTime);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2,"SIMPLE_ALERT");
      }
      
      private function cancelTaskResultHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            NavigationManager.instance.sendNavigationOperate(10,_portInfo.portId,"");
         }
      }
      
      private function refreshView() : void
      {
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc1_:NavigationTaskItem = null;
         _portInfo = model.portList[_portIndex];
         if(!_portInfo)
         {
            return;
         }
         initListView();
         var _loc3_:int = _portInfo.portCd - PlayerManager.instance.currentPlayerModel.sysSecond;
         if(_loc3_ > 0)
         {
            alertText.text = LanguageMgr.GetTranslation("NavigationPortFrame.alertText.text2");
            downTime.timeCount = _loc3_;
            downTime.visible = true;
            _refreshBtn.visible = true;
            refuseBtn.enable = false;
            dealBtn.enable = false;
         }
         else
         {
            downTime.timeCount = 0;
            downTime.visible = false;
            _refreshBtn.visible = false;
            refuseBtn.enable = true;
            dealBtn.enable = true;
            alertText.text = LanguageMgr.GetTranslation("NavigationPortFrame.alertText.text1",_waitTime);
         }
         if(_portInfo.isTasking)
         {
            refuseBtn.enable = false;
            dealBtn.enable = false;
         }
         var _loc4_:int = _portIndex + 1;
         _titleTxt.text = LanguageMgr.GetTranslation("NavigationBuildView.nameText.text" + _loc4_);
         _pointsShowTxt.text = model.currency.toString();
         _currentNumTxt.text = LanguageMgr.GetTranslation("public.level2",_portInfo.grades);
         var _loc2_:String = "";
         if(_portInfo.currentTemplte.ActiveObject > 0)
         {
            _loc2_ += LanguageMgr.GetTranslation("NavigationPortFrame.activeObject.text",_portInfo.currentTemplte.ActiveObject) + "\n";
         }
         if(_portInfo.currentTemplte.Data > 0)
         {
            _loc2_ += LanguageMgr.GetTranslation("NavigationPortFrame.Data.text",_portInfo.currentTemplte.Data) + "\n";
         }
         if(_portInfo.currentTemplte.TemplateId > 0)
         {
            _loc2_ += LanguageMgr.GetTranslation("NavigationPortFrame.TemplateId.text",_portInfo.currentTemplte.TemplateId) + "\n";
         }
         _descTxt.text = _loc2_;
         if(_portInfo.upgradeTemplte)
         {
            _sprite2.visible = true;
            _nextNumTxt.text = LanguageMgr.GetTranslation("public.level2",_portInfo.grades + 1);
            _loc5_ = "";
            if(_portInfo.upgradeTemplte.ActiveObject > 0)
            {
               _loc5_ += LanguageMgr.GetTranslation("NavigationPortFrame.activeObject.text",_portInfo.upgradeTemplte.ActiveObject) + "\n";
            }
            if(_portInfo.upgradeTemplte.Data > 0)
            {
               _loc5_ += LanguageMgr.GetTranslation("NavigationPortFrame.Data.text",_portInfo.upgradeTemplte.Data) + "\n";
            }
            if(_portInfo.upgradeTemplte.TemplateId > 0)
            {
               _loc5_ += LanguageMgr.GetTranslation("NavigationPortFrame.TemplateId.text",_portInfo.upgradeTemplte.TemplateId) + "\n";
            }
            _nextDescTxt.text = _loc5_;
         }
         else
         {
            _sprite2.visible = false;
         }
         _priceTxt.text = price.toString();
         _pointTxt.text = point.toString();
         _loc6_ = 0;
         while(_loc6_ < _portInfo.currentTemplte.ActiveObject)
         {
            _loc1_ = itemList[_loc6_];
            _loc1_.data = _portInfo;
            _loc6_++;
         }
      }
      
      private function get price() : int
      {
         var _loc1_:Array = null;
         if(_portInfo.upgradeTemplte)
         {
            _loc1_ = _portInfo.upgradeTemplte.TemplateName.split(",");
            return _loc1_[0];
         }
         return 0;
      }
      
      private function get point() : int
      {
         var _loc1_:Array = null;
         if(_portInfo.upgradeTemplte)
         {
            _loc1_ = _portInfo.upgradeTemplte.TemplateName.split(",");
            return _loc1_[1];
         }
         return 0;
      }
      
      private function get taskList() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:NavigationTaskItem = null;
         var _loc3_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _portInfo.currentTemplte.ActiveObject)
         {
            _loc1_ = itemList[_loc2_];
            if(_loc1_.isSelect)
            {
               _loc3_.push(_loc2_ + 1);
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      private function get numList() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:NavigationTaskItem = null;
         var _loc3_:Array = [];
         _loc2_ = 0;
         while(_loc2_ < _portInfo.currentTemplte.ActiveObject)
         {
            _loc1_ = itemList[_loc2_];
            if(_loc1_.isSelect)
            {
               _loc3_.push(_loc1_.comboSelectedIndex);
            }
            _loc2_++;
         }
         return _loc3_;
      }
      
      private function get model() : NavigationModel
      {
         return NavigationManager.instance.model;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:int = -1) : void
      {
         _portIndex = param1 - 1;
         titleText = LanguageMgr.GetTranslation("navigation.NavigationPortFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(border);
         border = null;
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(alertIcon);
         alertIcon = null;
         ObjectUtils.disposeObject(alertText);
         alertText = null;
         ObjectUtils.disposeObject(downTime);
         downTime = null;
         ObjectUtils.disposeObject(dealBtn);
         dealBtn = null;
         ObjectUtils.disposeObject(refuseBtn);
         refuseBtn = null;
         ObjectUtils.disposeObject(itemBox);
         itemBox = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

