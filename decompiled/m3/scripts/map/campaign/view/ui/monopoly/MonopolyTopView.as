package map.campaign.view.ui.monopoly
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class MonopolyTopView extends Sprite implements Disposeable
   {
      
      private var _name:Image;
      
      public function MonopolyTopView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _name = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyTopView.CampaignName");
         addChild(_name);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

