package monthcard
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MonthCardManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.monthcard.MonthCardModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.utils.MsgMan;
   
   public class MonthCardFrame extends Frame implements IManualSize
   {
      
      private var _activeTextImage:MutipleImage;
      
      private var _timeText:FilterFrameText;
      
      private var _helpContiner:Component;
      
      private var _giftHbox:HBox;
      
      private var itemList:Vector.<MonthCardGiftItem>;
      
      public function MonthCardFrame()
      {
         super();
         initView();
         initHelpText();
         initListView();
         addEvent();
         MonthCardManager.instance.sendMonthRequest(1);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,955,517);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _activeTextImage = ComponentFactory.Instance.creatComponentByStylename("MonthCardFrame.activeTextImage");
         _timeText = ComponentFactory.Instance.creatComponentByStylename("MonthCardFrame.timeText");
         _giftHbox = ComponentFactory.Instance.creatComponentByStylename("MonthCardFrame.giftHbox");
         _helpContiner = ComponentFactory.Instance.creatComponentByStylename("MonthCardFrame.helpContiner");
         addToContent(_activeTextImage);
         addToContent(_timeText);
         addToContent(_giftHbox);
         addToContent(_helpContiner);
      }
      
      private function initHelpText() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FilterFrameText = null;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("MonthCardFrame.helpText");
            _loc1_.x = 0;
            _loc1_.y = -5 + 15 * _loc2_;
            _loc1_.text = LanguageMgr.GetTranslation("MonthCardFrame.helpText.text" + _loc2_);
            _helpContiner.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function initListView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:MonthCardGiftItem = null;
         itemList = new Vector.<MonthCardGiftItem>();
         var _loc2_:int = int(model.giftList.length);
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc1_ = new MonthCardGiftItem();
            _giftHbox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("MONTH_INFO_CHANGE",this,__updateInfoChange);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("MONTH_INFO_CHANGE",this,__updateInfoChange);
      }
      
      private function __updateInfoChange(param1:String, param2:Object) : void
      {
         var _loc5_:int = 0;
         var _loc3_:MonthCardGiftItem = null;
         _timeText.text = model.openTime + " - " + model.stopTime;
         var _loc4_:int = int(model.giftList.length);
         _loc5_ = 0;
         while(_loc5_ < itemList.length)
         {
            _loc3_ = itemList[_loc5_];
            _loc3_.data = _loc5_ >= _loc4_ ? null : model.giftList[_loc5_];
            _loc5_++;
         }
      }
      
      public function get model() : MonthCardModel
      {
         return MonthCardManager.instance.model;
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_activeTextImage);
         _activeTextImage = null;
         ObjectUtils.disposeObject(_timeText);
         _timeText = null;
         ObjectUtils.disposeObject(_giftHbox);
         _giftHbox = null;
         ObjectUtils.disposeObject(_helpContiner);
         _helpContiner = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

