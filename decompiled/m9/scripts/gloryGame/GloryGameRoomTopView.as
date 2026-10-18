package gloryGame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import managers.GloryGameManager;
   import mvc.module.gloryGame.GloryGameModel;
   import mvc.module.gloryGame.event.GloryGameEvent;
   import yishi.manager.PlayerManager;
   import yishi.utils.TimerUtils;
   
   public class GloryGameRoomTopView extends Sprite implements Disposeable
   {
      
      private var _bit1:Bitmap;
      
      private var _bit3:Bitmap;
      
      private var _turn1:Bitmap;
      
      private var _turn2:Bitmap;
      
      private var _turn3:Bitmap;
      
      private var _turn4:Bitmap;
      
      private var _turn5:Bitmap;
      
      private var _extra:Bitmap;
      
      private var _txtRoomTopTurn:FilterFrameText;
      
      private var _txtRoomTopTime:FilterFrameText;
      
      private var _TopBg:MutipleImage;
      
      private var n:int;
      
      public function GloryGameRoomTopView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.glorygameroom.FinalRoomTopRemainTimeTxt");
         _turn1 = ComponentFactory.Instance.creatBitmap("asset.glorygameroom.turn1");
         _turn2 = ComponentFactory.Instance.creatBitmap("asset.glorygameroom.turn2");
         _turn3 = ComponentFactory.Instance.creatBitmap("asset.glorygameroom.turn3");
         _turn4 = ComponentFactory.Instance.creatBitmap("asset.glorygameroom.turn4");
         _turn5 = ComponentFactory.Instance.creatBitmap("asset.glorygameroom.turn5");
         _extra = ComponentFactory.Instance.creatBitmap("asset.glorygameroom.extra");
         _bit3 = ComponentFactory.Instance.creatBitmap("asset.glorygameroom.result");
         _txtRoomTopTurn = ComponentFactory.Instance.creatComponentByStylename("ui.glorygameroom.txtRoomTopTurn");
         _txtRoomTopTime = ComponentFactory.Instance.creatComponentByStylename("ui.glorygameroom.txtRoomTopTime");
         _TopBg = ComponentFactory.Instance.creatComponentByStylename("ui.glorygameroom.topBg");
         addChild(_TopBg);
         addChild(_bit1);
         addChild(_turn1);
         addChild(_turn2);
         addChild(_turn3);
         addChild(_turn4);
         addChild(_turn5);
         addChild(_extra);
         addChild(_bit3);
         addChild(_txtRoomTopTurn);
         addChild(_txtRoomTopTime);
         battleStateUpdate();
         tick();
      }
      
      private function addEvent() : void
      {
         TimerUtils.addSecendTimer("GloryGameRoomRightView",1,2147483647,tick);
      }
      
      private function removeEvent() : void
      {
         TimerUtils.removeSecendTimer("GloryGameRoomRightView");
      }
      
      private function tick() : void
      {
         var _loc2_:Date = GloryGameManager.instance.myNextBattleTime;
         var _loc3_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc4_:int = _loc2_.hours * 60 * 60 + _loc2_.minutes * 60 + _loc2_.seconds;
         var _loc1_:int = _loc3_.hours * 60 * 60 + _loc3_.minutes * 60 + _loc3_.seconds;
         n = _loc4_ - _loc1_ + 5;
         if(n < 0)
         {
            n = 0;
         }
         _turn1.visible = false;
         _turn2.visible = false;
         _turn3.visible = false;
         _turn4.visible = false;
         _turn5.visible = false;
         _extra.visible = false;
         _bit3.visible = false;
         if(model.currentState >= 5 && n == 0)
         {
            _bit1.visible = false;
            _turn1.visible = false;
            _turn2.visible = false;
            _turn3.visible = false;
            _turn4.visible = false;
            _turn5.visible = false;
            _bit3.visible = true;
            _txtRoomTopTurn.visible = false;
            _txtRoomTopTime.visible = false;
         }
         else
         {
            _bit1.visible = true;
            _bit3.visible = false;
            _txtRoomTopTurn.visible = true;
            _txtRoomTopTime.visible = true;
            if(this["_turn" + model.currentRound])
            {
               this["_turn" + model.currentRound].visible = true;
            }
            if(model.currentRound == 1)
            {
               _txtRoomTopTurn.text = model.currentTurn + "/" + 15;
            }
            else
            {
               _txtRoomTopTurn.text = model.currentTurn + "/" + Math.max(model.currentTurn,3);
            }
            if(model.currentRound == 1)
            {
               _txtRoomTopTurn.text = model.currentTurn + "/" + 15;
            }
            else if(model.currentRound == 3)
            {
               _txtRoomTopTurn.text = model.myTurn + "/" + 3;
            }
            else if(model.currentRound == 4)
            {
               _txtRoomTopTurn.text = model.myTurn + "/" + 3;
            }
            else if(model.currentRound == 5)
            {
               _txtRoomTopTurn.text = model.myTurn + "/" + 3;
            }
            else if(model.currentRound == 2)
            {
               _txtRoomTopTurn.text = model.currentTurn + "/" + Math.max(model.currentTurn,3);
               if(model.currentTurn >= 3)
               {
                  _turn1.visible = false;
                  _turn2.visible = false;
                  _turn3.visible = false;
                  _turn4.visible = false;
                  _turn5.visible = false;
                  _bit1.visible = true;
                  _bit3.visible = false;
                  _txtRoomTopTurn.visible = false;
                  _txtRoomTopTime.visible = true;
                  _extra.visible = true;
               }
            }
         }
         _txtRoomTopTime.text = n + "";
      }
      
      private function battleStateUpdate(param1:GloryGameEvent = null) : void
      {
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

