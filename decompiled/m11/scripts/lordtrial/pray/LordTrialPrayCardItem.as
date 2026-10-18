package lordtrial.pray
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class LordTrialPrayCardItem extends Sprite
   {
      
      private var _cardBg:Image;
      
      private var _openCardMc:MovieClip;
      
      private var _openStatus:int;
      
      public function LordTrialPrayCardItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _cardBg = ComponentFactory.Instance.creatComponentByStylename("lordTrialPrayCardItem.cardBg");
         _openCardMc = ComponentFactory.Instance.creatCustomObject("lordTrialPrayCardItem.openCardMc");
         addChild(_cardBg);
         addChild(_openCardMc);
         _openCardMc.visible = false;
         _openCardMc.stop();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_cardBg);
         _cardBg = null;
         ObjectUtils.disposeObject(_openCardMc);
         _openCardMc = null;
      }
      
      public function set openStatus(param1:int) : void
      {
         if(_openStatus == 1)
         {
            return;
         }
         _openStatus = param1;
         if(_openStatus == 1)
         {
            _openCardMc.visible = true;
            _openCardMc.play();
         }
      }
      
      public function dispose() : void
      {
         uninitView();
      }
   }
}

