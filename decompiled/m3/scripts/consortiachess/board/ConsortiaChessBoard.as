package consortiachess.board
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import consortiachess.ui.ChessPvpBattleRTopUI;
   import consortiachess.ui.ChesspvpBattleNodeUI;
   import consortiachess.util.ChesspvpResourceUtil;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChessPvpModel;
   import mvc.module.chesspvp.ChesspvpBoxInfo;
   import mvc.module.chesspvp.ChesspvpRoleInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.utils.SimpleDictionary;
   
   public class ConsortiaChessBoard extends Sprite implements IEnterFrame
   {
      
      private var _bg:MovieClip;
      
      private var _boxContainer:Sprite;
      
      private var _roleContainer:Sprite;
      
      private var _lineContainer:Sprite;
      
      private var _upmask:Bitmap;
      
      private var _upmask2:Bitmap;
      
      private var _boxTwoList:Array = [];
      
      private var _boxItemDic:Dictionary = new Dictionary();
      
      private var _roleChessDic:Dictionary = new Dictionary();
      
      private var _lineDic:Dictionary = new Dictionary();
      
      private var _selfTeam:int;
      
      private var _topUI:ChessPvpBattleRTopUI;
      
      private var _nodeInfoUI:ChesspvpBattleNodeUI;
      
      public function ConsortiaChessBoard()
      {
         super();
         initView();
         initData();
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function initView() : void
      {
         this.x = 320;
         _bg = ComponentFactory.Instance.creatCustomObject("asset.chesspvp.bg");
         _boxContainer = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.battleBoxContainer");
         _roleContainer = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.battleBoxContainer");
         _lineContainer = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.battleBoxContainer");
         _upmask = ComponentFactory.Instance.creatBitmap("asset.chesspvp.upmask1");
         _upmask2 = ComponentFactory.Instance.creatBitmap("asset.chesspvp.upMask2");
         addChild(_bg);
         addChild(_boxContainer);
         addChild(_roleContainer);
         addChild(_lineContainer);
         addChild(_upmask);
         addChild(_upmask2);
         _roleContainer.mouseEnabled = _roleContainer.mouseChildren = false;
         _topUI = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.bTopRUI");
         _nodeInfoUI = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.bNodeUI");
         addChild(_topUI);
         addChild(_nodeInfoUI);
      }
      
      private function initData() : void
      {
         var _loc3_:ChesspvpBoxItem = null;
         var _loc2_:ChesspvpBoxInfo = null;
         var _loc9_:Array = model.boradInfo.boxDic.getList();
         _loc9_.sortOn("pos",16);
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < 8)
         {
            _boxTwoList[_loc6_] = [];
            _loc7_ = 0;
            while(_loc7_ < 8)
            {
               _loc3_ = new ChesspvpBoxItem(this);
               _loc2_ = _loc9_[_loc6_ * 8 + _loc7_];
               _loc3_.data = _loc2_;
               _boxTwoList[_loc6_].push(_loc3_);
               _boxItemDic[_loc2_.pos] = _loc3_;
               _loc7_++;
            }
            _loc6_++;
         }
         if(model.selfInfo.team == 2)
         {
            _boxTwoList.reverse();
            for each(var _loc8_:Array in _boxTwoList)
            {
               _loc8_.reverse();
            }
            _bg.gotoAndStop(2);
         }
         _loc6_ = 0;
         while(_loc6_ < 8)
         {
            _loc7_ = 0;
            while(_loc7_ < 8)
            {
               _loc3_ = _boxTwoList[_loc6_][_loc7_];
               _loc3_.x = _loc7_ * 73;
               _loc3_.y = _loc6_ * 73;
               _loc3_.posX = _loc7_;
               _loc3_.posY = _loc6_;
               _boxContainer.addChild(_loc3_);
               _loc7_++;
            }
            _loc6_++;
         }
         initRolePieces();
         for each(var _loc5_:ConsortiaChessBasePiece in _roleChessDic)
         {
            if(_loc5_.data.currPos > 0)
            {
               _loc3_ = _boxItemDic[_loc5_.data.currPos];
               _loc5_.x = _loc3_.x;
               _loc5_.y = _loc3_.y;
            }
         }
         var _loc1_:ChesspvpRoleInfo = model.selfInfo;
         var _loc4_:ChesspvpBoxItem = getPieceByPos(_loc1_.currPos);
         if(_loc4_)
         {
            _loc4_.dispatchEvent(new MouseEvent("click"));
         }
      }
      
      private function initRolePieces() : void
      {
         var _loc1_:* = null;
         var _loc2_:ConsortiaChessBasePiece = null;
         var _loc3_:SimpleDictionary = model.boradInfo.roleDic;
         var _loc4_:Array = _loc3_.getList();
         for each(_loc1_ in _loc4_)
         {
            _loc2_ = createChessRoleItem(_loc1_.chessType);
            if(_loc1_ == model.selfInfo)
            {
               ChesspvpResourceUtil.ins.selfChess = _loc2_;
            }
            _loc2_.data = _loc1_;
            _roleChessDic[_loc1_.livingID] = _loc2_;
            _roleContainer.addChild(_loc2_);
         }
      }
      
      public function changeRoleUp(param1:int, param2:int) : void
      {
         var _loc3_:ConsortiaChessBasePiece = null;
         var _loc4_:ConsortiaChessBasePiece = _roleChessDic[param1];
         if(_loc4_)
         {
            _loc3_ = createChessRoleItem(param2);
            if(_loc4_.data == model.selfInfo)
            {
               ChesspvpResourceUtil.ins.selfChess = _loc3_;
            }
            _loc3_.data = _loc4_.data;
            _loc3_.x = _loc4_.x;
            _loc3_.y = _loc4_.y;
            _roleChessDic[param1] = _loc3_;
            _roleContainer.addChild(_loc3_);
            _loc4_.clean();
         }
      }
      
      private function createChessRoleItem(param1:int) : ConsortiaChessBasePiece
      {
         var _loc2_:ConsortiaChessBasePiece = null;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = new ConsortiaChessPawn(this);
               break;
            case 1:
               _loc2_ = new ConsortiaChessRook(this);
               break;
            case 2:
               _loc2_ = new ConsortiaChessKnight(this);
               break;
            case 3:
               _loc2_ = new ConsortiaChessBishop(this);
               break;
            case 4:
               _loc2_ = new ConsortiaChessQueen(this);
               break;
            case 5:
               _loc2_ = new ConsortiaChessKing(this);
         }
         return _loc2_;
      }
      
      public function getPiece(param1:int, param2:int) : int
      {
         var _loc3_:ChesspvpBoxItem = _boxTwoList[param2][param1];
         return _loc3_.pass;
      }
      
      public function getPieceByPos(param1:int) : ChesspvpBoxItem
      {
         return _boxItemDic[param1];
      }
      
      public function enterFrame() : void
      {
         for each(var _loc2_:ConsortiaChessBasePiece in _roleChessDic)
         {
            _loc2_.updateView();
         }
         for each(var _loc3_:Array in _boxTwoList)
         {
            for each(var _loc1_:ChesspvpBoxItem in _loc3_)
            {
               _loc1_.refreshView();
            }
         }
         _nodeInfoUI.updateView();
         _topUI.updateView();
      }
      
      private function get model() : ChessPvpModel
      {
         return ChessPvpManager.Instance.model;
      }
      
      public function drawLine(param1:Point, param2:Point, param3:int, param4:int) : void
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc12_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc5_:Point = null;
         var _loc7_:Point = null;
         var _loc17_:Point = null;
         var _loc18_:Point = null;
         var _loc8_:Point = null;
         var _loc11_:Shape = _lineDic[param3];
         if(_loc11_ == null)
         {
            _loc11_ = new Shape();
            _lineDic[param3] = _loc11_;
            _lineContainer.addChild(_loc11_);
         }
         else
         {
            if(param4 == 1)
            {
               _loc9_ = 55551;
            }
            else if(param4 == 2)
            {
               _loc9_ = 65280;
            }
            else
            {
               _loc9_ = 16711680;
            }
            _loc11_.graphics.clear();
            _loc11_.graphics.lineStyle(1,_loc9_);
            _loc11_.graphics.moveTo(param1.x,param1.y);
            _loc11_.graphics.lineTo(param2.x,param2.y);
            _loc10_ = 6;
            _loc12_ = (param2.y - param1.y) / (param2.x - param1.x);
            _loc14_ = -1 / _loc12_;
            _loc13_ = param2.y - _loc14_ * param2.x;
            _loc15_ = Math.atan(_loc14_);
            _loc6_ = Math.cos(_loc15_);
            _loc16_ = Math.sin(_loc15_);
            _loc5_ = new Point(param2.x + _loc10_ * _loc6_,param2.y + _loc10_ * _loc16_);
            _loc7_ = new Point(param2.x - _loc10_ * _loc6_,param2.y - _loc10_ * _loc16_);
            _loc17_ = new Point(param2.x - param1.x,param2.y - param1.y);
            _loc18_ = _loc17_.clone();
            _loc18_.normalize(1);
            _loc8_ = new Point(param2.x + _loc10_ * _loc18_.x,param2.y + _loc10_ * _loc18_.y);
            _loc11_.graphics.beginFill(_loc9_,1);
            _loc11_.graphics.moveTo(_loc5_.x,_loc5_.y);
            _loc11_.graphics.lineTo(_loc7_.x,_loc7_.y);
            _loc11_.graphics.lineTo(_loc8_.x,_loc8_.y);
            _loc11_.graphics.lineTo(_loc5_.x,_loc5_.y);
            _loc11_.graphics.endFill();
         }
      }
      
      public function clearLine(param1:int) : void
      {
         var _loc2_:Shape = _lineDic[param1];
         if(_loc2_ && _loc2_.parent)
         {
            _loc2_.parent.removeChild(_loc2_);
         }
         delete _lineDic[param1];
      }
      
      public function showRoleByState(param1:int, param2:Boolean) : void
      {
         var _loc3_:ConsortiaChessBasePiece = _roleChessDic[param1];
         if(_loc3_)
         {
            _loc3_.updateVisible(param2);
         }
      }
      
      public function updateChooseNodeUI(param1:ChesspvpBoxInfo, param2:int, param3:int) : void
      {
         _nodeInfoUI.updateBoxInfo(param1,param2,param3);
      }
      
      public function dispose() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         for each(var _loc3_:Array in _boxTwoList)
         {
            for each(var _loc1_:ChesspvpBoxItem in _loc3_)
            {
               ObjectUtils.disposeObject(_loc1_);
            }
         }
         _boxTwoList = null;
         _boxItemDic = null;
         for each(var _loc2_:ConsortiaChessBasePiece in _roleChessDic)
         {
            _loc2_.clean();
         }
         _roleChessDic = null;
         ObjectUtils.disposeViolentMc(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_upmask);
         _upmask = null;
         ObjectUtils.disposeObject(_upmask2);
         _upmask2 = null;
         ObjectUtils.disposeObject(_topUI);
         _topUI = null;
         ObjectUtils.disposeObject(_nodeInfoUI);
         _nodeInfoUI = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _lineDic = null;
      }
   }
}

