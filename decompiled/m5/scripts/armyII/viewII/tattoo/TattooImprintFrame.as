package armyII.viewII.tattoo
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.tattoo.TattooModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.ConfigManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class TattooImprintFrame extends Frame implements IManualSize
   {
      
      private var border:ScaleBitmapImage;
      
      private var back:MutipleImage;
      
      private var arrowImage:MutipleImage;
      
      private var needStoneText:FilterFrameText;
      
      private var needStoneCount:FilterFrameText;
      
      private var hasStoneText:FilterFrameText;
      
      private var hasStoneCount:FilterFrameText;
      
      private var stoneImage:Image;
      
      private var stoneImage2:Image;
      
      private var wishBack:MutipleImage;
      
      private var wishCost:FilterFrameText;
      
      private var wishBtn:SelectedButton;
      
      private var successText:FilterFrameText;
      
      private var alertText:FilterFrameText;
      
      private var imprintBtn:IconButton;
      
      private var holeHbox:HBox;
      
      private var itemList:Vector.<TattooNewHoleView>;
      
      private var wishPoint:int;
      
      private var holeCostArr:Array;
      
      private var needId:int;
      
      private var needCount:int;
      
      private var hasCount:int;
      
      private var curUpgrdeTemp:UpgradeTemplateInfo;
      
      public function TattooImprintFrame()
      {
         super();
         wishPoint = ConfigInfoManager.instance.getTattooEnhanceWishPoint();
         holeCostArr = ConfigInfoManager.instance.getTattooEnhanceConsumeItem();
         initView();
         initNewHoleHbox();
         addEvent();
         model.selectedNewHoleInfo = itemList[0].data;
      }
      
      private function initView() : void
      {
         border = ComponentFactory.Instance.creatComponentByStylename("TattooImprintFrame.border");
         back = ComponentFactory.Instance.creatComponentByStylename("TattooImprintFrame.back");
         arrowImage = ComponentFactory.Instance.creatComponentByStylename("TattooImprintFrame.arrowImage");
         needStoneText = ComponentFactory.Instance.creatComponentByStylename("TattooImprintFrame.needStoneText");
         needStoneCount = ComponentFactory.Instance.creatComponentByStylename("TattooImprintFrame.needStoneCount");
         hasStoneText = ComponentFactory.Instance.creatComponentByStylename("TattooImprintFrame.hasStoneText");
         hasStoneCount = ComponentFactory.Instance.creatComponentByStylename("TattooImprintFrame.hasStoneCount");
         stoneImage = ComponentFactory.Instance.creatComponentByStylename("TattooImprintFrame.stoneImage");
         stoneImage2 = ComponentFactory.Instance.creatComponentByStylename("TattooImprintFrame.stoneImage2");
         wishBack = ComponentFactory.Instance.creatComponentByStylename("TattooImprintFrame.wishBack");
         wishCost = ComponentFactory.Instance.creatComponentByStylename("TattooImprintFrame.wishCost");
         wishBtn = ComponentFactory.Instance.creatComponentByStylename("TattooImprintFrame.wishBtn");
         successText = ComponentFactory.Instance.creatComponentByStylename("TattooImprintFrame.successText");
         alertText = ComponentFactory.Instance.creatComponentByStylename("TattooImprintFrame.alertText");
         imprintBtn = ComponentFactory.Instance.creatComponentByStylename("TattooImprintFrame.imprintBtn");
         holeHbox = ComponentFactory.Instance.creatComponentByStylename("TattooImprintFrame.holeHbox");
         addToContent(border);
         addToContent(back);
         addToContent(holeHbox);
         addToContent(arrowImage);
         addToContent(needStoneText);
         addToContent(needStoneCount);
         addToContent(hasStoneText);
         addToContent(hasStoneCount);
         addToContent(stoneImage);
         addToContent(stoneImage2);
         addToContent(wishBack);
         addToContent(wishCost);
         addToContent(wishBtn);
         addToContent(successText);
         addToContent(alertText);
         addToContent(imprintBtn);
         needStoneText.text = LanguageMgr.GetTranslation("TattooImprintFrame.needStoneText.text");
         hasStoneText.text = LanguageMgr.GetTranslation("TattooImprintFrame.hasStoneText.text");
         alertText.text = LanguageMgr.GetTranslation("TattooImprintFrame.alertText.text");
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208056);
         stoneImage.tipData = _loc1_.Description;
         stoneImage2.tipData = _loc1_.Description;
      }
      
      private function initNewHoleHbox() : void
      {
         var _loc2_:int = 0;
         var _loc1_:TattooNewHoleView = null;
         itemList = new Vector.<TattooNewHoleView>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new TattooNewHoleView();
            _loc1_.data = model.holeInfoIIs[_loc2_];
            holeHbox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         imprintBtn.addEventListener("click",__imprintClickHandler);
         MsgMan.addObserver("TATTOO_NEWHOLE_INFO",this,__updateNewHoleDataHandler);
         MsgMan.addObserver("TATTOO_NEWHOLE_SELECT",this,__updateHoleSelectHandler);
         wishBtn.addEventListener("select",__wishSelectedHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         imprintBtn.removeEventListener("click",__imprintClickHandler);
         MsgMan.removeObserver("TATTOO_NEWHOLE_INFO",this,__updateNewHoleDataHandler);
         MsgMan.removeObserver("TATTOO_NEWHOLE_SELECT",this,__updateHoleSelectHandler);
         wishBtn.removeEventListener("select",__wishSelectedHandler);
      }
      
      private function __updateNewHoleDataHandler(param1:String, param2:Object) : void
      {
         refreshNewHoleHbox();
         refreshView();
      }
      
      private function __updateHoleSelectHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            if(itemList[_loc3_].data && itemList[_loc3_].data.holeId == model.selectedNewHoleInfo.holeId && itemList[_loc3_].data.enable)
            {
               itemList[_loc3_].selected = true;
            }
            else
            {
               itemList[_loc3_].selected = false;
            }
            _loc3_++;
         }
         refreshView();
      }
      
      private function __wishSelectedHandler(param1:Event) : void
      {
         var _loc3_:Array = null;
         var _loc2_:int = 0;
         if(wishBtn.selected)
         {
            successText.htmlText = LanguageMgr.GetTranslation("TattooImprintFrame.successText.text2",100);
         }
         else
         {
            if(!curUpgrdeTemp)
            {
               return;
            }
            _loc3_ = curUpgrdeTemp.TemplateName.split(",");
            _loc2_ = (int(_loc3_[0]) + int(_loc3_[1])) * 100 / (int(_loc3_[0]) + int(_loc3_[1]) + int(_loc3_[2]));
            successText.htmlText = LanguageMgr.GetTranslation("TattooImprintFrame.successText.text",_loc2_);
         }
      }
      
      private function refreshNewHoleHbox() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            itemList[_loc1_].data = model.holeInfoIIs[_loc1_] ? model.holeInfoIIs[_loc1_] : null;
            if(itemList[_loc1_].data && itemList[_loc1_].data.holeId == model.selectedNewHoleInfo.holeId && itemList[_loc1_].data.enable)
            {
               model.selectedNewHoleInfo = itemList[_loc1_].data;
               itemList[_loc1_].selected = true;
            }
            else
            {
               itemList[_loc1_].selected = false;
            }
            _loc1_++;
         }
      }
      
      private function refreshView() : void
      {
         if(!model.selectedNewHoleInfo)
         {
            return;
         }
         wishCost.text = "" + wishPoint;
         if(holeCostArr)
         {
            needId = holeCostArr[model.selectedNewHoleInfo.holeId - 1].split(",")[0];
            needCount = holeCostArr[model.selectedNewHoleInfo.holeId - 1].split(",")[1];
            hasCount = GoodsManager.instance.getGoodsNumByTempIdAndNotLock(needId);
            needStoneCount.text = "x" + needCount;
            hasStoneCount.text = "x" + hasCount;
         }
         curUpgrdeTemp = TempleteManager.instance.getTemplateByLevelAndType(model.selectedNewHoleInfo.level + 1,119);
         if(!curUpgrdeTemp)
         {
            curUpgrdeTemp = TempleteManager.instance.getTemplateByLevelAndType(model.selectedNewHoleInfo.level,119);
         }
         if(!curUpgrdeTemp)
         {
            return;
         }
         __wishSelectedHandler(null);
         wishBack.visible = wishCost.visible = wishBtn.visible = !ConfigManager.info.AAS;
      }
      
      private function getIndex() : int
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < model.holeInfoIIs.length)
         {
            if(model.selectedNewHoleInfo.holeId == model.holeInfoIIs[_loc1_])
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return 0;
      }
      
      private function __imprintClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(needCount > hasCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("TattooImprintFrame.noImprintStone.alert"));
            return;
         }
         if(wishBtn.selected)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point < wishPoint)
            {
               RechargeAlertMannager.show();
            }
            else
            {
               _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
               _loc3_ = LanguageMgr.GetTranslation("TattooImprintFrame.imprintAlert.content",wishPoint);
               SharedManagerHelper.ins.needAlert("TattooImprintFrame.imprintAlert.alert",imprintAlertHandler,_loc2_,_loc3_);
            }
         }
         else
         {
            FrameControllerManager.instance.tattooController.sendTattooImprint(model.selectedNewHoleInfo.holeId,wishBtn.selected);
         }
      }
      
      private function imprintAlertHandler() : void
      {
         FrameControllerManager.instance.tattooController.sendTattooImprint(model.selectedNewHoleInfo.holeId,wishBtn.selected);
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
      
      private function get model() : TattooModel
      {
         return FrameControllerManager.instance.tattooController.tattooModel;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("tattoo.TattooImprintFrame.title");
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,615,370);
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
         ObjectUtils.disposeObject(arrowImage);
         arrowImage = null;
         ObjectUtils.disposeObject(needStoneText);
         needStoneText = null;
         ObjectUtils.disposeObject(needStoneCount);
         needStoneCount = null;
         ObjectUtils.disposeObject(hasStoneText);
         hasStoneText = null;
         ObjectUtils.disposeObject(hasStoneCount);
         hasStoneCount = null;
         ObjectUtils.disposeObject(stoneImage);
         stoneImage = null;
         ObjectUtils.disposeObject(stoneImage2);
         stoneImage2 = null;
         ObjectUtils.disposeObject(wishBack);
         wishBack = null;
         ObjectUtils.disposeObject(wishCost);
         wishCost = null;
         ObjectUtils.disposeObject(wishBtn);
         wishBtn = null;
         ObjectUtils.disposeObject(successText);
         successText = null;
         ObjectUtils.disposeObject(alertText);
         alertText = null;
         ObjectUtils.disposeObject(imprintBtn);
         imprintBtn = null;
         ObjectUtils.disposeObject(holeHbox);
         holeHbox = null;
         if(itemList)
         {
            for(var _loc1_:String in itemList)
            {
               ObjectUtils.disposeObject(itemList[_loc1_]);
               itemList[_loc1_] = null;
            }
            itemList = null;
         }
         model.selectedNewHoleInfo = null;
         super.dispose();
      }
   }
}

