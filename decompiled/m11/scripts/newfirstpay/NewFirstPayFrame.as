package newfirstpay
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.NewFirstPayManager;
   import mvc.module.newfirstpay.NewFirstPayModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.NewFirstPlayInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class NewFirstPayFrame extends Frame implements IManualSize
   {
      
      private var _bg:ScaleFrameImage;
      
      private var _btn1:SelectedIconButton;
      
      private var _btn2:SelectedIconButton;
      
      private var _btn3:SelectedIconButton;
      
      private var _group:SelectedButtonGroup;
      
      private var _groupRedList:Vector.<Image>;
      
      private var _txtBtp:Bitmap;
      
      private var _mc:MovieClip;
      
      private var _loadTxt:Bitmap;
      
      private var _isLoading:Boolean = false;
      
      private var _waitMcPath:String;
      
      private var thane:ThaneInfo;
      
      private var _dayBtn1:SelectedTextButton;
      
      private var _dayBtn2:SelectedTextButton;
      
      private var _dayBtn3:SelectedTextButton;
      
      private var _dayGroup:SelectedButtonGroup;
      
      private var _dayRedList:Vector.<Image>;
      
      private var _rewardsHBox:HBox;
      
      private var _rewardsPanel:ScrollPanel;
      
      private var _swfContainer:Sprite;
      
      private var _txtContainer:Sprite;
      
      private var _hasGetFlg:Bitmap;
      
      private var _pointDesTxt:FilterFrameText;
      
      private var _btn:BaseButton;
      
      private var _btnIcon:ScaleFrameImage;
      
      private var _pointArr:Array = [];
      
      public function NewFirstPayFrame()
      {
         super();
         initView();
         addEvent();
         _group.selectIndex = 0;
         refreshRewardState();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,830,503);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc1_:Image = null;
         var _loc2_:int = 0;
         titleText = LanguageMgr.GetTranslation("newfirstpay.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("newfirstpay.bg");
         _btn1 = ComponentFactory.Instance.creatComponentByStylename("NewFirstPayFrame.btn1");
         _btn2 = ComponentFactory.Instance.creatComponentByStylename("NewFirstPayFrame.btn2");
         _btn3 = ComponentFactory.Instance.creatComponentByStylename("NewFirstPayFrame.btn3");
         _txtBtp = ComponentFactory.Instance.creatBitmap("asset.newfirstpay.txtBtp");
         _dayBtn1 = ComponentFactory.Instance.creatComponentByStylename("NewFirstPayFrame.dayBtn1");
         _dayBtn2 = ComponentFactory.Instance.creatComponentByStylename("NewFirstPayFrame.dayBtn2");
         _dayBtn3 = ComponentFactory.Instance.creatComponentByStylename("NewFirstPayFrame.dayBtn3");
         _rewardsHBox = ComponentFactory.Instance.creatComponentByStylename("NewFirstPayFrame.RewardsHBox");
         _rewardsPanel = ComponentFactory.Instance.creatComponentByStylename("NewFirstPayFrame.panel");
         _hasGetFlg = ComponentFactory.Instance.creatBitmap("asset.newfirstpay.hasGetTxt");
         _pointDesTxt = ComponentFactory.Instance.creatComponentByStylename("ui.newfirstpay.pointDesTxt");
         _btn = ComponentFactory.Instance.creatComponentByStylename("ui.newfirstpay.Btn");
         _btnIcon = ComponentFactory.Instance.creatComponentByStylename("ui.newfirstpay.btnImg");
         _swfContainer = new Sprite();
         _txtContainer = new Sprite();
         _swfContainer.mouseEnabled = false;
         _txtContainer.mouseEnabled = false;
         _hasGetFlg.visible = false;
         _groupRedList = new Vector.<Image>();
         _dayRedList = new Vector.<Image>();
         addToContent(_bg);
         addToContent(_txtContainer);
         addToContent(_swfContainer);
         addToContent(_btn1);
         addToContent(_btn2);
         addToContent(_btn3);
         addToContent(_txtBtp);
         addToContent(_dayBtn1);
         addToContent(_dayBtn2);
         addToContent(_dayBtn3);
         addToContent(_rewardsHBox);
         addToContent(_rewardsPanel);
         addToContent(_pointDesTxt);
         addToContent(_hasGetFlg);
         addToContent(_btn);
         _btn.addChild(_btnIcon);
         _btnIcon.setFrame(1);
         _rewardsPanel.setView(_rewardsHBox);
         thane = ArmyManager.instance.thane;
         _group = new SelectedButtonGroup();
         _group.addSelectItem(_btn1);
         _group.addSelectItem(_btn2);
         _group.addSelectItem(_btn3);
         _dayGroup = new SelectedButtonGroup();
         _dayGroup.addSelectItem(_dayBtn1);
         _dayGroup.addSelectItem(_dayBtn2);
         _dayGroup.addSelectItem(_dayBtn3);
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ui.newfirstpay.groupRed" + _loc2_);
            addToContent(_loc1_);
            _groupRedList[_loc2_] = _loc1_;
            _loc1_.visible = false;
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ui.newfirstpay.dayRed" + _loc2_);
            addToContent(_loc1_);
            _dayRedList[_loc2_] = _loc1_;
            _loc1_.visible = false;
            _loc2_++;
         }
         var _loc3_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("newFirstPay_eachQuality_diamonds");
         if(_loc3_)
         {
            _pointArr = _loc3_.ConfigValue.split(",");
         }
         _dayBtn1.text = LanguageMgr.GetTranslation("newfirstpay.btn1");
         _dayBtn2.text = LanguageMgr.GetTranslation("newfirstpay.btn2");
         _dayBtn3.text = LanguageMgr.GetTranslation("newfirstpay.btn3");
      }
      
      private function refreshLoadTxt(param1:String) : void
      {
         clearLoading();
         ObjectUtils.disposeAllChildren(_txtContainer);
         var _loc2_:String = PathManager.resourcePath + param1;
         LoaderManagerII.instance.load(_loc2_,2,4,onLoadCompleteHandler);
         _isLoading = true;
      }
      
      private function refreshMc(param1:String) : void
      {
         clearLoading();
         ObjectUtils.disposeAllChildren(_swfContainer);
         var _loc2_:String = PathManager.resourcePath + param1;
         LoaderManagerII.instance.load(_loc2_,2,4,onLoadCompleteHandler);
         _isLoading = true;
      }
      
      private function clearLoading() : void
      {
         if(_isLoading)
         {
            LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(onLoadCompleteHandler);
            _isLoading = false;
         }
      }
      
      private function clearMC() : void
      {
         if(_mc != null)
         {
            if(_mc.parent != null)
            {
               _mc.parent.removeChild(_mc);
            }
            _mc.stop();
            _mc = null;
         }
      }
      
      private function onLoadCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         _isLoading = false;
         if(param2 is MovieClip)
         {
            clearMC();
            _mc = param2 as MovieClip;
            _mc.play();
            _mc.x = 165;
            _mc.y = 60;
            _mc.mouseEnabled = false;
            _mc.mouseChildren = false;
            _swfContainer.addChild(_mc);
         }
         else if(param2 is Bitmap)
         {
            _loadTxt = param2 as Bitmap;
            _loadTxt.x = 380;
            _loadTxt.y = 35;
            _txtContainer.addChild(_loadTxt);
            refreshMc(_waitMcPath);
         }
      }
      
      private function refreshItem(param1:String) : void
      {
         var _loc6_:GoodsInfo = null;
         var _loc4_:BaseItemView = null;
         var _loc3_:Array = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         ObjectUtils.disposeAllChildren(_rewardsHBox);
         if(param1 == null || param1 == "")
         {
            return;
         }
         var _loc2_:Array = param1.split("|");
         var _loc5_:int = int(_loc2_.length);
         _rewardsHBox.beginChanges();
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _loc7_ = _loc2_[_loc8_];
            _loc3_ = _loc7_.split(",");
            _loc4_ = ComponentFactory.Instance.creatCustomObject("core.normal.BaseItemView");
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = int(_loc3_[0]);
            _loc6_.count = int(_loc3_[1]);
            _loc4_.data = _loc6_;
            _rewardsHBox.addChild(_loc4_);
            _loc8_++;
         }
         _rewardsHBox.commitChanges();
         _rewardsPanel.invalidateViewport();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _group.addEventListener("change",groupChangeHandler);
         _dayGroup.addEventListener("change",dayChangeHandler);
         model.addEventListener("change",refreshRewardState);
         _btn.addEventListener("click",btnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _group.removeEventListener("change",groupChangeHandler);
         _dayGroup.removeEventListener("change",dayChangeHandler);
         model.removeEventListener("change",refreshRewardState);
         _btn.removeEventListener("click",btnClickHandler);
      }
      
      private function btnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:int = _group.selectIndex + 1;
         var _loc5_:int = _dayGroup.selectIndex + 1;
         var _loc3_:Array = model.rewardState[_loc2_ - 1];
         var _loc4_:String = _loc3_[_loc5_ - 1];
         if(_loc4_ == "0")
         {
            RechargeAlertMannager.navigateToRechargePage();
         }
         else if(_loc4_ == "1")
         {
            NewFirstPayManager.instance.sendGetReward(_loc2_,_loc5_);
         }
      }
      
      private function refreshRewardState(param1:Event = null) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = model.rewardState;
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _groupRedList[_loc3_].visible = checkIsRed(_loc2_[_loc3_]);
            _loc3_++;
         }
         var _loc4_:int = _dayGroup.selectIndex + 1;
         refreshDayState(_loc4_);
      }
      
      private function checkIsRed(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return false;
         }
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_] == "1")
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function get model() : NewFirstPayModel
      {
         return NewFirstPayManager.instance.model;
      }
      
      private function groupChangeHandler(param1:Event) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = _group.selectIndex + 1;
         var _loc6_:int = _dayGroup.selectIndex < 0 ? 1 : _dayGroup.selectIndex + 1;
         var _loc5_:NewFirstPlayInfo = TempleteManager.instance.newFirstPlayCate.getTemplate(thane.templateInfo.Sexs,thane.templateInfo.Job,_loc2_,_loc6_);
         if(_loc5_)
         {
            _waitMcPath = _loc5_.AvatarPath;
            refreshLoadTxt(_loc5_.ImagePath);
            if(_dayGroup.lastSelectedButton != null)
            {
               if(_dayGroup.selectIndex == 0)
               {
                  refreshDayGoods(1);
                  refreshDayState(1);
               }
               else
               {
                  _dayGroup.selectIndex = 0;
               }
            }
            else
            {
               _dayGroup.selectIndex = 0;
            }
         }
         var _loc4_:int = int(_pointArr[_loc2_ - 1]) - model.chargeNum;
         if(_loc4_ > 0)
         {
            _loc3_ = "newfirstpay.point";
            if(_loc2_ == 1 && model.chargeNum == 0)
            {
               _loc3_ = "newfirstpay.point1";
            }
            _pointDesTxt.text = LanguageMgr.GetTranslation(_loc3_,_loc4_);
         }
         else
         {
            _pointDesTxt.text = "";
         }
         _bg.setFrame(_group.selectIndex + 1);
      }
      
      private function dayChangeHandler(param1:Event) : void
      {
         var _loc2_:int = _dayGroup.selectIndex + 1;
         refreshDayGoods(_loc2_);
         refreshDayState(_loc2_);
      }
      
      private function refreshDayGoods(param1:int) : void
      {
         var _loc2_:int = _group.selectIndex + 1;
         var _loc3_:NewFirstPlayInfo = TempleteManager.instance.newFirstPlayCate.getTemplate(thane.templateInfo.Sexs,thane.templateInfo.Job,_loc2_,param1);
         refreshItem(_loc3_.Item);
      }
      
      private function refreshDayState(param1:int) : void
      {
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = _group.selectIndex + 1;
         var _loc3_:Array = model.rewardState[_loc2_ - 1];
         if(_loc3_)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc3_.length)
            {
               _dayRedList[_loc6_].visible = _loc3_[_loc6_] == "1";
               _loc6_++;
            }
         }
         var _loc5_:int;
         switch(_loc5_ = int(_loc3_[param1 - 1]))
         {
            case 0:
               _btn.visible = true;
               _hasGetFlg.visible = false;
               _loc4_ = int(_loc3_[0]);
               if(_loc4_ >= 1)
               {
                  _btnIcon.setFrame(2);
                  _btn.enable = false;
                  _pointDesTxt.visible = false;
               }
               else
               {
                  _btnIcon.setFrame(1);
                  _btn.enable = true;
                  _pointDesTxt.visible = true;
               }
               break;
            case 1:
               _btn.visible = true;
               _pointDesTxt.visible = false;
               _hasGetFlg.visible = false;
               _btnIcon.setFrame(2);
               _btn.enable = true;
               break;
            case 2:
               _btn.visible = false;
               _pointDesTxt.visible = false;
               _hasGetFlg.visible = true;
         }
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearMC();
         clearLoading();
         for each(var _loc1_:Image in _groupRedList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _groupRedList = null;
         for each(var _loc2_:Image in _dayRedList)
         {
            ObjectUtils.disposeObject(_loc2_);
         }
         _dayRedList = null;
         ObjectUtils.disposeViolentMc(_mc);
         _mc = null;
         ObjectUtils.disposeObject(_hasGetFlg);
         _hasGetFlg = null;
         ObjectUtils.disposeObject(_rewardsPanel);
         _rewardsPanel = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         thane = null;
         _groupRedList = null;
         _dayRedList = null;
      }
   }
}

