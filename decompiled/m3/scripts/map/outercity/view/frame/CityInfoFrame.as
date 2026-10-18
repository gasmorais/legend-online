package map.outercity.view.frame
{
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import map.internals.event.OuterCityEvent;
   import map.internals.view.frame.CityInfoView;
   import map.outercity.manager.OuterCityManager;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   
   public class CityInfoFrame extends CityInfoView
   {
      
      public function CityInfoFrame()
      {
         super();
      }
      
      override protected function __moveHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         NotificationManager.instance.dispatchEvent(new OuterCityEvent("START_MOVE",new Point(baseCastle.x,baseCastle.y)));
         close();
      }
      
      override protected function __attackHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_attackBtn.text == LanguageMgr.GetTranslation("map.internals.view.frame.CityInfoView.command06"))
         {
            SceneManager.instance.setScene("CASTLE_SCENE");
            dispose();
         }
         else if(_attackBtn.text == LanguageMgr.GetTranslation("public.attack"))
         {
            OuterCityManager.instance.controler.sendAttack(baseCastle.posX,baseCastle.posY);
            close();
         }
         else if(_attackBtn.text == LanguageMgr.GetTranslation("map.internals.view.frame.CityInfoView.command07"))
         {
         }
      }
   }
}

