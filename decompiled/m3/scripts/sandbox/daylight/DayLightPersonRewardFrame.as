package sandbox.daylight
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   
   public class DayLightPersonRewardFrame extends Frame implements Disposeable
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      public function DayLightPersonRewardFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:DayLightPersonRewardItemView = null;
         var _loc2_:MutipleImage = null;
         titleText = LanguageMgr.GetTranslation("daylight.DayLightPersonRewardFrame.titleText");
         _border = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightPersonRewardFrame.border");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightPersonRewardFrame.vBox");
         addToContent(_border);
         addToContent(_vBox);
         var _loc4_:Array = DayLightModel.PERSONAL_REWARDS;
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc1_ = new DayLightPersonRewardItemView();
            _loc1_.data = _loc4_[_loc3_];
            _vBox.addChild(_loc1_);
            if(_loc3_ != 3)
            {
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("daylight.DayLightPersonRewardFrame.line");
               _vBox.addChild(_loc2_);
            }
            _loc3_++;
         }
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
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
         uintView();
         super.dispose();
      }
   }
}

