package consortiachess
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import consortiachess.board.ChesspvpChatView;
   import consortiachess.board.ConsortiaChessBoard;
   import consortiachess.util.ChesspvpResourceUtil;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChessPvpBoardInfo;
   import mvc.module.chesspvp.ChessPvpOp;
   import mvc.module.chesspvp.ChesspvpRoleInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   
   public class ChesspvpBattleFrame extends Frame
   {
      
      private var _boardView:ConsortiaChessBoard;
      
      private var _chatView:ChesspvpChatView;
      
      public function ChesspvpBattleFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         ChesspvpResourceUtil.ins.initData();
         _boardView = new ConsortiaChessBoard();
         addToContent(_boardView);
         _chatView = new ChesspvpChatView();
         addToContent(_chatView);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("chesspvp.gameover",gameOverHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("chesspvp.gameover",gameOverHandler);
      }
      
      private function gameOverHandler(param1:NotificationEvent) : void
      {
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override protected function __onCloseClick(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.chessPvpCtl.setLockPreFrame("chesspvp",null,null,"consortiachess.ChesspvpBattleFrame");
         var _loc3_:ChessPvpBoardInfo = ChessPvpManager.Instance.model.boradInfo;
         var _loc2_:ChesspvpRoleInfo = ChessPvpManager.Instance.model.selfInfo;
         ChessPvpManager.Instance.operChess(ChessPvpOp.BOARD_OP_ROLE_LEAVE,_loc3_.boardUid,_loc2_.userID,_loc2_.servername);
         super.__onCloseClick(param1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_boardView);
         _boardView = null;
         ObjectUtils.disposeObject(_chatView);
         _chatView = null;
         super.dispose();
         ChesspvpResourceUtil.ins.clean();
         ChessPvpManager.Instance.model.boradInfo.initBoxChangeState();
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("chesspvp.frame.title");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         if(ChessPvpManager.Instance.model.needAlertResult)
         {
            FrameControllerManager.instance.openControllerByInfo("chesspvp",3);
            ChessPvpManager.Instance.model.needAlertResult = false;
         }
         _chatView.show();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP"];
      }
   }
}

