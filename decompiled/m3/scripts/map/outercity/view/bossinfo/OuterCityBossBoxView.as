package map.outercity.view.bossinfo
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.road.yishi.proto.army.BoxMsg;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import map.outercity.BoxMsgInfo;
   import map.outercity.manager.OuterCityManager;
   
   public class OuterCityBossBoxView extends Sprite
   {
      
      private var _box:MovieClip;
      
      private var data:BoxMsgInfo;
      
      public function OuterCityBossBoxView()
      {
         super();
         this.buttonMode = true;
         this.addEventListener("click",onClick);
      }
      
      public function setData(param1:BoxMsgInfo) : void
      {
         data = param1;
         _box = ComponentFactory.Instance.creatCustomObject("outercity.boss.BossBoxMc" + data.type);
         this.addChild(_box);
         this.x = data.x * 20;
         this.y = data.y * 20;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc2_:BoxMsg = new BoxMsg();
         _loc2_.boxId = data.boxId;
         _loc2_.userId = data.userId;
         _loc2_.grade = data.grade;
         _loc2_.mapId = data.mapId;
         _loc2_.x = data.x;
         _loc2_.y = data.y;
         _loc2_.type = data.type;
         OuterCityManager.instance.getBossBox(_loc2_);
         TweenMax.to(this,1,{
            "alpha":0,
            "onComplete":onComplete
         });
         this.buttonMode = false;
      }
      
      public function onComplete() : void
      {
         dispose();
      }
      
      public function dispose() : void
      {
         this.removeEventListener("click",onClick);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         _box.stop();
         _box = null;
      }
   }
}

