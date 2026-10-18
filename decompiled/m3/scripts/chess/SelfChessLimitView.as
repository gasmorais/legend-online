package chess
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import mvc.module.chess.SelfChessManager;
   import mvc.module.chess.SelfChessPlayerInfo;
   
   public class SelfChessLimitView extends Sprite
   {
      
      public var _pawnIcon:Bitmap;
      
      public var _limitTxt:FilterFrameText;
      
      private var _mc:MovieClip;
      
      private var _grade:int = -1;
      
      private var _isFirst:Boolean = true;
      
      public function SelfChessLimitView()
      {
         super();
         initView();
         refreshView();
      }
      
      private function set grade(param1:int) : void
      {
         if(_grade == param1)
         {
            return;
         }
         _grade = param1;
         if(!_isFirst)
         {
            _mc.gotoAndPlay(1);
         }
         _isFirst = false;
      }
      
      private function initView() : void
      {
         _pawnIcon = ComponentFactory.Instance.creatBitmap("asset.selfchess.pawnIcon");
         _limitTxt = ComponentFactory.Instance.creatComponentByStylename("ui.selfchess.limitTxt");
         _mc = ComponentFactory.Instance.creatCustomObject("asset.selfchess.upMc");
         addChild(_pawnIcon);
         addChild(_limitTxt);
         addChild(_mc);
         _mc.gotoAndStop(1);
         this.mouseEnabled = this.mouseChildren = false;
      }
      
      public function refreshView() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:SelfChessPlayerInfo = SelfChessManager.Ins.model.selfInfo;
         if(_loc6_)
         {
            grade = _loc6_.grade;
            _loc1_ = _loc6_.battleAry;
            _loc2_ = int(_loc1_.length);
            _loc3_ = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc4_ = int(_loc1_[_loc5_]);
               if(_loc4_ > 0)
               {
                  _loc3_++;
               }
               _loc5_++;
            }
            _limitTxt.text = _loc3_ + "/" + _loc6_.grade;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_pawnIcon);
         _pawnIcon = null;
         ObjectUtils.disposeObject(_limitTxt);
         _limitTxt = null;
         ObjectUtils.disposeViolentMc(_mc);
         _mc = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

