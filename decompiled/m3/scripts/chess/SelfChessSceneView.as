package chess
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class SelfChessSceneView extends Sprite
   {
      
      private var _bg:Bitmap;
      
      private var _botoomLeft:SelfChessBottomLeftView;
      
      private var _top:SelfChessTopView;
      
      private var _drag:Bitmap;
      
      private var _bottom:SelfChessBottomView;
      
      private var _left:SelfChessKindListView;
      
      private var _right:SelfChessPlayerListView;
      
      private var _team:SelfChessHeroTeamView;
      
      private var _limit:SelfChessLimitView;
      
      public function SelfChessSceneView()
      {
         super();
         initView();
         initEvent();
         resizeHandler();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.selfchess.bg");
         _botoomLeft = ComponentFactory.Instance.creatCustomObject("ui.selfchess.botoomLeft");
         _top = ComponentFactory.Instance.creatCustomObject("ui.selfchess.top");
         _drag = ComponentFactory.Instance.creatBitmap("asset.selfchess.drag");
         _bottom = ComponentFactory.Instance.creatCustomObject("ui.selfchess.bottom");
         _left = ComponentFactory.Instance.creatCustomObject("ui.selfchess.left");
         _right = ComponentFactory.Instance.creatCustomObject("ui.selfchess.right");
         _team = ComponentFactory.Instance.creatCustomObject("ui.selfchess.battleTeam");
         _limit = ComponentFactory.Instance.creatCustomObject("ui.selfchess.limit");
         addChild(_bg);
         addChild(_botoomLeft);
         addChild(_top);
         addChild(_team);
         addChild(_bottom);
         addChild(_left);
         addChild(_right);
         addChild(_drag);
         addChild(_limit);
      }
      
      private function initEvent() : void
      {
         StageReferance.stage.addEventListener("resize",resizeHandler);
         NotificationManager.instance.addEventListener("SELF_CHESS_UPDATA",updateInfosHandler);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("resize",resizeHandler);
         NotificationManager.instance.removeEventListener("SELF_CHESS_UPDATA",updateInfosHandler);
      }
      
      private function updateInfosHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         switch(_loc2_ - 3)
         {
            case 0:
               _botoomLeft.refreshView();
               _bottom.refreshView();
               _team.refreshView();
               _left.refreshView();
               _limit.refreshView();
               break;
            case 1:
               _team.refreshView();
               _botoomLeft.refreshView();
               _bottom.refreshView();
               _left.refreshView();
               _limit.refreshView();
               break;
            case 2:
               _team.refreshView();
               _bottom.refreshWait();
               _left.refreshView();
               _limit.refreshView();
               break;
            case 3:
               _botoomLeft.refreshView();
               _bottom.refreshPool();
               _bottom.refreshLock();
               break;
            case 4:
               _botoomLeft.refreshView();
               _limit.refreshView();
               _bottom.refreshPool();
               break;
            case 6:
               _right.refreshView();
               _botoomLeft.refreshView();
               _team.refreshView();
               _bottom.refreshView();
               _top.refreshView();
               _left.refreshView();
               _limit.refreshView();
               break;
            case 7:
               _bottom.refreshLock();
         }
      }
      
      private function resizeHandler(param1:Event = null) : void
      {
         var _loc3_:int = (StageReferance.stage.stageWidth - 1495) * 0.5;
         var _loc2_:int = (StageReferance.stage.stageHeight - 895) * 0.5;
         this.x = _loc3_;
         this.y = _loc2_;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_botoomLeft);
         _botoomLeft = null;
         ObjectUtils.disposeObject(_top);
         _top = null;
         ObjectUtils.disposeObject(_drag);
         _drag = null;
         ObjectUtils.disposeObject(_bottom);
         _bottom = null;
         ObjectUtils.disposeObject(_left);
         _left = null;
         ObjectUtils.disposeObject(_right);
         _right = null;
         ObjectUtils.disposeObject(_team);
         _team = null;
         ObjectUtils.disposeObject(_limit);
         _limit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

