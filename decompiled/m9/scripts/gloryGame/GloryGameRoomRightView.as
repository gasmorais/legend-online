package gloryGame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.GloryGameManager;
   import mvc.module.gloryGame.GloryGameModel;
   import mvc.module.gloryGame.event.GloryGameEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   
   public class GloryGameRoomRightView extends Sprite implements Disposeable
   {
      
      private var _bit0:Bitmap;
      
      private var _bit1:Bitmap;
      
      private var _btnGloryGameRoomRightTeam:BaseButton;
      
      private var _txtGloryGameRoomScore:FilterFrameText;
      
      private var _bit2:Bitmap;
      
      public function GloryGameRoomRightView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         GloryGameManager.instance.addEventListener("ROOM_UPDATE",onRoomUpdate);
         _btnGloryGameRoomRightTeam.addEventListener("click",onClickTeam);
      }
      
      private function removeEvent() : void
      {
         GloryGameManager.instance.removeEventListener("ROOM_UPDATE",onRoomUpdate);
         _btnGloryGameRoomRightTeam.removeEventListener("click",onClickTeam);
      }
      
      private function onClickTeam(param1:MouseEvent) : void
      {
         var _loc2_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         trace(_loc2_.hours + ":" + _loc2_.minutes);
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("teammanager");
      }
      
      protected function onRoomUpdate(param1:GloryGameEvent = null) : void
      {
         DisplayUtils.handleDisplay(false,_bit1,_bit2);
         if(model.currentRound == 1)
         {
            _txtGloryGameRoomScore.text = model.myScore + "";
            DisplayUtils.handleDisplay(true,_bit1);
            _txtGloryGameRoomScore.x = 135;
         }
         else
         {
            _txtGloryGameRoomScore.text = model.myWin + "";
            DisplayUtils.handleDisplay(true,_bit2);
            _txtGloryGameRoomScore.x = 185;
         }
      }
      
      private function initView() : void
      {
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.glorygameroom.PrelimBg");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.glorygameroom.MyPrelimScoreTxt");
         _bit2 = ComponentFactory.Instance.creatBitmap("asset.glorygameroom.MyPrelimRankTxt");
         _btnGloryGameRoomRightTeam = ComponentFactory.Instance.creatComponentByStylename("ui.glorygameroom.btnGloryGameRoomRightTeam");
         _txtGloryGameRoomScore = ComponentFactory.Instance.creatComponentByStylename("ui.glorygameroom.txtGloryGameRoomScore");
         addChild(_bit0);
         addChild(_bit1);
         addChild(_btnGloryGameRoomRightTeam);
         addChild(_txtGloryGameRoomScore);
         addChild(_bit2);
         onRoomUpdate();
      }
      
      public function get model() : GloryGameModel
      {
         return GloryGameManager.instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

