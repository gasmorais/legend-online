package war2023.layer
{
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.display.Sprite;
   import mvc.module.war2023.info.SecretWarInfo;
   import mvc.module.war2023.info.SecretwarPlayInfo;
   import war2023.view.SecretwarStartCDView;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SecretWarManager;
   
   public class SecretwarMaskLayer extends Sprite
   {
      
      private var _selfPlayer:SecretwarPlayInfo;
      
      private var _startCd:SecretwarStartCDView;
      
      private var _warInfo:SecretWarInfo;
      
      private var _gamePlaying:Boolean = false;
      
      private var _dieShape:Shape;
      
      private var _readyShape:Shape;
      
      private var _lastDie:Boolean;
      
      public function SecretwarMaskLayer()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         _dieShape = new Shape();
         _dieShape.graphics.beginFill(0,0.6);
         _dieShape.graphics.drawRect(-500,-500,2920,2080);
         _dieShape.graphics.endFill();
         addChild(_dieShape);
         _dieShape.visible = false;
         this.mouseChildren = this.mouseEnabled = false;
         _selfPlayer = SecretWarManager.Instance.model.selfPlay;
         _warInfo = SecretWarManager.Instance.model.warInfo;
         if(playerModel.nowDate < _warInfo.preDate.time)
         {
            _startCd = new SecretwarStartCDView();
            _loc1_ = (_warInfo.preDate.time - playerModel.nowDate) / 1000;
            _startCd.timecount(_loc1_);
            _readyShape = new Shape();
            _readyShape.graphics.beginFill(0,0.4);
            _readyShape.graphics.drawRect(-500,-500,2920,2080);
            _readyShape.graphics.endFill();
            addChild(_readyShape);
            _warInfo.gameIsStart = false;
         }
         else
         {
            _gamePlaying = true;
            _warInfo.gameIsStart = true;
         }
      }
      
      public function enterFrame() : void
      {
         var _loc1_:Frame = null;
         if(!_selfPlayer || !_warInfo)
         {
            return;
         }
         if(!_gamePlaying)
         {
            if(playerModel.nowDate < _warInfo.preDate.time)
            {
               this.visible = true;
               return;
            }
            ObjectUtils.disposeObject(_startCd);
            _startCd = null;
            _gamePlaying = true;
            _warInfo.gameIsStart = true;
         }
         if(_selfPlayer.state == 2)
         {
            this.visible = true;
            _dieShape.visible = true;
            _lastDie = true;
         }
         else
         {
            if(_lastDie)
            {
               _loc1_ = FrameControllerManager.instance.secretwarContrl.frame;
               if(_loc1_ && !_loc1_.isDie)
               {
                  _loc1_.dispose();
               }
               NotificationManager.instance.sendNotification("Secretwar.initMapPos");
               _lastDie = false;
            }
            this.visible = false;
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_startCd);
         _startCd = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _selfPlayer = null;
         _warInfo = null;
      }
   }
}

