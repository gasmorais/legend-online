package bingo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.bingo.BingoResultDataMsg;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class BingoBallMovieView extends Component
   {
      
      private var _startPos1:Array = [-48,30];
      
      private var _pos1Arr:Array = [[91,30],[31,30]];
      
      private var _ball1Arr:Array = [];
      
      private var _container1:Sprite;
      
      private var _mask1:Shape;
      
      private var _container3:Sprite;
      
      private var _mask3:MovieClip;
      
      private var _startPos2:Array = [-48,30];
      
      private var _pos2Arr:Array = [[336,30],[271,30],[212,30],[151,30],[91,30],[31,30]];
      
      private var _ball2Arr:Array = [];
      
      private var _container2:Sprite;
      
      private var _mask2:Shape;
      
      private var _container4:Sprite;
      
      private var _mask4:MovieClip;
      
      private var _timeId:int;
      
      public function BingoBallMovieView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _container1 = ComponentFactory.Instance.creatCustomObject("bingo.movie.ballSprite");
         _mask1 = new Shape();
         _mask1.graphics.beginFill(16777215,0);
         _mask1.graphics.drawRect(0,0,305,65);
         _mask1.graphics.endFill();
         _container1.x = -281;
         _mask1.x = -281;
         _container1.mask = _mask1;
         addChild(_container1);
         addChild(_mask1);
         _container3 = ComponentFactory.Instance.creatCustomObject("bingo.movie.ballSprite");
         _mask3 = ComponentFactory.Instance.creatCustomObject("asset.bingo.bigBallMask");
         _container3.x = -392;
         _mask3.x = -392;
         _mask3.y = -30;
         _container3.mask = _mask3;
         addChild(_container3);
         addChild(_mask3);
         _container2 = ComponentFactory.Instance.creatCustomObject("bingo.movie.ballSprite");
         _mask2 = new Shape();
         _mask2.graphics.beginFill(16777215,0);
         _mask2.graphics.drawRect(0,0,305,65);
         _mask2.graphics.endFill();
         _container2.mask = _mask2;
         addChild(_container2);
         addChild(_mask2);
         _container4 = ComponentFactory.Instance.creatCustomObject("bingo.movie.ballSprite");
         _mask4 = ComponentFactory.Instance.creatCustomObject("asset.bingo.bigBallMask");
         _container4.x = -110;
         _mask4.x = -110;
         _mask4.y = -30;
         _container4.mask = _mask4;
         addChild(_container4);
         addChild(_mask4);
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("BALL_START",__ballStartHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("BALL_START",__ballStartHandler);
      }
      
      public function constructBalls(param1:BingoResultDataMsg) : void
      {
         var _loc2_:BingoBallItem = null;
         var _loc5_:int = 0;
         while(_ball2Arr.length)
         {
            ObjectUtils.disposeObject(_ball2Arr.pop());
         }
         while(_ball1Arr.length)
         {
            ObjectUtils.disposeObject(_ball1Arr.pop());
         }
         clearTimeout(_timeId);
         _loc2_ = new BingoBallItem();
         _loc2_.x = _pos2Arr[0][0];
         _loc2_.y = _pos2Arr[0][1];
         _loc2_.index = 0;
         _loc2_.data = 0;
         _container2.addChild(_loc2_);
         _ball2Arr.push(_loc2_);
         if(!param1)
         {
            return;
         }
         var _loc3_:Array = param1.lotteryNum;
         var _loc6_:Array = param1.luckNum;
         var _loc4_:int = 0;
         var _loc7_:int;
         _loc5_ = _loc7_ = _loc3_.length > 5 ? _loc3_.length - 5 : 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_++;
            _loc2_ = new BingoBallItem();
            _loc2_.x = _pos2Arr[_loc4_][0];
            _loc2_.y = _pos2Arr[_loc4_][1];
            _loc2_.index = _loc4_;
            _loc2_.data = _loc3_[_loc5_];
            _container2.addChild(_loc2_);
            _ball2Arr.push(_loc2_);
            _loc5_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            _loc2_ = new BingoBallItem();
            _loc2_.x = _pos1Arr[_loc5_][0];
            _loc2_.y = _pos1Arr[_loc5_][1];
            _loc2_.index = _loc5_;
            _loc2_.data = _loc6_[_loc5_];
            _container1.addChild(_loc2_);
            _ball1Arr.push(_loc2_);
            _loc5_++;
         }
      }
      
      private function __ballStartHandler(param1:NotificationEvent) : void
      {
         var _loc3_:int = int(param1.data.num);
         var _loc4_:BingoResultDataMsg = BingoResultDataMsg(param1.data.resultMsg);
         var _loc2_:Boolean = Boolean(param1.data.luckNum);
         if(_loc2_)
         {
            if(_ball1Arr[_ball1Arr.length - 1] && _ball1Arr[_ball1Arr.length - 1].data == _loc3_)
            {
               return;
            }
         }
         else if(_ball2Arr[_ball2Arr.length - 1] && _ball2Arr[_ball2Arr.length - 1].data == _loc3_)
         {
            return;
         }
         if(_loc2_)
         {
            creatBallHandler1(_loc3_);
         }
         else
         {
            creatBallHandler2(_loc3_);
         }
      }
      
      private function creatBallHandler1(param1:int) : void
      {
         var num:int = param1;
         var bigBall:BingoBigBallItem = new BingoBigBallItem();
         bigBall.x = _startPos1[0] + 96;
         bigBall.y = _startPos1[1] - 5;
         bigBall.index = -1;
         bigBall.data = num;
         bigBall.playMovie();
         _container3.addChild(bigBall);
         _timeId = setTimeout(function():void
         {
            clearTimeout(_timeId);
            var _loc1_:BingoBallItem = new BingoBallItem();
            _loc1_.x = _startPos1[0];
            _loc1_.y = _startPos1[1];
            _loc1_.index = -1;
            _loc1_.data = num;
            var _loc2_:int = int(_ball1Arr.length);
            _loc1_.index = _loc2_;
            if(_pos1Arr[_loc2_])
            {
               _loc1_.playMovie((2 - _loc2_) * 0.3,_pos1Arr[_loc2_][0],_pos1Arr[_loc2_][1],(2 - _loc2_) * 360);
               _ball1Arr.push(_loc1_);
               _container1.addChild(_loc1_);
            }
         },1500);
      }
      
      private function creatBallHandler2(param1:int) : void
      {
         var num:int = param1;
         var bigBall:BingoBigBallItem = new BingoBigBallItem();
         bigBall.x = _startPos2[0] + 96;
         bigBall.y = _startPos2[1] - 5;
         bigBall.index = -1;
         bigBall.data = num;
         bigBall.playMovie();
         _container4.addChild(bigBall);
         _timeId = setTimeout(function():void
         {
            var _loc3_:int = 0;
            var _loc4_:int = 0;
            var _loc1_:BingoBallItem = null;
            clearTimeout(_timeId);
            var _loc2_:BingoBallItem = new BingoBallItem();
            _loc2_.x = _startPos2[0];
            _loc2_.y = _startPos2[1];
            _loc2_.index = -1;
            _loc2_.data = num;
            if(_ball2Arr.length == 6)
            {
               ObjectUtils.disposeObject(_ball2Arr.shift());
               _loc4_ = 0;
               while(_loc4_ < _ball2Arr.length)
               {
                  _loc1_ = _ball2Arr[_loc4_] as BingoBallItem;
                  _loc3_ = _loc1_.index - 1;
                  _loc1_.index = _loc3_;
                  _loc1_.playMovie(0.3,_pos2Arr[_loc3_][0],_pos2Arr[_loc3_][1],360);
                  _loc4_++;
               }
               _loc3_ = 5;
               _loc2_.index = _loc3_;
               _loc2_.playMovie(0.3,_pos2Arr[_loc3_][0],_pos2Arr[_loc3_][1],360);
               _ball2Arr.push(_loc2_);
               _container2.addChild(_loc2_);
            }
            else
            {
               _loc3_ = int(_ball2Arr.length);
               _loc2_.index = _loc3_;
               _loc2_.playMovie((6 - _loc3_) * 0.3,_pos2Arr[_loc3_][0],_pos2Arr[_loc3_][1],(6 - _loc3_) * 360);
               _ball2Arr.push(_loc2_);
               _container2.addChild(_loc2_);
            }
         },1500);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearTimeout(_timeId);
         ObjectUtils.disposeAllChildren(_container1);
         ObjectUtils.disposeObject(_container1);
         _container1 = null;
         ObjectUtils.disposeObject(_mask1);
         _mask1 = null;
         ObjectUtils.disposeAllChildren(_container3);
         ObjectUtils.disposeObject(_container3);
         _container3 = null;
         ObjectUtils.disposeViolentMc(_mask3);
         _mask3 = null;
         ObjectUtils.disposeAllChildren(_container2);
         ObjectUtils.disposeObject(_container2);
         _container2 = null;
         ObjectUtils.disposeObject(_mask2);
         _mask2 = null;
         ObjectUtils.disposeAllChildren(_container4);
         ObjectUtils.disposeObject(_container4);
         _container4 = null;
         ObjectUtils.disposeViolentMc(_mask4);
         _mask4 = null;
         if(_ball1Arr)
         {
            while(_ball1Arr.length)
            {
               ObjectUtils.disposeObject(_ball1Arr.pop());
            }
         }
         if(_ball2Arr)
         {
            while(_ball2Arr.length)
            {
               ObjectUtils.disposeObject(_ball2Arr.pop());
            }
         }
         _ball1Arr = null;
         _ball2Arr = null;
         _startPos1 = null;
         _pos1Arr = null;
         _startPos2 = null;
         _pos2Arr = null;
         super.dispose();
      }
   }
}

