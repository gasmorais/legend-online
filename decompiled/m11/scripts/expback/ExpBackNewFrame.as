package expback
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ExpBackManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   
   public class ExpBackNewFrame extends Frame
   {
      
      private var _boardBack:ScaleBitmapImage;
      
      private var _back:Bitmap;
      
      private var _titleImage:Bitmap;
      
      private var _titleAlert:FilterFrameText;
      
      private var _expContiner:Component;
      
      private var _normalBackImage:MutipleImage;
      
      private var _doubleBackImage:MutipleImage;
      
      private var _backText:FilterFrameText;
      
      private var _costText:FilterFrameText;
      
      private var _normalExpText:Component;
      
      private var _normalCostContiner:Component;
      
      private var _expImgae:Image;
      
      private var _backText2:FilterFrameText;
      
      private var _costText2:FilterFrameText;
      
      private var _doubleExpText:Component;
      
      private var _doubleCostContiner:Component;
      
      private var _expImgae2:Image;
      
      private var _pointImage:Image;
      
      private var numBitmap1:BitmapData;
      
      private var numBitmap2:BitmapData;
      
      private var _normalBtn:IconButton;
      
      private var _doubleBtn:IconButton;
      
      private var expConfigInfo:ConfigInfosTempInfo;
      
      private var expConfigArr:Array;
      
      private var backExp:int;
      
      private var advanceBackExp:int;
      
      private var backCost:int;
      
      public function ExpBackNewFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _boardBack = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.boardBack");
         _back = ComponentFactory.Instance.creatBitmap("asset.ExpBackNewFrame.back");
         _titleImage = ComponentFactory.Instance.creatBitmap("asset.ExpBackNewFrame.titleImage");
         _titleAlert = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.titleAlert");
         _expContiner = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.expContiner");
         _normalBackImage = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.normalBackImage");
         _doubleBackImage = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.doubleBackImage");
         _backText = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.backText");
         _costText = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.costText");
         _normalExpText = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.normalExpText");
         _normalCostContiner = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.normalCostContiner");
         _expImgae = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.expImgae");
         _backText2 = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.backText");
         _costText2 = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.costText");
         _doubleExpText = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.doubleCostText");
         _doubleCostContiner = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.doubleCostContiner");
         _expImgae2 = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.expImgae");
         _pointImage = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.pointImage");
         _normalBtn = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.normalBtn");
         _doubleBtn = ComponentFactory.Instance.creatComponentByStylename("ExpBackNewFrame.doubleBtn");
         numBitmap1 = ComponentFactory.Instance.creatBitmapData("asset.expback.numComponent.bitmap1");
         numBitmap2 = ComponentFactory.Instance.creatBitmapData("asset.expback.numComponent.bitmap2");
         addToContent(_boardBack);
         addToContent(_back);
         addToContent(_titleImage);
         addToContent(_titleAlert);
         addToContent(_expContiner);
         addToContent(_normalBackImage);
         addToContent(_doubleBackImage);
         addToContent(_backText);
         addToContent(_costText);
         addToContent(_normalExpText);
         addToContent(_normalCostContiner);
         addToContent(_expImgae);
         addToContent(_backText2);
         _backText2.y = 290;
         addToContent(_costText2);
         _costText2.y = 325;
         addToContent(_doubleExpText);
         addToContent(_doubleCostContiner);
         addToContent(_expImgae2);
         _expImgae2.y = 290;
         addToContent(_pointImage);
         addToContent(_normalBtn);
         addToContent(_doubleBtn);
         _titleAlert.text = LanguageMgr.GetTranslation("expback.ExpBackNewFrame.titleAlert");
         _backText.text = LanguageMgr.GetTranslation("expback.ExpBackNewFrame.backText");
         _backText2.text = LanguageMgr.GetTranslation("expback.ExpBackNewFrame.backText");
         _costText.text = LanguageMgr.GetTranslation("expback.ExpBackNewFrame.costText");
         _costText2.text = LanguageMgr.GetTranslation("expback.ExpBackNewFrame.costText");
         expConfigInfo = TempleteManager.instance.getConfigInfoByConfigName("RecoverRate");
         expConfigArr = expConfigInfo.ConfigValue.split(",");
         refreshView();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _normalBtn.addEventListener("click",__normalClickHandler);
         _doubleBtn.addEventListener("click",__doubleClickHandler);
         NotificationManager.instance.addEventListener("RECOVER_EXP",__recoverExpChangeHandler);
      }
      
      private function __normalClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         ExpBackManager.Instance.sendExpBackRequest(0,1);
      }
      
      private function __doubleClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         SimpleAlertHelper.instance.data = [doubleClickResult];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("expback.ExpBackNewFrame.doubleClick.content",backCost,advanceBackExp);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert");
      }
      
      private function doubleClickResult(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint < backCost)
            {
               RechargeAlertMannager.show();
               return;
            }
            _loc3_ = 1;
            if(!param2)
            {
               _loc3_ = 2;
            }
            ExpBackManager.Instance.sendExpBackRequest(_loc3_,2);
         }
      }
      
      private function __recoverExpChangeHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         if(expConfigArr.length >= 2)
         {
            backExp = Math.ceil(ExpBackManager.Instance.backExp * expConfigArr[0] / 100);
            advanceBackExp = Math.ceil(ExpBackManager.Instance.backExp * expConfigArr[1] / 100);
            backCost = ExpBackManager.Instance.backExpCost;
         }
         if(backExp <= 0)
         {
            dispose();
            return;
         }
         NumberViewUtils.refreshValue(backExp,_expContiner,numBitmap1,25,31,18,25,"0123456789");
         NumberViewUtils.refreshValue(backExp,_normalExpText,numBitmap2,15,18,10,15,"0123456789");
         NumberViewUtils.refreshValue(0,_normalCostContiner,numBitmap2,15,18,10,15,"0123456789");
         NumberViewUtils.refreshValue(advanceBackExp,_doubleExpText,numBitmap2,15,18,10,15,"0123456789");
         NumberViewUtils.refreshValue(backCost,_doubleCostContiner,numBitmap2,15,18,10,15,"0123456789");
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_normalBtn)
         {
            _normalBtn.removeEventListener("click",__normalClickHandler);
         }
         if(_doubleBtn)
         {
            _doubleBtn.removeEventListener("click",__doubleClickHandler);
         }
         NotificationManager.instance.removeEventListener("RECOVER_EXP",__recoverExpChangeHandler);
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("expback.ExpBackNewFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_boardBack)
         {
            ObjectUtils.disposeObject(_boardBack);
         }
         _boardBack = null;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_titleImage)
         {
            ObjectUtils.disposeObject(_titleImage);
         }
         _titleImage = null;
         if(_titleAlert)
         {
            ObjectUtils.disposeObject(_titleAlert);
         }
         _titleAlert = null;
         if(_expContiner)
         {
            ObjectUtils.disposeObject(_expContiner);
         }
         _expContiner = null;
         if(_normalBackImage)
         {
            ObjectUtils.disposeObject(_normalBackImage);
         }
         _normalBackImage = null;
         if(_doubleBackImage)
         {
            ObjectUtils.disposeObject(_doubleBackImage);
         }
         _doubleBackImage = null;
         if(_backText)
         {
            ObjectUtils.disposeObject(_backText);
         }
         _backText = null;
         if(_costText)
         {
            ObjectUtils.disposeObject(_costText);
         }
         _costText = null;
         if(_normalExpText)
         {
            ObjectUtils.disposeObject(_normalExpText);
         }
         _normalExpText = null;
         if(_normalCostContiner)
         {
            ObjectUtils.disposeObject(_normalCostContiner);
         }
         _normalCostContiner = null;
         if(_expImgae)
         {
            ObjectUtils.disposeObject(_expImgae);
         }
         _expImgae = null;
         if(_backText2)
         {
            ObjectUtils.disposeObject(_backText2);
         }
         _backText2 = null;
         if(_costText2)
         {
            ObjectUtils.disposeObject(_costText2);
         }
         _costText2 = null;
         if(_doubleExpText)
         {
            ObjectUtils.disposeObject(_doubleExpText);
         }
         _doubleExpText = null;
         if(_doubleCostContiner)
         {
            ObjectUtils.disposeObject(_doubleCostContiner);
         }
         _doubleCostContiner = null;
         if(_expImgae2)
         {
            ObjectUtils.disposeObject(_expImgae2);
         }
         _expImgae2 = null;
         if(_pointImage)
         {
            ObjectUtils.disposeObject(_pointImage);
         }
         _pointImage = null;
         if(_normalBtn)
         {
            ObjectUtils.disposeObject(_normalBtn);
         }
         _normalBtn = null;
         if(_doubleBtn)
         {
            ObjectUtils.disposeObject(_doubleBtn);
         }
         _doubleBtn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

