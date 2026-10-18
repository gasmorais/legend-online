package com.map.vehicle.action
{
   import com.map.vehicle.data.VehicleAccountInfo;
   import com.map.vehicle.view.VehicleAccountFrame;
   import com.pickgliss.ui.ComponentFactory;
   import flash.utils.getTimer;
   import yishi.SwitchPageHelp;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   
   public class AccountAction implements IEnterFrame
   {
      
      private var _data:VehicleAccountInfo;
      
      private var _createTime:Number = getTimer();
      
      private var _returnScene:String;
      
      public function AccountAction(param1:VehicleAccountInfo)
      {
         _data = param1;
         EnterFrameManager.instance.registeEnterFrame(this);
         _returnScene = SwitchPageHelp.returnScene;
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__showHandler);
         if(SceneManager.instance.currentType == "VEHICLE")
         {
            SwitchPageHelp.returnToSpace();
         }
         super();
      }
      
      private function __showHandler(param1:NotificationEvent) : void
      {
         var _loc2_:VehicleAccountFrame = null;
         if(SceneManager.instance.currentType == _returnScene)
         {
            NotificationManager.instance.removeEventListener("SWITCH_SCENE",__showHandler);
            EnterFrameManager.instance.unRegisteEnterFrame(this);
            _loc2_ = ComponentFactory.Instance.createComponentGroupByStylename("vehicle.VehicleAccountFrame");
            _loc2_.show(_data);
            _data = null;
         }
         else if(SceneManager.instance.currentType == "VEHICLE")
         {
            SwitchPageHelp.returnToSpace();
         }
      }
      
      public function enterFrame() : void
      {
         if(getTimer() - _createTime > 200000)
         {
            NotificationManager.instance.removeEventListener("SWITCH_SCENE",__showHandler);
            EnterFrameManager.instance.unRegisteEnterFrame(this);
            _data = null;
            return;
         }
      }
   }
}

