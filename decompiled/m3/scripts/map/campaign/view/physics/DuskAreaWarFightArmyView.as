package map.campaign.view.physics
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import map.campaign.event.CampaignMapEvent;
   
   public class DuskAreaWarFightArmyView extends PvpWarFightArmyView
   {
      
      private var _flagView:ScaleFrameImage;
      
      public function DuskAreaWarFightArmyView()
      {
         super();
      }
      
      override protected function setNpcName(param1:int) : void
      {
         super.setNpcName(param1);
      }
      
      override protected function __isDieHandler(param1:CampaignMapEvent) : void
      {
         switch(int(_data.isDie) - 9)
         {
            case 0:
               createFlag();
               break;
            default:
               removeFlag();
         }
         super.__isDieHandler(param1);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_flagView);
         _flagView = null;
         super.dispose();
      }
      
      private function createFlag() : void
      {
         ObjectUtils.disposeObject(_flagView);
         _flagView = null;
         _flagView = ComponentFactory.Instance.creatComponentByStylename("map.space.SpaceMapFrame.flagBg");
         addChild(_flagView);
         var _loc1_:int = isBlueTeam() ? 2 : 1;
         _flagView.setFrame(_loc1_);
      }
      
      private function removeFlag() : void
      {
         ObjectUtils.disposeObject(_flagView);
         _flagView = null;
      }
   }
}

