package consortiachess.board
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortiachess.util.ChesspvpResourceUtil;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.chesspvp.ChesspvpBoxInfo;
   
   public class ChesspvpBoxItem extends Sprite
   {
      
      private var _data:ChesspvpBoxInfo;
      
      private var _teamBit:Bitmap;
      
      private var _teamState:int;
      
      private var _clickSp:Sprite;
      
      private var _pass:int = 1;
      
      private var _buffBit:Bitmap;
      
      private var _effectFightBit:Bitmap;
      
      private var _fightState:int;
      
      private var _numTxt:FilterFrameText;
      
      private var _numBit:Bitmap;
      
      private var _numState:int;
      
      private var _numCount:int;
      
      private var _board:ConsortiaChessBoard;
      
      public var posX:int;
      
      public var posY:int;
      
      private var _buffState:int = -1;
      
      public function ChesspvpBoxItem(param1:ConsortiaChessBoard)
      {
         super();
         _board = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _teamBit = new Bitmap();
         _buffBit = new Bitmap();
         _effectFightBit = new Bitmap();
         _numBit = new Bitmap();
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.numTxt");
         _buffBit.x = 15;
         _buffBit.y = 10;
         _clickSp = new Sprite();
         _clickSp.graphics.beginFill(16711680,0);
         _clickSp.graphics.drawRect(1,1,71,71);
         _clickSp.graphics.endFill();
         addChild(_teamBit);
         addChild(_buffBit);
         addChild(_numBit);
         addChild(_effectFightBit);
         addChild(_numTxt);
         addChild(_clickSp);
         this.hitArea = _clickSp;
         buttonMode = true;
      }
      
      private function set teamState(param1:int) : void
      {
         if(_teamState == param1)
         {
            return;
         }
         _teamState = param1;
         switch(_teamState)
         {
            case 0:
               _teamBit.bitmapData = null;
               break;
            case 1:
               _teamBit.bitmapData = ChesspvpResourceUtil.ins.whiteBoxData;
               break;
            case 2:
               _teamBit.bitmapData = ChesspvpResourceUtil.ins.blackBoxData;
         }
      }
      
      public function set buffState(param1:int) : void
      {
         if(_buffState == param1)
         {
            return;
         }
         _buffState = param1;
         if(_buffState > 0)
         {
            _buffBit.bitmapData = ChesspvpResourceUtil.ins.buffDataList[_buffState];
         }
         else
         {
            _buffBit.bitmapData = null;
         }
      }
      
      public function set fightState(param1:int) : void
      {
         if(_fightState == param1)
         {
            return;
         }
         _fightState = param1;
         switch(_fightState)
         {
            case 0:
               _effectFightBit.bitmapData = null;
               break;
            case 1:
               _effectFightBit.bitmapData = ChesspvpResourceUtil.ins.fightEffData;
         }
      }
      
      public function set numState(param1:int) : void
      {
         var _loc2_:int = 0;
         _numState = param1;
         var _loc3_:Array = _data.blackList.concat(_data.whiteList);
         if(_numState == 0)
         {
            _numTxt.visible = false;
            _numBit.bitmapData = null;
            for each(_loc2_ in _loc3_)
            {
               _board.showRoleByState(_loc2_,true);
            }
         }
         else if(_numState == 1)
         {
            _numTxt.visible = true;
            _numTxt.text = "x" + _numCount;
            _numBit.bitmapData = ChesspvpResourceUtil.ins.teamBoxData;
            for each(_loc2_ in _loc3_)
            {
               _board.showRoleByState(_loc2_,false);
            }
         }
      }
      
      public function get pass() : int
      {
         return _pass;
      }
      
      public function get data() : ChesspvpBoxInfo
      {
         return _data;
      }
      
      public function set data(param1:ChesspvpBoxInfo) : void
      {
         _data = param1;
      }
      
      public function refreshView() : void
      {
         if(_data == null)
         {
            return;
         }
         teamState = _data.team;
         buffState = _data.buffId;
         if(_data.blackList.length > 0 && _data.whiteList.length > 0)
         {
            fightState = 1;
         }
         else
         {
            fightState = 0;
         }
         _numCount = _data.blackList.length + _data.whiteList.length;
         if(_numCount > 1)
         {
            numState = 1;
         }
         else
         {
            numState = 0;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         if(ChesspvpResourceUtil.ins.lastChooseItem == this)
         {
            return;
         }
         ChesspvpResourceUtil.ins.lastChooseItem = this;
         addChild(ChesspvpResourceUtil.ins.chooseBit);
         _board.updateChooseNodeUI(_data,posX,posY);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
         _board = null;
      }
   }
}

