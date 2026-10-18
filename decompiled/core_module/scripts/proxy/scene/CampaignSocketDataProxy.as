package proxy.scene
{
   import proxy.data.SocketDataProxyModel;
   import yishi.service.managers.SocketManager;
   
   public class CampaignSocketDataProxy extends BaseSceneSocketDataProxy
   {
      
      public function CampaignSocketDataProxy(param1:SocketDataProxyModel)
      {
         super(param1);
      }
      
      override protected function proxyStart() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 130,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4199,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4831,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4264,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4122,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 128,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 131,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 137,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 134,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 131,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 124,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 123,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 22,__onDataHandler);
         SocketManager.instance.addEventListener("U_PLAY_MOVIE",__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 142,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 129,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 19,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 133,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 132,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4124,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4126,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4174,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4175,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4183,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4104,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4185,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4206,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4252,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4254,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4255,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4253,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4262,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4371,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4450,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4456,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4207,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4468,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4103,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4494,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4609,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4649,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4663,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4664,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4665,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4520,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4522,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4727,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4462,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4945,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4665,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4729,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4686,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4521,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4513,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4523,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4518,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4514,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4519,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4474,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4833,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 333,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 334,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 335,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 387,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 387,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 387,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 387,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4448,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4449,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4861,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4862,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 387,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 439,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4874,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 183,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4891,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 378,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4282,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4285,__onDataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4297,__onDataHandler);
      }
      
      override protected function proxyOver() : void
      {
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 130,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4199,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4831,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4264,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4122,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 128,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 131,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 137,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 134,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 131,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 124,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 123,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 22,__onDataHandler);
         SocketManager.instance.removeEventListener("U_PLAY_MOVIE",__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 142,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 129,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 19,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 133,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 132,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4124,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4126,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4174,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4175,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4183,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4104,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4185,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4206,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4252,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4254,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4255,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4253,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4262,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4371,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4450,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4456,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4207,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4468,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4103,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4494,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4609,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4649,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4663,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4664,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4665,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4520,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4522,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4727,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4462,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4945,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4665,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4729,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4686,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4521,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4513,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4523,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4518,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4514,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4519,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4474,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4833,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 333,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 334,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 335,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4448,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4449,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4861,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4862,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 387,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 439,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4874,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 183,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4891,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 378,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4282,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4285,__onDataHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4297,__onDataHandler);
      }
      
      override public function get sceneType() : String
      {
         return "CAMPAIGN_MAP_SCENE";
      }
   }
}

