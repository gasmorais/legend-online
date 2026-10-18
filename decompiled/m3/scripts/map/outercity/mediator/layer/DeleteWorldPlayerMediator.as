package map.outercity.mediator.layer
{
   import flash.utils.Dictionary;
   import map.outercity.manager.OuterCityManager;
   import map.outercity.view.mapphysics.ArmyView;
   import mvc.module.armyII.BaseArmy;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.ArmyManager;
   import yishi.manager.EnterFrameManager;
   
   public class DeleteWorldPlayerMediator implements IMediator, IEnterFrame
   {
      
      private var _count:int;
      
      public function DeleteWorldPlayerMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      public function unregister(param1:Object) : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      public function enterFrame() : void
      {
         _count = _count + 1;
         if(_count >= 125)
         {
            _count = 0;
            checkPlayerOutScene();
         }
      }
      
      private function checkPlayerOutScene() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:String = null;
         var _loc5_:Dictionary = OuterCityManager.instance.model.allArmyDict;
         var _loc1_:Array = OuterCityManager.instance.model.nineSliceScaling;
         var _loc6_:Array = [];
         for each(var _loc7_:BaseArmy in _loc5_)
         {
            if(_loc7_.id != ArmyManager.instance.army.id)
            {
               if(!_loc7_.armyView)
               {
                  delete _loc5_[_loc7_.id];
               }
               else
               {
                  _loc2_ = _loc7_.armyView.x / 1000;
                  _loc3_ = _loc7_.armyView.y / 1000;
                  _loc4_ = _loc2_ + "," + _loc3_;
                  if(_loc1_.indexOf(_loc4_) == -1)
                  {
                     delete _loc5_[_loc7_.id];
                     (_loc7_.armyView as ArmyView).dispose();
                  }
               }
            }
         }
      }
   }
}

