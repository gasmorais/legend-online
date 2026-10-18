package farm.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.geom.Point;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   
   public class FarmAnimalLayer extends Sprite
   {
      
      private var animalArea0:FarmAnimalArea;
      
      private var animalArea1:FarmAnimalArea;
      
      public function FarmAnimalLayer()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initArea0Points() : Array
      {
         var _loc1_:Array = [[],[],[],[],[]];
         _loc1_[0].push(new Point(45,270));
         _loc1_[0].push(new Point(90,235));
         _loc1_[0].push(new Point(145,210));
         _loc1_[0].push(new Point(245,260));
         _loc1_[0].push(new Point(155,425));
         _loc1_[0].push(new Point(85,370));
         _loc1_[1].push(new Point(75,335));
         _loc1_[1].push(new Point(130,288));
         _loc1_[1].push(new Point(180,260));
         _loc1_[1].push(new Point(235,225));
         _loc1_[1].push(new Point(305,210));
         _loc1_[1].push(new Point(130,376));
         _loc1_[2].push(new Point(180,314));
         _loc1_[2].push(new Point(295,275));
         _loc1_[2].push(new Point(356,243));
         _loc1_[2].push(new Point(180,388));
         _loc1_[2].push(new Point(233,365));
         _loc1_[2].push(new Point(286,335));
         _loc1_[3].push(new Point(355,305));
         _loc1_[3].push(new Point(400,260));
         _loc1_[3].push(new Point(240,430));
         _loc1_[3].push(new Point(305,390));
         _loc1_[3].push(new Point(360,358));
         _loc1_[3].push(new Point(415,330));
         _loc1_[4].push(new Point(470,295));
         _loc1_[4].push(new Point(288,475));
         _loc1_[4].push(new Point(350,436));
         _loc1_[4].push(new Point(401,399));
         _loc1_[4].push(new Point(458,367));
         _loc1_[4].push(new Point(525,336));
         return _loc1_;
      }
      
      private function initArea1Points() : Array
      {
         var _loc1_:Array = [[],[],[]];
         _loc1_[0].push(new Point(161,261));
         _loc1_[0].push(new Point(243,216));
         _loc1_[0].push(new Point(342,160));
         _loc1_[0].push(new Point(418,112));
         _loc1_[1].push(new Point(282,331));
         _loc1_[1].push(new Point(364,286));
         _loc1_[1].push(new Point(463,230));
         _loc1_[1].push(new Point(539,182));
         _loc1_[2].push(new Point(404,401));
         _loc1_[2].push(new Point(486,356));
         _loc1_[2].push(new Point(585,300));
         _loc1_[2].push(new Point(661,252));
         return _loc1_;
      }
      
      private function initView() : void
      {
         animalArea0 = ComponentFactory.Instance.creatCustomObject("farm.FarmAnimalArea0",[0,initArea0Points()]);
         addChild(animalArea0);
      }
      
      private function addEvent() : void
      {
         PlayerManager.instance.currentPlayerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__timeUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         PlayerManager.instance.currentPlayerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__timeUpdateHandler);
      }
      
      private function __timeUpdateHandler(param1:PlayerEvent) : void
      {
         animalArea0.updateView();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(animalArea0 != null)
         {
            ObjectUtils.disposeObject(animalArea0);
            animalArea0 = null;
         }
         if(animalArea1 != null)
         {
            ObjectUtils.disposeObject(animalArea1);
            animalArea1 = null;
         }
         if(this != null)
         {
            ObjectUtils.disposeAllChildren(this);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

