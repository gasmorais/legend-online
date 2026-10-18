package map.campaign.view.ui.flametemple
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
   import map.campaign.data.PvpWarFightModel;
   
   public class FlameTemplePersonRewardView extends Frame implements Disposeable
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      public function FlameTemplePersonRewardView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:FlameTemplePersonRewardItemView = null;
         var _loc2_:MutipleImage = null;
         _border = ComponentFactory.Instance.creatComponentByStylename("flameTemplePersonRewardView.border");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("flameTemplePersonRewardView.vBox");
         addToContent(_border);
         addToContent(_vBox);
         var _loc4_:Array = PvpWarFightModel.PERSONAL_REWARDS;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc1_ = new FlameTemplePersonRewardItemView();
            _loc1_.data = _loc4_[_loc3_];
            _vBox.addChild(_loc1_);
            if(_loc3_ != 3)
            {
               _loc2_ = ComponentFactory.Instance.creatComponentByStylename("flameTemplePersonRewardView.line");
               _vBox.addChild(_loc2_);
            }
            _loc3_++;
         }
         this.titleText = LanguageMgr.GetTranslation("flametemple.scoreRewards");
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("response",__frameResponse);
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

