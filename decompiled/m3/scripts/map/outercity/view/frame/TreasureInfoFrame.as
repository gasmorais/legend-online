package map.outercity.view.frame
{
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import map.internals.view.frame.TreasureFrameView;
   import map.outercity.manager.OuterCityManager;
   
   public class TreasureInfoFrame extends TreasureFrameView
   {
      
      public function TreasureInfoFrame()
      {
         super();
      }
      
      override protected function __onClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         OuterCityManager.instance.controler.sendAttack(_info.posX,_info.posY);
         close();
      }
      
      override protected function __onCancleClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         close();
      }
   }
}

