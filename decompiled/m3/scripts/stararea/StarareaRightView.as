package stararea
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.stararea.StarareaManager;
   import mvc.module.stararea.StarareaModel;
   import mvc.module.stararea.event.StarareaEvent;
   import yishi.utils.FlickerHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class StarareaRightView extends Component
   {
      
      private var _txtRlightCount:FilterFrameText;
      
      private var _txtRkeyCount:FilterFrameText;
      
      private var _txtRinfo:FilterFrameText;
      
      private var _txtRscoreStr1:FilterFrameText;
      
      private var _txtRscoreStr2:FilterFrameText;
      
      private var _txtRscoreValue1:FilterFrameText;
      
      private var _txtRscoreValue2:FilterFrameText;
      
      private var _txtRactionPower:FilterFrameText;
      
      private var _bit0:Bitmap;
      
      private var _Rbg1:MutipleImage;
      
      private var _bit1:Bitmap;
      
      private var _Rbg3:MutipleImage;
      
      private var _bit2:Bitmap;
      
      private var _Rbg2:MutipleImage;
      
      private var _bit3:Bitmap;
      
      private var _bit4:Bitmap;
      
      private var _bit5:Bitmap;
      
      private var _btnOut:BaseButton;
      
      private var _btnIn:BaseButton;
      
      private var _btnLight:Sprite;
      
      private var _btnKey:Sprite;
      
      private var w:int = 213;
      
      public function StarareaRightView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",resizeHandler);
         _btnIn.addEventListener("click",onClickIn);
         _btnOut.addEventListener("click",onClickOut);
         StarareaManager.instance.addEventListener("UPDATE_DATA",updateData);
         _btnLight.addEventListener("click",lightClickHandler);
         _btnKey.addEventListener("click",keyHandler);
         StarareaManager.instance.addEventListener("UPDATE_NODES",updateNodesHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",resizeHandler);
         _btnIn.removeEventListener("click",onClickIn);
         _btnOut.removeEventListener("click",onClickOut);
         StarareaManager.instance.removeEventListener("UPDATE_DATA",updateData);
         _btnLight.removeEventListener("click",lightClickHandler);
         _btnKey.removeEventListener("click",keyHandler);
         StarareaManager.instance.removeEventListener("UPDATE_NODES",updateNodesHandler);
      }
      
      private function updateNodesHandler(param1:StarareaEvent = null) : void
      {
         FlickerHelper.clearFilcker(_btnLight);
         FlickerHelper.clearFilcker(_btnKey);
      }
      
      private function lightClickHandler(param1:MouseEvent) : void
      {
         if(model.lightCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("stararea.nolight"));
            return;
         }
         FlickerHelper.clearFilcker(_btnLight);
         FlickerHelper.clearFilcker(_btnKey);
         var _loc2_:Boolean = Boolean(model.isLight);
         _loc2_ = !_loc2_;
         model.isLight = _loc2_;
         if(_loc2_)
         {
            model.isKey = false;
            FlickerHelper.setFilcker(_btnLight);
         }
      }
      
      private function keyHandler(param1:MouseEvent) : void
      {
         if(model.keyCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("stararea.nokey"));
            return;
         }
         FlickerHelper.clearFilcker(_btnLight);
         FlickerHelper.clearFilcker(_btnKey);
         var _loc2_:Boolean = Boolean(model.isKey);
         _loc2_ = !_loc2_;
         model.isKey = _loc2_;
         if(_loc2_)
         {
            model.isLight = false;
            FlickerHelper.setFilcker(_btnKey);
         }
      }
      
      private function updateData(param1:StarareaEvent = null) : void
      {
         _txtRkeyCount.text = "" + model.keyCount;
         _txtRlightCount.text = "" + model.lightCount;
         _txtRscoreStr1.text = LanguageMgr.GetTranslation("stararea.str2",model.boxScore1);
         _txtRscoreStr2.text = LanguageMgr.GetTranslation("stararea.str3",model.boxScore2);
         _txtRscoreValue1.text = model.totalSmallBox - model.mySmallBoxCount + "/" + model.totalSmallBox;
         _txtRscoreValue2.text = model.totalBigBox - model.myBigBoxCount + "/" + model.totalBigBox;
         _txtRactionPower.text = model.actionPower + "/" + model.totalActionPower;
         _txtRinfo.text = LanguageMgr.GetTranslation("stararea.str1",92 - 4 - model.totalSmallBox,model.boxScore1,4 + model.totalSmallBox,model.boxScore2);
      }
      
      private function onClickOut(param1:MouseEvent) : void
      {
         w = 213;
         resizeHandler();
         _btnOut.visible = false;
         _btnIn.visible = true;
      }
      
      private function onClickIn(param1:MouseEvent) : void
      {
         w = 30;
         resizeHandler();
         _btnOut.visible = true;
         _btnIn.visible = false;
      }
      
      private function initView() : void
      {
         _txtRlightCount = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.txtRlightCount");
         _txtRkeyCount = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.txtRkeyCount");
         _txtRinfo = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.txtRinfo");
         _txtRscoreStr1 = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.txtRscoreStr1");
         _txtRscoreStr2 = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.txtRscoreStr2");
         _txtRscoreValue1 = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.txtRscoreValue1");
         _txtRscoreValue2 = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.txtRscoreValue2");
         _txtRactionPower = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.txtRactionPower");
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.stararea.bg2");
         _Rbg1 = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.Rbg1");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.stararea.str1");
         _Rbg3 = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.Rbg3");
         _bit2 = ComponentFactory.Instance.creatBitmap("asset.stararea.str2");
         _Rbg2 = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.Rbg2");
         _bit3 = ComponentFactory.Instance.creatBitmap("asset.stararea.str5");
         _bit4 = ComponentFactory.Instance.creatBitmap("asset.stararea.icon.light2");
         _bit5 = ComponentFactory.Instance.creatBitmap("asset.stararea.icon.key2");
         _btnOut = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.btnOut");
         _btnIn = ComponentFactory.Instance.creatComponentByStylename("ui.stararea.btnIn");
         _btnLight = new Sprite();
         _btnKey = new Sprite();
         addChild(_bit0);
         addChild(_Rbg1);
         addChild(_bit1);
         addChild(_Rbg3);
         addChild(_bit2);
         addChild(_Rbg2);
         addChild(_bit3);
         addChild(_btnLight);
         addChild(_btnKey);
         addChild(_txtRlightCount);
         addChild(_txtRkeyCount);
         addChild(_txtRinfo);
         addChild(_txtRscoreStr1);
         addChild(_txtRscoreStr2);
         addChild(_txtRscoreValue1);
         addChild(_txtRscoreValue2);
         addChild(_txtRactionPower);
         addChild(_btnOut);
         addChild(_btnIn);
         _btnLight.addChild(_bit4);
         _btnKey.addChild(_bit5);
         _btnLight.buttonMode = true;
         _btnKey.buttonMode = true;
         _btnOut.visible = false;
         LayerManager.Instance.addToLayer(this,4);
         updateData();
         resizeHandler();
      }
      
      private function resizeHandler(param1:Event = null) : void
      {
         this.x = StageReferance.stage.stageWidth - w;
         this.y = (StageReferance.stage.stageHeight - 300) * 0.5;
      }
      
      private function get model() : StarareaModel
      {
         return StarareaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         FlickerHelper.clearFilcker(_btnLight);
         FlickerHelper.clearFilcker(_btnKey);
         removeEvent();
         ObjectUtils.disposeObject(_txtRlightCount);
         _txtRlightCount = null;
         ObjectUtils.disposeObject(_txtRkeyCount);
         _txtRkeyCount = null;
         ObjectUtils.disposeObject(_txtRinfo);
         _txtRinfo = null;
         ObjectUtils.disposeObject(_txtRscoreStr1);
         _txtRscoreStr1 = null;
         ObjectUtils.disposeObject(_txtRscoreStr2);
         _txtRscoreStr2 = null;
         ObjectUtils.disposeObject(_txtRscoreValue1);
         _txtRscoreValue1 = null;
         ObjectUtils.disposeObject(_txtRscoreValue2);
         _txtRscoreValue2 = null;
         ObjectUtils.disposeObject(_txtRactionPower);
         _txtRactionPower = null;
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_Rbg1);
         _Rbg1 = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_Rbg3);
         _Rbg3 = null;
         ObjectUtils.disposeObject(_bit2);
         _bit2 = null;
         ObjectUtils.disposeObject(_Rbg2);
         _Rbg2 = null;
         ObjectUtils.disposeObject(_bit3);
         _bit3 = null;
         ObjectUtils.disposeObject(_bit4);
         _bit4 = null;
         ObjectUtils.disposeObject(_bit5);
         _bit5 = null;
         ObjectUtils.disposeObject(_btnOut);
         _btnOut = null;
         ObjectUtils.disposeObject(_btnIn);
         _btnIn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

