package mvc.module.fish
{
   import managers.FishManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   
   public class FishPoolHandler implements IEnterFrame
   {
      
      private var count:int = 0;
      
      private var frameCount:int = 0;
      
      private var fishSigModel:FishSigModel;
      
      public function FishPoolHandler()
      {
         super();
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      public function enterFrame() : void
      {
         if(model.fishSigsModel.getList().length == 0)
         {
            return;
         }
         fishPoolMove();
         fishOut();
         NotificationManager.instance.sendNotification("UPDATE_FISH_INFO");
      }
      
      private function fishPoolMove() : void
      {
         for each(fishSigModel in model.fishSigsModel)
         {
            fishSigModel.moveFish();
         }
      }
      
      private function fishOut() : void
      {
         var _loc1_:Array = null;
         frameCount = frameCount + 1;
         if(frameCount >= 50)
         {
            frameCount = 0;
            _loc1_ = [];
            for each(fishSigModel in model.fishSigsModel)
            {
               if(fishSigModel.outFish)
               {
                  _loc1_.push(fishSigModel.fishSigInfo.fishId);
                  count = count + 1;
               }
            }
            if(count >= 1)
            {
               if(model.isSelf)
               {
                  FishManager.instance.fishAction(1,[1,count].concat(_loc1_));
               }
               count = 0;
            }
         }
      }
      
      private function get model() : FishModel
      {
         return FishManager.instance.model;
      }
      
      private function get playermodel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function exit() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
   }
}

