package armyII.viewII.tattoo
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.controler.TattooController;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.tattoo.TattooHole;
   import mvc.module.tattoo.TattooModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotAlertManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.TodayNotAlertFrame;
   
   public class TattooPopFrame extends Frame implements IManualSize
   {
      
      private static var _autoBuyUseBind:Boolean = true;
      
      private static var _lockUseBind:Boolean = true;
      
      private static const PROPERTY_NAME:Array = ["strength","agility","intelligence","captain","","physique"];
      
      private var _index:int = 0;
      
      private var _tattooMainBg:Image;
      
      private var _nowTattoo:Image;
      
      private var _newTattoo:Image;
      
      private var _nowTattooIcon:Image;
      
      private var _newTattooIcon:Image;
      
      private var _questionBg:Image;
      
      private var _questionBg2:Image;
      
      private var _replaceAttriBtn:BaseButton;
      
      private var _tattooBtn:BaseButton;
      
      private var _seniorTattooBtn:BaseButton;
      
      private var _tattooStripView:StripView;
      
      private var _seniorTattooStripView:StripView;
      
      private var _autoBuySelectButton:SelectedButton;
      
      private var _tattooLockBtn1:SelectedButton;
      
      private var _tattooLockBtn2:SelectedButton;
      
      private var _smallPointImg:Bitmap;
      
      private var _smallPointImg2:Bitmap;
      
      private var _cost:Image;
      
      private var _cost2:Image;
      
      private var _nowTattooNameTxt:FilterFrameText;
      
      private var _newTattooNameTxt:FilterFrameText;
      
      private var _nowTattooAddPropertyTxt:FilterFrameText;
      
      private var _nowTattooReducePropertyTxt:FilterFrameText;
      
      private var _newTattooPropertyTxt:FilterFrameText;
      
      private var _tattooCountTxt:FilterFrameText;
      
      private var _seniorTattooCountTxt:FilterFrameText;
      
      private var _tattooAddRangeTxt:FilterFrameText;
      
      private var _seniorTattooAddRangeTxt:FilterFrameText;
      
      private var _autoBuyBtnText:FilterFrameText;
      
      private var _costText:FilterFrameText;
      
      private var _costText2:FilterFrameText;
      
      private var _oldAddValue:int = 0;
      
      private var _notAlert:Boolean = false;
      
      private var lockNeedPoints:int;
      
      private var autoBuyNeedPoints:int;
      
      private var autoBuyNeedPoints2:int;
      
      private var costNum:int = 100;
      
      private var clickIndex:int;
      
      private var isFirstTimeLock:Boolean = true;
      
      private var tattooType:int = 0;
      
      private var _rect:Rectangle;
      
      public function TattooPopFrame()
      {
         super();
         initView();
         addEvent();
         refresh();
         refreshPoint();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("tattoo.TattooPopFrame.title");
         _tattooMainBg = ComponentFactory.Instance.creatComponentByStylename("tattoo.tattooMainBg");
         _nowTattoo = ComponentFactory.Instance.creatComponentByStylename("tattoo.nowTattoo");
         _newTattoo = ComponentFactory.Instance.creatComponentByStylename("tattoo.newTattoo");
         _questionBg = ComponentFactory.Instance.creatComponentByStylename("tattoo.questionBg");
         _questionBg2 = ComponentFactory.Instance.creatComponentByStylename("tattoo.questionBg");
         _replaceAttriBtn = ComponentFactory.Instance.creatComponentByStylename("tattoo.replaceAttriBtn");
         _tattooBtn = ComponentFactory.Instance.creatComponentByStylename("tattoo.tattooBtn");
         _seniorTattooBtn = ComponentFactory.Instance.creatComponentByStylename("tattoo.seniorTattooBtn");
         _tattooStripView = ComponentFactory.Instance.creatCustomObject("tattoo.tattooStripView");
         _seniorTattooStripView = ComponentFactory.Instance.creatCustomObject("tattoo.seniorTattooStripView");
         _nowTattooNameTxt = ComponentFactory.Instance.creatComponentByStylename("tattoo.nowTattooNameTxt");
         _newTattooNameTxt = ComponentFactory.Instance.creatComponentByStylename("tattoo.newTattooNameTxt");
         _nowTattooAddPropertyTxt = ComponentFactory.Instance.creatComponentByStylename("tattoo.nowTattooPropertyTxt");
         _nowTattooReducePropertyTxt = ComponentFactory.Instance.creatComponentByStylename("tattoo.nowTattooPropertyTxt");
         _newTattooPropertyTxt = ComponentFactory.Instance.creatComponentByStylename("tattoo.newTattooPropertyTxt");
         _tattooCountTxt = ComponentFactory.Instance.creatComponentByStylename("tattoo.tattooCountTxt");
         _seniorTattooCountTxt = ComponentFactory.Instance.creatComponentByStylename("tattoo.seniorTattooCountTxt");
         _tattooAddRangeTxt = ComponentFactory.Instance.creatComponentByStylename("tattoo.tattooAddRangeTxt");
         _seniorTattooAddRangeTxt = ComponentFactory.Instance.creatComponentByStylename("tattoo.seniorTattooAddRangeTxt");
         _autoBuyBtnText = ComponentFactory.Instance.creatComponentByStylename("tattoo.autoBuyBtnText");
         _costText = ComponentFactory.Instance.creatComponentByStylename("tattoo.costText");
         _costText2 = ComponentFactory.Instance.creatComponentByStylename("tattoo.costText");
         _smallPointImg = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _smallPointImg2 = ComponentFactory.Instance.creatBitmap("asset.core.SmallPointImg");
         _cost = ComponentFactory.Instance.creatComponentByStylename("tattoo.cost");
         _cost2 = ComponentFactory.Instance.creatComponentByStylename("tattoo.cost");
         _autoBuySelectButton = ComponentFactory.Instance.creatComponentByStylename("tattoo.autoBuySelectButton");
         _tattooLockBtn1 = ComponentFactory.Instance.creatComponentByStylename("TattooPopFrame.tattooLockBtn");
         _tattooLockBtn2 = ComponentFactory.Instance.creatComponentByStylename("TattooPopFrame.tattooLockBtn");
         addToContent(_tattooMainBg);
         addToContent(_nowTattoo);
         addToContent(_newTattoo);
         addToContent(_questionBg);
         addToContent(_questionBg2);
         _questionBg2.x = 306;
         addToContent(_replaceAttriBtn);
         addToContent(_tattooBtn);
         addToContent(_seniorTattooBtn);
         addToContent(_tattooStripView);
         addToContent(_seniorTattooStripView);
         _tattooStripView.setTarget(_tattooBtn);
         _seniorTattooStripView.setTarget(_seniorTattooBtn);
         addToContent(_autoBuyBtnText);
         addToContent(_autoBuySelectButton);
         addToContent(_tattooLockBtn1);
         addToContent(_tattooLockBtn2);
         _tattooLockBtn2.y += 24;
         _autoBuyBtnText.text = LanguageMgr.GetTranslation("store.view.refresh.RefreshView.buyTxt");
         addToContent(_costText);
         addToContent(_costText2);
         _costText2.x = 339;
         _costText.text = "0";
         _costText2.text = "0";
         addToContent(_smallPointImg);
         addToContent(_smallPointImg2);
         _smallPointImg.x = _costText.x + _costText.textWidth + 9;
         _smallPointImg2.x = _costText2.x + _costText2.textWidth + 9;
         _smallPointImg2.y = _smallPointImg.y = 339;
         addToContent(_cost);
         addToContent(_cost2);
         _cost2.x = 257;
         addToContent(_nowTattooNameTxt);
         addToContent(_newTattooNameTxt);
         addToContent(_nowTattooAddPropertyTxt);
         addToContent(_nowTattooReducePropertyTxt);
         _nowTattooReducePropertyTxt.y += 20;
         addToContent(_newTattooPropertyTxt);
         addToContent(_tattooCountTxt);
         addToContent(_seniorTattooCountTxt);
         addToContent(_tattooAddRangeTxt);
         addToContent(_seniorTattooAddRangeTxt);
         _tattooBtn.tipData = _tattooStripView.tipData = LanguageMgr.GetTranslation("tattoo.tattooBtn.tipData",costNum);
         _seniorTattooBtn.tipData = _seniorTattooStripView.tipData = LanguageMgr.GetTranslation("tattoo.seniorTattooBtn.tipData",costNum);
      }
      
      private function get holes() : Array
      {
         return FrameControllerManager.instance.tattooController.tattooModel.holes;
      }
      
      public function refresh() : void
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         _index = FrameControllerManager.instance.tattooController.tattooModel.currHoleIndex;
         var _loc1_:TattooHole = holes[_index];
         if(!_loc1_)
         {
            _loc1_ = new TattooHole();
         }
         ObjectUtils.disposeObject(_nowTattooIcon);
         ObjectUtils.disposeObject(_newTattooIcon);
         _tattooBtn.enable = true;
         if(_loc1_.oldAddProperty >= 0)
         {
            _oldAddValue = _loc1_.oldAddingValue;
            _loc2_ = _loc1_.oldAddingValue < model.getPrimaryTattooMaxAddValue() ? 1 : 2;
            _nowTattooIcon = ComponentFactory.Instance.creatComponentByStylename("tattoo." + PROPERTY_NAME[_loc1_.oldAddProperty] + _loc2_);
            if(_loc2_ == 2)
            {
               _nowTattooIcon.x = 63;
               _nowTattooIcon.y = 41;
            }
            else
            {
               _nowTattooIcon.x = 76;
               _nowTattooIcon.y = 56;
            }
            addToContent(_nowTattooIcon);
            _loc3_ = LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyName" + _loc1_.oldAddProperty);
            _loc4_ = LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyName" + _loc1_.oldReduceProperty);
            _nowTattooNameTxt.text = LanguageMgr.GetTranslation("tattoo.TattooPopFrame.tattoo") + " " + LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyLvl" + _loc2_) + _loc3_;
            _nowTattooAddPropertyTxt.text = _loc3_ + "  +" + _loc1_.oldAddingValue;
            _nowTattooReducePropertyTxt.text = _loc4_ + "  " + _loc1_.oldReduceValue;
            _tattooLockBtn1.visible = true;
            _tattooLockBtn2.visible = true;
            _tattooLockBtn1.selected = _loc1_.isLockAdd;
            _tattooLockBtn2.selected = _loc1_.isLockReduce;
         }
         else
         {
            _nowTattooNameTxt.text = LanguageMgr.GetTranslation("tattoo.TattooPopFrame.noTattoo");
            _nowTattooAddPropertyTxt.text = "";
            _tattooLockBtn1.visible = false;
            _tattooLockBtn2.visible = false;
         }
         if(_loc1_.newAddProperty >= 0)
         {
            _loc2_ = _loc1_.newAddingValue < model.getPrimaryTattooMaxAddValue() ? 1 : 2;
            _newTattooIcon = ComponentFactory.Instance.creatComponentByStylename("tattoo." + PROPERTY_NAME[_loc1_.newAddProperty] + _loc2_);
            if(_loc2_ == 2)
            {
               _newTattooIcon.x = 304;
               _newTattooIcon.y = 41;
            }
            else
            {
               _newTattooIcon.x = 316;
               _newTattooIcon.y = 56;
            }
            addToContent(_newTattooIcon);
            _loc3_ = LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyName" + _loc1_.newAddProperty);
            _loc4_ = LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyName" + _loc1_.newReduceProperty);
            _newTattooNameTxt.text = LanguageMgr.GetTranslation("tattoo.TattooPopFrame.tattoo") + " " + LanguageMgr.GetTranslation("tattoo.TattooPopFrame.propertyLvl" + _loc2_) + _loc3_;
            _newTattooPropertyTxt.text = _loc3_ + "  +" + _loc1_.newAddingValue + "\n" + _loc4_ + "  " + _loc1_.newReduceValue;
            _replaceAttriBtn.visible = true;
         }
         else
         {
            _replaceAttriBtn.visible = false;
            _newTattooNameTxt.text = "";
            _newTattooPropertyTxt.text = "";
         }
         _tattooCountTxt.text = GoodsManager.instance.getBagCountByTempId(1,tattooController.tattooModel.tattooDyeTempId) + "";
         _seniorTattooCountTxt.text = GoodsManager.instance.getBagCountByTempId(1,tattooController.tattooModel.seniorTattooDyeTempId) + "";
         _tattooAddRangeTxt.text = getTattooAddRange(_loc1_);
         _seniorTattooAddRangeTxt.text = getSeniorTattooAddRange(_loc1_);
         _nowTattooNameTxt.y = _nowTattooNameTxt.numLines > 1 ? 134 : 140;
         _newTattooNameTxt.y = _newTattooNameTxt.numLines > 1 ? 134 : 140;
      }
      
      private function getTattooAddRange(param1:TattooHole) : String
      {
         var _loc2_:int = int(model.getPrimaryTattooMaxAddValue());
         var _loc3_:int = Math.ceil(10 * (_loc2_ - param1.oldAddingValue) / _loc2_);
         if(_loc3_ > 1)
         {
            return LanguageMgr.GetTranslation("tattoo.TattooPopFrame.tattooAddRange") + " " + LanguageMgr.GetTranslation("tattoo.TattooPopFrame.AddProperty") + " 1~" + _loc3_;
         }
         if(_loc3_ == 1)
         {
            return LanguageMgr.GetTranslation("tattoo.TattooPopFrame.tattooAddRange") + " " + LanguageMgr.GetTranslation("tattoo.TattooPopFrame.AddProperty") + " 1";
         }
         return LanguageMgr.GetTranslation("tattoo.TattooPopFrame.tattooAddRange") + " " + LanguageMgr.GetTranslation("tattoo.TattooPopFrame.tattooCannotAdd");
      }
      
      private function getSeniorTattooAddRange(param1:TattooHole) : String
      {
         var _loc2_:int = int(model.getSeniorTattooMaxAddValue());
         var _loc3_:int = int(Math.ceil(20 * (_loc2_ - param1.oldAddingValue) / _loc2_)) + 20;
         if(_loc3_ > 21)
         {
            return LanguageMgr.GetTranslation("tattoo.TattooPopFrame.seniorTattooAddRange") + " " + LanguageMgr.GetTranslation("tattoo.TattooPopFrame.AddProperty") + " 21~" + _loc3_;
         }
         if(_loc3_ == 21)
         {
            return LanguageMgr.GetTranslation("tattoo.TattooPopFrame.seniorTattooAddRange") + " " + LanguageMgr.GetTranslation("tattoo.TattooPopFrame.AddProperty") + " 21";
         }
         return LanguageMgr.GetTranslation("tattoo.TattooPopFrame.seniorTattooAddRange") + " " + LanguageMgr.GetTranslation("tattoo.TattooPopFrame.tattooCannotAdd");
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         _replaceAttriBtn.addEventListener("click",__onReplaceAttriBtnClick);
         _tattooBtn.addEventListener("click",__onTattooBtnClick);
         _seniorTattooBtn.addEventListener("click",__onSeniorTattooBtnClick);
         _autoBuySelectButton.addEventListener("click",__autoBuySelectButtonClickHandler);
         _tattooLockBtn1.addEventListener("click",__tattooLockBtn1ClickHandler);
         _tattooLockBtn2.addEventListener("click",__tattooLockBtn2ClickHandler);
         MsgMan.addObserver("TATTOO_INFO",this,updateTattooInfo);
      }
      
      protected function __tattooLockBtn1ClickHandler(param1:MouseEvent) : void
      {
         clickIndex = 1;
         if(_tattooLockBtn1.selected)
         {
            _tattooLockBtn1.selected = false;
            refreshPoint();
            showLockAlert();
         }
         else
         {
            switchState();
            refreshPoint();
         }
      }
      
      protected function __tattooLockBtn2ClickHandler(param1:MouseEvent) : void
      {
         clickIndex = 2;
         if(_tattooLockBtn2.selected)
         {
            _tattooLockBtn2.selected = false;
            refreshPoint();
            showLockAlert();
         }
         else
         {
            switchState();
            refreshPoint();
         }
      }
      
      private function showLockAlert() : void
      {
         var _loc1_:String = null;
         if(isFirstTimeLock)
         {
            isFirstTimeLock = false;
            _loc1_ = LanguageMgr.GetTranslation("TattooPopFrame.lockCostPrompt");
            SimpleAlertHelper.instance.data = [showLockAlertBack];
            SimpleAlertHelper.instance.popAlerFrame(LanguageMgr.GetTranslation("public.prompt"),_loc1_,LanguageMgr.GetTranslation("public.confirm"),LanguageMgr.GetTranslation("public.cancel"),true,false,false,2,"USEBINDPOINT_ALERT");
         }
         else
         {
            showLockAlertBack(true,_lockUseBind);
         }
      }
      
      private function showLockAlertBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:SelectedButton = null;
         if(param1)
         {
            _lockUseBind = param2;
            _loc3_ = clickIndex == 1 ? _tattooLockBtn1 : _tattooLockBtn2;
            _loc3_.selected = true;
            switchState();
            refreshPoint();
         }
      }
      
      private function checkBuyLockBack(param1:Boolean) : void
      {
         _lockUseBind = param1;
         var _loc2_:SelectedButton = clickIndex == 1 ? _tattooLockBtn1 : _tattooLockBtn2;
         _loc2_.selected = true;
         switchState();
         refreshPoint();
      }
      
      private function switchState() : void
      {
         var _loc2_:Boolean = false;
         var _loc1_:Boolean = false;
         if(clickIndex == 1)
         {
            (holes[_index] as TattooHole).isLockAdd = !(holes[_index] as TattooHole).isLockAdd;
            _loc2_ = Boolean((holes[_index] as TattooHole).isLockAdd);
            _nowTattooAddPropertyTxt.setFrame(_loc2_ ? 2 : 1);
         }
         else if(clickIndex == 2)
         {
            (holes[_index] as TattooHole).isLockReduce = !(holes[_index] as TattooHole).isLockReduce;
            _loc1_ = Boolean((holes[_index] as TattooHole).isLockReduce);
            _nowTattooReducePropertyTxt.setFrame(_loc1_ ? 2 : 1);
         }
      }
      
      private function __autoBuySelectButtonClickHandler(param1:MouseEvent) : void
      {
         if(_autoBuySelectButton.selected)
         {
            showBuyAlert();
            return;
         }
         refreshPoint();
      }
      
      private function showBuyAlert() : void
      {
         _autoBuySelectButton.selected = false;
         var _loc2_:String = LanguageMgr.GetTranslation("TattooPopFrame.autoBuyPrompt");
         var _loc1_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         NotAlertManager.ins.needAlert("TattooPopFrame.autoBuy",startBuyAlertBack,_loc1_,_loc2_);
      }
      
      private function startBuyAlertBack(param1:Boolean) : void
      {
         _autoBuyUseBind = param1;
         _autoBuySelectButton.selected = true;
         refreshPoint();
      }
      
      private function refreshPoint() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         calcStillNeedPoint();
         _costText.text = lockNeedPoints + autoBuyNeedPoints + "";
         _costText2.text = lockNeedPoints + autoBuyNeedPoints2 + "";
         _smallPointImg.x = _costText.x + _costText.textWidth + 9;
         _smallPointImg2.x = _costText2.x + _costText2.textWidth + 9;
         if(!_autoBuySelectButton.selected)
         {
            _loc3_ = int(tattooController.tattooModel.tattooDyeTempId);
            _loc1_ = int(tattooController.tattooModel.seniorTattooDyeTempId);
            _loc4_ = int(GoodsManager.instance.getBagCountByTempId(1,_loc3_));
            _loc2_ = int(GoodsManager.instance.getBagCountByTempId(1,_loc1_));
            _tattooStripView.visible = _loc4_ < costNum;
            _tattooBtn.enable = _loc4_ >= costNum;
            _seniorTattooStripView.visible = _loc2_ < costNum;
            _seniorTattooBtn.enable = _loc2_ >= costNum;
         }
         else
         {
            _tattooBtn.enable = hasEnoughPoints(1);
            _tattooStripView.visible = !_tattooBtn.enable;
            _seniorTattooBtn.enable = hasEnoughPoints(2);
            _seniorTattooStripView.visible = !_seniorTattooBtn.enable;
         }
      }
      
      private function __onReplaceAttriBtnClick(param1:MouseEvent) : void
      {
         tattooController.sendReplace(tattooController.tattooModel.currHoleIndex);
      }
      
      private function __onTattooBtnClick(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         tattooType = 1;
         if(_oldAddValue >= model.getSeniorTattooMaxAddValue())
         {
            _loc3_ = LanguageMgr.GetTranslation("tattoo.TattooPopFrame.tattoo5000");
            SharedManagerHelper.ins.needAlert("TattooPopFrame.tattoo5000",checkAvailableReplace,LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt"),_loc3_);
         }
         else if(_oldAddValue >= model.getPrimaryTattooMaxAddValue())
         {
            _loc2_ = LanguageMgr.GetTranslation("tattoo.TattooPopFrame.tattoo2000");
            SharedManagerHelper.ins.needAlert("TattooPopFrame.tattoo2000",checkAvailableReplace,LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt"),_loc2_);
         }
         else
         {
            checkAvailableReplace();
         }
      }
      
      private function __onSeniorTattooBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         tattooType = 2;
         if(_oldAddValue >= model.getSeniorTattooMaxAddValue())
         {
            _loc2_ = LanguageMgr.GetTranslation("tattoo.TattooPopFrame.tattoo5000");
            SharedManagerHelper.ins.needAlert("TattooPopFrame.tattoo5000",checkAvailableReplace,LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt"),_loc2_);
         }
         else
         {
            checkAvailableReplace();
         }
      }
      
      private function checkAvailableReplace() : void
      {
         var _loc3_:TodayNotAlertFrame = null;
         var _loc2_:String = null;
         var _loc1_:String = null;
         if(_notAlert)
         {
            tattooBtnClickCallback();
            return;
         }
         if(_replaceAttriBtn.visible)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("store.RefreshBuyAlertFrame");
            _loc2_ = LanguageMgr.GetTranslation("tattoo.TattooPopFrame.existsAvailableReplace");
            _loc1_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc3_.show(_loc2_,_loc1_,tattooBtnClickCallback);
         }
         else
         {
            tattooBtnClickCallback();
         }
      }
      
      private function tattooBtnClickCallback(param1:Boolean = false) : void
      {
         if(param1)
         {
            _notAlert = true;
         }
         calcStillNeedPoint();
         checkPointsAndDoFresh();
      }
      
      private function calcStillNeedPoint() : void
      {
         var _loc9_:* = null;
         var _loc3_:ShopGoodsInfo = null;
         var _loc12_:int = 0;
         var _loc8_:ShopGoodsInfo = null;
         var _loc13_:int = 0;
         var _loc4_:int = int(tattooController.tattooModel.tattooDyeTempId);
         var _loc1_:int = int(tattooController.tattooModel.seniorTattooDyeTempId);
         var _loc5_:int = int(GoodsManager.instance.getBagCountByTempId(1,_loc4_));
         var _loc2_:int = int(GoodsManager.instance.getBagCountByTempId(1,_loc1_));
         var _loc10_:int = 100;
         var _loc7_:Boolean = Boolean((holes[_index] as TattooHole).isLockAdd);
         var _loc11_:Boolean = Boolean((holes[_index] as TattooHole).isLockReduce);
         lockNeedPoints = 0;
         var _loc6_:int = int(ConfigInfoManager.instance.getKeyToInt("tattoo_refresh_lock_price"));
         if(_loc7_)
         {
            lockNeedPoints += _loc6_;
         }
         if(_loc11_)
         {
            lockNeedPoints += _loc6_;
         }
         autoBuyNeedPoints = 0;
         autoBuyNeedPoints2 = 0;
         if(_autoBuySelectButton.selected && _loc5_ < _loc10_)
         {
            _loc3_ = TempleteManager.instance.getShopTempInfoByItemId(_loc4_);
            _loc12_ = int(_loc3_.GiftToken);
            autoBuyNeedPoints = (_loc10_ - _loc5_) * _loc12_;
         }
         if(_autoBuySelectButton.selected && _loc2_ < _loc10_)
         {
            _loc8_ = TempleteManager.instance.getShopTempInfoByItemId(_loc1_);
            _loc13_ = int(_loc8_.GiftToken);
            autoBuyNeedPoints2 = (_loc10_ - _loc2_) * _loc13_;
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function checkPointsAndDoFresh() : void
      {
         if(!hasEnoughPoints(tattooType))
         {
            RechargeAlertMannager.show();
            return;
         }
         var _loc2_:int = int(tattooController.tattooModel.currHoleIndex);
         var _loc3_:Boolean = Boolean((holes[_index] as TattooHole).isLockAdd);
         var _loc1_:Boolean = Boolean((holes[_index] as TattooHole).isLockReduce);
         var _loc4_:Boolean = Boolean(_autoBuySelectButton.selected);
         tattooController.sendRefresh(tattooType,_loc2_,_lockUseBind ? 2 : 1,_autoBuyUseBind ? 2 : 1,_loc3_,_loc1_,_loc4_);
      }
      
      private function hasEnoughPoints(param1:int) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(_autoBuyUseBind)
         {
            _loc2_ += param1 == 1 ? autoBuyNeedPoints : autoBuyNeedPoints2;
         }
         else
         {
            _loc3_ += param1 == 1 ? autoBuyNeedPoints : autoBuyNeedPoints2;
         }
         if(_lockUseBind)
         {
            _loc2_ += lockNeedPoints;
         }
         else
         {
            _loc3_ += lockNeedPoints;
         }
         if(playerInfo.point < _loc3_)
         {
            return false;
         }
         if(playerInfo.point + playerInfo.giftToken < _loc3_ + _loc2_)
         {
            return false;
         }
         return true;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _replaceAttriBtn.removeEventListener("click",__onReplaceAttriBtnClick);
         _tattooBtn.removeEventListener("click",__onReplaceAttriBtnClick);
         _seniorTattooBtn.removeEventListener("click",__onReplaceAttriBtnClick);
         _autoBuySelectButton.removeEventListener("click",__autoBuySelectButtonClickHandler);
         _tattooLockBtn1.removeEventListener("click",__tattooLockBtn1ClickHandler);
         _tattooLockBtn2.removeEventListener("click",__tattooLockBtn2ClickHandler);
         MsgMan.removeObserver("TATTOO_INFO",this,updateTattooInfo);
      }
      
      private function updateTattooInfo(param1:String, param2:Object) : void
      {
         refresh();
         refreshPoint();
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         if(!_rect)
         {
            _rect = new Rectangle(0,0,500,456);
         }
         return _rect;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get tattooController() : TattooController
      {
         return FrameControllerManager.instance.tattooController;
      }
      
      private function get model() : TattooModel
      {
         return FrameControllerManager.instance.tattooController.tattooModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_tattooMainBg);
         _tattooMainBg = null;
         ObjectUtils.disposeObject(_nowTattoo);
         _nowTattoo = null;
         ObjectUtils.disposeObject(_newTattoo);
         _newTattoo = null;
         ObjectUtils.disposeObject(_questionBg);
         _questionBg = null;
         ObjectUtils.disposeObject(_questionBg2);
         _questionBg2 = null;
         ObjectUtils.disposeObject(_replaceAttriBtn);
         _replaceAttriBtn = null;
         ObjectUtils.disposeObject(_tattooBtn);
         _tattooBtn = null;
         ObjectUtils.disposeObject(_seniorTattooBtn);
         _seniorTattooBtn = null;
         ObjectUtils.disposeObject(_nowTattooNameTxt);
         _nowTattooNameTxt = null;
         ObjectUtils.disposeObject(_newTattooNameTxt);
         _newTattooNameTxt = null;
         ObjectUtils.disposeObject(_nowTattooAddPropertyTxt);
         _nowTattooAddPropertyTxt = null;
         ObjectUtils.disposeObject(_newTattooPropertyTxt);
         _newTattooPropertyTxt = null;
         ObjectUtils.disposeObject(_tattooCountTxt);
         _tattooCountTxt = null;
         ObjectUtils.disposeObject(_seniorTattooCountTxt);
         _seniorTattooCountTxt = null;
         super.dispose();
      }
   }
}

