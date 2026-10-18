package christmas
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.christmas.ChristmasModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.ChristmasManager;
   import yishi.manager.FrameControllerManager;
   
   public class ChristmasItem extends Component
   {
      
      private var _overBg:Bitmap;
      
      private var _icon:ScaleFrameImage;
      
      private var _red:Bitmap;
      
      private var _index:int;
      
      private var _txt:FilterFrameText;
      
      public function ChristmasItem(param1:int)
      {
         super();
         _index = param1;
         initView();
         addEvent();
         this.buttonMode = true;
         this.tipStyle = "yishi.view.tips.OneLineTip";
         this.isFollowMouse = false;
         this.tipDirctions = "4,5,6,0,1,2,3,7";
         refreshView();
      }
      
      private function initView() : void
      {
         _overBg = ComponentFactory.Instance.creatBitmap("asset.ChristmasFrame.itemOverBg");
         _icon = ComponentFactory.Instance.creatComponentByStylename("christmasFrame.itemBtnIcon");
         _red = ComponentFactory.Instance.creatBitmap("asset.ChristmasFrame.redPoint");
         _txt = ComponentFactory.Instance.creatComponentByStylename("ChristmasItem.txt");
         addChild(_overBg);
         addChild(_icon);
         addChild(_red);
         addChild(_txt);
         _icon.setFrame(_index);
         _overBg.visible = false;
         _red.visible = false;
         _txt.mouseEnabled = false;
         this.tipData = LanguageMgr.GetTranslation("christmasItem.tipData.text" + _index);
         _txt.text = LanguageMgr.GetTranslation("ChristmasItem.txt.text" + _index);
      }
      
      private function addEvent() : void
      {
         addEventListener("rollOver",__overHandler);
         addEventListener("rollOut",__outHandler);
         this.addEventListener("click",__clickHandler);
         ChristmasManager.instance.addEventListener("EVENT_UPDATE",updateInfoHandler);
         ChristmasManager.instance.addEventListener("ANSWER_UPDATE",updateInfoHandler);
         ChristmasManager.instance.addEventListener("christmas.TASK_UPDATE",updateInfoHandler);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(_overBg)
         {
            _overBg.visible = true;
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         if(_overBg)
         {
            _overBg.visible = false;
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("christmas",_index);
         FrameControllerManager.instance.christmasController.setPreFrame("christmas");
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__overHandler);
         removeEventListener("rollOut",__outHandler);
         this.removeEventListener("click",__clickHandler);
         ChristmasManager.instance.removeEventListener("EVENT_UPDATE",updateInfoHandler);
         ChristmasManager.instance.removeEventListener("ANSWER_UPDATE",updateInfoHandler);
         ChristmasManager.instance.removeEventListener("christmas.TASK_UPDATE",updateInfoHandler);
      }
      
      private function updateInfoHandler(param1:NotificationEvent) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc1_:Boolean = false;
         switch(_index - 1)
         {
            case 0:
               _loc1_ = Boolean(model.isPrayRed);
               break;
            case 1:
               _loc1_ = Boolean(model.isGiftRed);
               break;
            case 2:
               _loc1_ = Boolean(model.isAnswerRed);
               break;
            case 3:
               _loc1_ = Boolean(model.isLuckyRed);
               break;
            case 6:
               _loc1_ = Boolean(model.isHirtRed);
               break;
            case 7:
               _loc1_ = Boolean(model.isChengjiuRed);
         }
         _red.visible = _loc1_;
      }
      
      public function get model() : ChristmasModel
      {
         return ChristmasManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_overBg);
         _overBg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_red);
         _red = null;
         super.dispose();
      }
   }
}

