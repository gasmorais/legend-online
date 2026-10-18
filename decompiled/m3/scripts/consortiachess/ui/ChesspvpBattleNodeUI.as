package consortiachess.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortiachess.board.ConsortiaChessBasePiece;
   import consortiachess.item.ChesspvpMoveCdItem;
   import consortiachess.item.ChesspvpRiverCdItem;
   import consortiachess.item.ChesspvpTeamInfoItem;
   import consortiachess.util.ChesspvpResourceUtil;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChessPvpBoardInfo;
   import mvc.module.chesspvp.ChessPvpModel;
   import mvc.module.chesspvp.ChessPvpOp;
   import mvc.module.chesspvp.ChesspvpBoxInfo;
   import mvc.module.chesspvp.ChesspvpRoleInfo;
   import yishi.view.tips.MessageTipManager;
   
   public class ChesspvpBattleNodeUI extends Sprite
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _titleBg:Image;
      
      private var _titleTxt:FilterFrameText;
      
      private var _panle:ScrollPanel;
      
      private var _vbox:VBox;
      
      private var _selfTeam:ChesspvpTeamInfoItem;
      
      private var _otherTeam:ChesspvpTeamInfoItem;
      
      protected var _rTopTbg:Image;
      
      protected var _bRtopTitle:FilterFrameText;
      
      private var _moveCdView:ChesspvpMoveCdItem;
      
      private var _riverCdView:ChesspvpRiverCdItem;
      
      private var _line:Bitmap;
      
      private var _posX:int;
      
      private var _posY:int;
      
      private var _boxInfo:ChesspvpBoxInfo;
      
      private var _posTxt:FilterFrameText;
      
      private const XPOS_WHITE:Array = ["A","B","C","D","E","F","G","H"];
      
      private const YPOS_WHITE:Array = [8,7,6,5,4,3,2,1];
      
      private const XPOS_BLACK:Array = ["H","G","F","E","D","C","B","A"];
      
      private const YPOS_BLACK:Array = [1,2,3,4,5,6,7,8];
      
      public function ChesspvpBattleNodeUI()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.battleRightViewBg");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.bRtopTitle");
         _vbox = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.battle.allVbox");
         _panle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.battle.teamSpanel");
         _moveCdView = new ChesspvpMoveCdItem();
         _moveCdView.y = 395;
         _riverCdView = new ChesspvpRiverCdItem();
         _riverCdView.y = 395;
         _selfTeam = new ChesspvpTeamInfoItem(0);
         _otherTeam = new ChesspvpTeamInfoItem(1);
         _rTopTbg = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.rTopTbg");
         _bRtopTitle = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.bRtopTitle");
         _bRtopTitle.text = LanguageMgr.GetTranslation("chesspvp.battle.rtop");
         _line = ComponentFactory.Instance.creatBitmap("asset.chesspvp.rd.line");
         _posTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.battlePostxt");
         addChild(_bg);
         addChild(_titleTxt);
         addChild(_panle);
         addChild(_moveCdView);
         addChild(_riverCdView);
         addChild(_rTopTbg);
         addChild(_bRtopTitle);
         addChild(_posTxt);
         addChild(_line);
         _panle.setView(_vbox);
         _vbox.beginChanges();
         _vbox.addChild(_selfTeam);
         _vbox.addChild(_otherTeam);
         _vbox.commitChanges();
         _panle.invalidateViewport();
         _line.x = 2;
         _line.y = 400;
         _line.width = 293;
      }
      
      public function updateBoxInfo(param1:ChesspvpBoxInfo, param2:int, param3:int) : void
      {
         _boxInfo = param1;
         _posX = param2;
         _posY = param3;
         if(model.selfInfo.team == 1)
         {
            _posTxt.text = "(" + XPOS_WHITE[param2] + YPOS_WHITE[param3] + ")";
         }
         else
         {
            _posTxt.text = "(" + XPOS_BLACK[param2] + YPOS_BLACK[param3] + ")";
         }
         updateView();
      }
      
      public function updateView() : void
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         _riverCdView.updateView();
         _moveCdView.updateView();
         if(_boxInfo == null)
         {
            return;
         }
         if(model.selfInfo.team == 1)
         {
            _loc1_ = _boxInfo.whiteList;
            _loc2_ = _boxInfo.blackList;
         }
         else
         {
            _loc1_ = _boxInfo.blackList;
            _loc2_ = _boxInfo.whiteList;
         }
         _vbox.beginChanges();
         _selfTeam.updateList(_loc1_);
         _otherTeam.updateList(_loc2_);
         _vbox.commitChanges();
         _panle.invalidateViewport();
      }
      
      private function get model() : ChessPvpModel
      {
         return ChessPvpManager.Instance.model;
      }
      
      private function initEvent() : void
      {
         _moveCdView.btn.addEventListener("click",moveHandler);
      }
      
      private function removeEvent() : void
      {
         _moveCdView.btn.removeEventListener("click",moveHandler);
      }
      
      private function moveHandler(param1:MouseEvent) : void
      {
         var _loc6_:Array = null;
         var _loc2_:int = 0;
         var _loc4_:ChessPvpBoardInfo = null;
         var _loc5_:ChesspvpRoleInfo = null;
         var _loc3_:ConsortiaChessBasePiece = ChesspvpResourceUtil.ins.selfChess;
         if(_loc3_ && _boxInfo)
         {
            _loc6_ = _loc3_.getPaths(_posX,_posY);
            _loc2_ = int(_loc6_ ? _loc6_.length : 0);
            if(_loc6_ != null)
            {
               _moveCdView.btn.enable = false;
               _loc4_ = model.boradInfo;
               _loc5_ = _loc3_.data;
               ChessPvpManager.Instance.operChess(ChessPvpOp.BOARD_OP_ROLE_MOVE,_loc4_.boardUid,_loc5_.userID,_loc5_.servername,_boxInfo.pos);
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("chesspvp.battle.noPath"));
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_panle);
         _panle = null;
         ObjectUtils.disposeObject(_rTopTbg);
         _rTopTbg = null;
         ObjectUtils.disposeObject(_bRtopTitle);
         _bRtopTitle = null;
         ObjectUtils.disposeObject(_moveCdView);
         _moveCdView = null;
         ObjectUtils.disposeObject(_riverCdView);
         _riverCdView = null;
         ObjectUtils.disposeObject(_posTxt);
         _posTxt = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _boxInfo = null;
      }
   }
}

