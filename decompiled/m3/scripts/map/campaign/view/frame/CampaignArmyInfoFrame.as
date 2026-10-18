package map.campaign.view.frame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.armyII.UserArmy;
   
   public class CampaignArmyInfoFrame extends Sprite
   {
      
      private var _topContentBg:ScaleBitmapImage;
      
      private var _buttomContentBg:ScaleBitmapImage;
      
      private var _frame:Frame;
      
      private var _data:UserArmy;
      
      public function CampaignArmyInfoFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("outercity.frame.CampaignArmyInfoFrame");
         _topContentBg = ComponentFactory.Instance.creatComponentByStylename("campaign.room.ArmyTopContentBg");
         addChild(_topContentBg);
         _buttomContentBg = ComponentFactory.Instance.creatComponentByStylename("campaign.room.ArmyButtomContentBg");
         addChild(_buttomContentBg);
      }
      
      private function addEvent() : void
      {
         _frame.closeButton.addEventListener("click",__frameCloseClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_frame && _frame.closeButton)
         {
            _frame.closeButton.removeEventListener("click",__frameCloseClickHandler);
         }
      }
      
      private function __frameCloseClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_topContentBg)
         {
            _topContentBg.dispose();
         }
         _topContentBg = null;
         if(_buttomContentBg)
         {
            _buttomContentBg.dispose();
         }
         _buttomContentBg = null;
         if(_frame)
         {
            _frame.dispose();
         }
         _frame = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set data(param1:UserArmy) : void
      {
         _data = param1;
      }
   }
}

