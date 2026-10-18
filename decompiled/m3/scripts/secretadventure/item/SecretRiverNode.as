package secretadventure.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import mvc.module.secret.SecretAdventureModel;
   import mvc.module.secret.SecretFrameInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.manager.SecretAdventerManager;
   import yishi.utils.DateFormatter;
   import yishi.view.community.TimeDownView;
   
   public class SecretRiverNode extends Sprite
   {
      
      private var _bg:MutipleImage;
      
      private var _time:TimeDownView;
      
      public function SecretRiverNode()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.secretadventure.revierBg");
         _time = ComponentFactory.Instance.creatComponentByStylename("secret.hexagon.reiverTimeDown");
         addChild(_bg);
         addChild(_time);
         mouseEnabled = mouseChildren = false;
         updateTime();
      }
      
      private function initEvent() : void
      {
         _time.addEventListener("timerDown_complete",timeCompleteHandler);
      }
      
      private function removeEvent() : void
      {
         _time.removeEventListener("timerDown_complete",timeCompleteHandler);
      }
      
      private function timeCompleteHandler(param1:Event) : void
      {
         var _loc2_:SecretFrameInfo = model.frameInfo;
         if(_loc2_ && _loc2_.currHp <= 0)
         {
            SecretAdventerManager.Instance.opCommon(4);
         }
      }
      
      private function updateTime() : void
      {
         var _loc1_:Date = null;
         var _loc6_:PlayerModel = PlayerManager.instance.currentPlayerModel;
         if(_loc6_.castle_offset == -1)
         {
            _loc1_ = _loc6_.sysCurtime;
         }
         else
         {
            _loc1_ = DateFormatter.getTimezoneOffsetDate(_loc6_.castle_offset);
         }
         var _loc2_:Number = _loc1_.time;
         var _loc4_:String = model.frameInfo.remainTime;
         var _loc5_:Number = Number(DateFormatter.parse(_loc4_,"YYYY-MM-DD hh:mm:ss").time);
         var _loc3_:Number = _loc5_ - _loc2_ - 2000;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         _time.timeCount = _loc3_ / 1000;
      }
      
      private function get model() : SecretAdventureModel
      {
         return SecretAdventerManager.Instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_time);
         _time = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

