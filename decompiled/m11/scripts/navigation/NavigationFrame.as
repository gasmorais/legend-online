package navigation
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.TextArea;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.NavigationManager;
   import mvc.module.navigation.NavigationModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotAlertManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class NavigationFrame extends Frame implements IManualSize
   {
      
      private var border:ScaleBitmapImage;
      
      private var back:Bitmap;
      
      private var shopBtn:IconButton;
      
      private var strengthBtn:IconButton;
      
      private var strengthMc:MovieClip;
      
      private var strengthText:FilterFrameText;
      
      private var strengthImage:Bitmap;
      
      private var itemList:Vector.<NavigationBuildView>;
      
      private var fishingText:FilterFrameText;
      
      private var fishingTime:FilterFrameText;
      
      private var fishingBtn:IconButton;
      
      private var textBack:ScaleBitmapImage;
      
      private var fishRewardArea:TextArea;
      
      private var fishMc:MovieClip;
      
      private var tipTxt:FilterFrameText;
      
      private var _buyMaxCount:int;
      
      private var _buyStrengthCost:int;
      
      private var _getStrengthNum:int;
      
      private var _fishingInterval:int;
      
      public function NavigationFrame()
      {
         super();
         initView();
         initBuildView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,795,570);
      }
      
      private function initView() : void
      {
         border = ComponentFactory.Instance.creatComponentByStylename("NavigationFrame.border");
         back = ComponentFactory.Instance.creatBitmap("asset.NavigationFrame.back");
         shopBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationFrame.shopBtn");
         strengthImage = ComponentFactory.Instance.creatBitmap("asset.NavigationFrame.strengthImage");
         strengthMc = ComponentFactory.Instance.creatCustomObject("NavigationFrame.strengthMc");
         strengthText = ComponentFactory.Instance.creatComponentByStylename("NavigationFrame.strengthText");
         strengthBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationFrame.strengthBtn");
         fishingText = ComponentFactory.Instance.creatComponentByStylename("NavigationFrame.fishingText");
         fishingTime = ComponentFactory.Instance.creatComponentByStylename("NavigationFrame.fishingTime");
         fishingBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationFrame.fishingBtn");
         textBack = ComponentFactory.Instance.creatComponentByStylename("NavigationFrame.textBack");
         fishRewardArea = ComponentFactory.Instance.creatComponentByStylename("NavigationFrame.fishRewardArea");
         fishMc = ComponentFactory.Instance.creatCustomObject("NavigationFrame.fishMc");
         tipTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationFrame.fishingTipText");
         addToContent(border);
         addToContent(back);
         addToContent(shopBtn);
         addToContent(fishingText);
         addToContent(fishingTime);
         addToContent(fishingBtn);
         addToContent(fishMc);
         addToContent(textBack);
         addToContent(fishRewardArea);
         addToContent(strengthImage);
         addToContent(strengthMc);
         strengthMc.stop();
         addToContent(strengthText);
         addToContent(strengthBtn);
         addToContent(tipTxt);
         _buyMaxCount = ConfigInfoManager.instance.getNavigationStrengthBuyNum();
         _buyStrengthCost = ConfigInfoManager.instance.getNavigationStrengthBuyPoint();
         _getStrengthNum = ConfigInfoManager.instance.getNavigationStrengthMax();
         _fishingInterval = ConfigInfoManager.instance.getNavigationFishingInterval();
         fishRewardArea.htmlText = "";
         fishMc.mouseChildren = fishMc.mouseEnabled = false;
         fishMc.gotoAndPlay(1);
         tipTxt.text = LanguageMgr.GetTranslation("navigation.levaeFishing.content");
         fishingText.text = LanguageMgr.GetTranslation("NavigationFrame.fishingTime.text");
         fishingTime.htmlText = model.fishingPartShowTime;
      }
      
      private function initBuildView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:NavigationBuildView = null;
         itemList = new Vector.<NavigationBuildView>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new NavigationBuildView(_loc2_);
            addToContent(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         shopBtn.addEventListener("click",__shopClickHandler);
         strengthBtn.addEventListener("click",__strengthClickHandler);
         fishingBtn.addEventListener("click",__fishingClickHandler);
         MsgMan.addObserver("NAVIGATION_DATA_CHANGE",this,__updateDataHandler);
         MsgMan.addObserver("FISHING_STATE_CHANGE",this,__updateFishingViewHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(shopBtn)
         {
            shopBtn.removeEventListener("click",__shopClickHandler);
         }
         if(strengthBtn)
         {
            strengthBtn.removeEventListener("click",__strengthClickHandler);
         }
         if(fishingBtn)
         {
            fishingBtn.removeEventListener("click",__fishingClickHandler);
         }
         MsgMan.removeObserver("NAVIGATION_DATA_CHANGE",this,__updateDataHandler);
         MsgMan.removeObserver("FISHING_STATE_CHANGE",this,__updateFishingViewHandler);
      }
      
      private function __fishingClickHandler(param1:MouseEvent) : void
      {
         if(model.noFishingCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("navigation.Fishing.noCountAlert"));
            return;
         }
         var _loc2_:Object = {};
         _loc2_.type = 16;
         FrameControllerManager.instance.openControllerByInfo("navigation",7,_loc2_);
      }
      
      private function __updateDataHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __updateFishingViewHandler(param1:String, param2:Object) : void
      {
         refreshFishView();
      }
      
      private function __shopClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("shop",9001);
      }
      
      private function __strengthClickHandler(param1:MouseEvent) : void
      {
         if(model.hasBuyStrengthNum >= _buyMaxCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("navigation.NavigationShopGoodsItem.noBuyCount.Alert"));
            return;
         }
         var _loc3_:int = _buyMaxCount - model.hasBuyStrengthNum;
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
         var _loc4_:String = LanguageMgr.GetTranslation("navigation.NavigationFrame.buyStrength.alertText",_buyStrengthCost,_getStrengthNum,_loc3_);
         NotAlertManager.ins.needAlert("navigation.NavigationFrame.buyStrength.alert",buyStrengthResultHandler,_loc2_,_loc4_);
      }
      
      private function buyStrengthResultHandler(param1:Boolean) : void
      {
         if(!LogicUtils.judgePointEnoughToShowPay(_buyStrengthCost,param1))
         {
            return;
         }
         var _loc2_:int = param1 ? 0 : 1;
         NavigationManager.instance.sendNavigationOperate(8,"","",_loc2_);
      }
      
      private function refreshView() : void
      {
         var _loc3_:Object = null;
         var _loc2_:int = 0;
         var _loc1_:int = model.strength * 100 / _getStrengthNum;
         strengthMc.gotoAndStop(_loc1_);
         strengthText.text = model.strength.toString();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            if(_loc2_ != 0)
            {
               _loc3_ = model.portList[_loc2_ - 1];
            }
            itemList[_loc2_].data = _loc3_;
            _loc2_++;
         }
         refreshFishView();
      }
      
      private function refreshFishView() : void
      {
         var _loc1_:String = null;
         fishRewardArea.beginChanges();
         if(model.fishOpen)
         {
            fishingBtn.visible = true;
            tipTxt.visible = true;
            fishRewardArea.visible = true;
            textBack.visible = true;
            fishMc.visible = true;
            if(model.isBoatFishing)
            {
               fishingBtn.enable = false;
               fishMc.gotoAndPlay(1);
            }
            else
            {
               fishingBtn.enable = true;
               fishMc.gotoAndStop(1);
            }
            _loc1_ = "";
            for each(var _loc2_:String in model.fishRewardList)
            {
               _loc1_ += _loc2_ + "\n";
            }
            _loc1_ = _loc1_.substring(0,_loc1_.lastIndexOf("\n"));
            fishRewardArea.htmlText = _loc1_;
         }
         else
         {
            tipTxt.visible = false;
            fishingBtn.visible = false;
            textBack.visible = false;
            fishRewardArea.visible = false;
            fishMc.visible = false;
            fishMc.gotoAndStop(1);
         }
         fishRewardArea.commitChanges();
         fishRewardArea.invalidateViewport(true);
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
      
      private function leaveFishingHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         dispose();
      }
      
      private function get model() : NavigationModel
      {
         return NavigationManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("navigation.NavigationFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(border)
         {
            ObjectUtils.disposeObject(border);
         }
         border = null;
         if(shopBtn)
         {
            ObjectUtils.disposeObject(shopBtn);
         }
         shopBtn = null;
         if(strengthBtn)
         {
            ObjectUtils.disposeObject(strengthBtn);
         }
         strengthBtn = null;
         if(strengthImage)
         {
            ObjectUtils.disposeObject(strengthImage);
         }
         strengthImage = null;
         if(strengthText)
         {
            ObjectUtils.disposeObject(strengthText);
         }
         strengthText = null;
         if(strengthMc)
         {
            ObjectUtils.disposeViolentMc(strengthMc);
         }
         strengthMc = null;
         if(fishRewardArea)
         {
            ObjectUtils.disposeObject(fishRewardArea);
         }
         fishRewardArea = null;
         if(textBack)
         {
            ObjectUtils.disposeObject(textBack);
         }
         textBack = null;
         if(fishMc)
         {
            ObjectUtils.disposeViolentMc(fishMc);
         }
         fishMc = null;
         if(fishingBtn)
         {
            ObjectUtils.disposeObject(fishingBtn);
         }
         fishingBtn = null;
         if(fishingTime)
         {
            ObjectUtils.disposeObject(fishingTime);
         }
         fishingTime = null;
         if(fishingText)
         {
            ObjectUtils.disposeObject(fishingText);
         }
         fishingText = null;
         ObjectUtils.disposeObject(tipTxt);
         tipTxt = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

