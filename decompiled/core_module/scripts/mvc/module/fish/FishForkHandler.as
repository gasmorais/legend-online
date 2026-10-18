package mvc.module.fish
{
   import managers.FishManager;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   
   public class FishForkHandler implements IEnterFrame
   {
      
      private var _countRotation:int = 0;
      
      private var _countFork:int = 0;
      
      private var _rotation:Number = 0;
      
      public function FishForkHandler()
      {
         super();
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      public function enterFrame() : void
      {
         var _loc1_:int = 0;
         if(model.isForkState(0))
         {
            if(model.fishForkInfo.type == 1)
            {
               _loc1_ = 50;
            }
            else
            {
               _loc1_ = 65;
            }
            model.fishForkInfo.rotation = Math.sin(3.141592653589793 * _countRotation / 42) * _loc1_;
            _countRotation %= 84;
            _countRotation = _countRotation + 1;
            _countFork = 0;
            model.leftForkInfo.rotation = model.fishForkInfo.rotation + 15;
            model.rightForkInfo.rotation = model.fishForkInfo.rotation - 15;
         }
         else if(model.fishForkInfo.type == 1)
         {
            for each(var _loc2_:FishForkInfo in model.fishForkList)
            {
               _countFork = _loc2_.count;
               _rotation = _loc2_.rotation;
               _loc2_.y = y;
               _loc2_.x = x;
               if(_loc2_.state == 1)
               {
                  _countFork = _countFork + 1;
               }
               else if(_loc2_.state == 2)
               {
                  _countFork = _countFork - 1;
               }
               _loc2_.count = _countFork;
            }
         }
         else
         {
            if(model.isForkState(3))
            {
               _countFork = model.fishForkInfo.frame;
            }
            _rotation = model.fishForkInfo.rotation;
            model.fishForkInfo.y = y;
            model.fishForkInfo.x = x;
            if(model.isForkState(1))
            {
               _countFork = _countFork + 1;
            }
            else if(model.isForkState(2))
            {
               _countFork = _countFork - 1;
            }
         }
         NotificationManager.instance.sendNotification("UPDATE_FISH_FORK");
      }
      
      private function get y() : Number
      {
         return Math.cos(Math.abs(_rotation * 3.141592653589793 / 180)) * (5.6 * _countFork + 67);
      }
      
      private function get x() : Number
      {
         return 830 / 2 - Math.sin(_rotation * 3.141592653589793 / 180) * (5.6 * _countFork + 67);
      }
      
      private function get model() : FishModel
      {
         return FishManager.instance.model;
      }
      
      public function exit() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
   }
}

