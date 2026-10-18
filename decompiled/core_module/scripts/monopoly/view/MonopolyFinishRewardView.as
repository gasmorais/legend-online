package monopoly.view
{
   import com.greensock.TweenMax;
   import com.greensock.events.TweenEvent;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.campaign.TempMsg;
   import flash.display.Sprite;
   import flash.filters.BlurFilter;
   import mvc.module.singlepass.SinglePassCardStateInfo;
   
   public class MonopolyFinishRewardView extends Sprite implements Disposeable
   {
      
      private var _itemView1:MonopolyFinishRewardItemView;
      
      private var _itemView2:MonopolyFinishRewardItemView;
      
      private var _itemView3:MonopolyFinishRewardItemView;
      
      private var _itemView4:MonopolyFinishRewardItemView;
      
      private var _itemView5:MonopolyFinishRewardItemView;
      
      private var _itemState1:SinglePassCardStateInfo;
      
      private var _itemState2:SinglePassCardStateInfo;
      
      private var _itemState3:SinglePassCardStateInfo;
      
      private var _itemState4:SinglePassCardStateInfo;
      
      private var _itemState5:SinglePassCardStateInfo;
      
      private var _delayTimes:Array = [0.1,0.2,0.3,0.4,0.6,0.8,1];
      
      private var _delayCount:int = 7;
      
      private var _infos:Array;
      
      private var _rewardIndex:int;
      
      private var _blurCount:int = 4;
      
      private var _mediumCount:int = 3;
      
      private var _lowCount:int = 2;
      
      private var _callBack:Function;
      
      private var _blurFilterHigh:BlurFilter = new BlurFilter(5,5,3);
      
      private var _blurFilterMedium:BlurFilter = new BlurFilter(4,4,3);
      
      private var _blurFilterLow:BlurFilter = new BlurFilter(3,3,3);
      
      private var _playing:Boolean = false;
      
      private var _blurIndex:int = 0;
      
      private var _infoIndex:int = 0;
      
      private var _turnIndex:int = 0;
      
      private var _turnCompleteCount:int = 0;
      
      private var _turnCompleteMax:int = 4;
      
      public function MonopolyFinishRewardView()
      {
         super();
         initView();
         addEvent();
      }
      
      public function initInfos(param1:Array) : void
      {
         _infos = param1;
         initInfo();
         initState();
      }
      
      private function initView() : void
      {
         _itemState1 = new SinglePassCardStateInfo(0,7,175,0.8,"left");
         _itemState2 = new SinglePassCardStateInfo(0.3,7,175,0.8,"left");
         _itemState3 = new SinglePassCardStateInfo(1,0,80,1,"center");
         _itemState4 = new SinglePassCardStateInfo(0.3,11,0,0.7,"right");
         _itemState5 = new SinglePassCardStateInfo(0,11,0,0.7,"right");
         _itemView1 = new MonopolyFinishRewardItemView();
         _itemView2 = new MonopolyFinishRewardItemView();
         _itemView3 = new MonopolyFinishRewardItemView();
         _itemView4 = new MonopolyFinishRewardItemView();
         _itemView5 = new MonopolyFinishRewardItemView();
         addChild(_itemView1);
         addChild(_itemView2);
         addChild(_itemView3);
         addChild(_itemView4);
         addChild(_itemView5);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_itemView1);
         _itemView1 = null;
         ObjectUtils.disposeObject(_itemView2);
         _itemView2 = null;
         ObjectUtils.disposeObject(_itemView3);
         _itemView3 = null;
         ObjectUtils.disposeObject(_itemView4);
         _itemView4 = null;
         ObjectUtils.disposeObject(_itemView5);
         _itemView5 = null;
         ObjectUtils.disposeAllChildren(this);
         _itemState1 = null;
         _itemState2 = null;
         _itemState3 = null;
         _itemState4 = null;
         _itemState5 = null;
         _blurFilterHigh = null;
         _blurFilterMedium = null;
         _blurFilterLow = null;
         _delayTimes = null;
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function start(param1:Function = null, param2:int = 0, param3:int = 4) : void
      {
         _callBack = param1;
         _rewardIndex = param2;
         _blurCount = param3;
         _infoIndex = _rewardIndex - (_blurCount + _delayCount) % _infos.length;
         _blurIndex = 0;
         _turnIndex = 0;
         _playing = true;
         killTweens();
         this.filters = [_blurFilterHigh];
         initInfo();
         initState();
         turnNext();
      }
      
      private function getInfo(param1:int) : TempMsg
      {
         if(param1 < 0)
         {
            param1 += _infos.length;
         }
         else if(param1 >= _infos.length)
         {
            param1 -= _infos.length;
         }
         return _infos[param1] as TempMsg;
      }
      
      private function initInfo() : void
      {
         var _loc1_:int = _infoIndex % _infos.length;
         _itemView1.data = getInfo(_loc1_ - 2);
         _itemView2.data = getInfo(_loc1_ - 1);
         _itemView3.data = getInfo(_loc1_);
         _itemView4.data = getInfo(_loc1_ + 1);
         _itemView5.data = getInfo(_loc1_ + 2);
      }
      
      private function initState() : void
      {
         setItemState(_itemView1,_itemState1);
         setItemState(_itemView2,_itemState2);
         setItemState(_itemView3,_itemState3);
         setItemState(_itemView4,_itemState4);
         setItemState(_itemView5,_itemState5);
      }
      
      private function setItemState(param1:MonopolyFinishRewardItemView, param2:SinglePassCardStateInfo) : void
      {
         param1.x = param2.x;
         param1.y = param2.y;
         param1.alpha = param2.alpha;
         param1.scaleX = param2.scale;
         param1.scaleY = param2.scale;
      }
      
      private function turnNext(param1:Number = 0.05) : void
      {
         tweenCard(_itemView2,_itemState1,param1);
         tweenCard(_itemView3,_itemState2,param1);
         tweenCard(_itemView4,_itemState3,param1);
         tweenCard(_itemView5,_itemState4,param1);
      }
      
      private function tweenCard(param1:MonopolyFinishRewardItemView, param2:SinglePassCardStateInfo, param3:Number) : void
      {
         var _loc4_:Object = {};
         _loc4_["alpha"] = param2.alpha;
         _loc4_["x"] = param2.x;
         _loc4_["y"] = param2.y;
         _loc4_["scaleX"] = param2.scale;
         _loc4_["scaleY"] = param2.scale;
         _loc4_["onCompleteListener"] = tweenCardCompleteHandler;
         TweenMax.to(param1,param3,_loc4_);
      }
      
      private function tweenCardCompleteHandler(param1:TweenEvent) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:MonopolyFinishRewardItemView = param1.target.target as MonopolyFinishRewardItemView;
         TweenMax.killTweensOf(_loc2_);
         _turnCompleteCount = _turnCompleteCount + 1;
         if(_turnCompleteCount >= _turnCompleteMax)
         {
            _turnCompleteCount = 0;
            _turnIndex = _turnIndex + 1;
            _infoIndex = _infoIndex + 1;
            if(_turnIndex < _blurCount)
            {
               this.filters = [_blurFilterHigh];
               initInfo();
               initState();
               turnNext();
            }
            else if(_turnIndex < _blurCount + _delayCount)
            {
               if(_turnIndex < _blurCount + _mediumCount)
               {
                  this.filters = [_blurFilterMedium];
               }
               else if(_turnIndex < _blurCount + _mediumCount + _lowCount)
               {
                  this.filters = [_blurFilterLow];
               }
               else
               {
                  this.filters = [];
               }
               _loc3_ = Number(_delayTimes[_turnIndex - _blurCount]);
               initInfo();
               initState();
               turnNext(_loc3_);
            }
            else if(_callBack != null)
            {
               _callBack();
            }
         }
      }
      
      private function killTweens() : void
      {
         TweenMax.killTweensOf(_itemView2);
         TweenMax.killTweensOf(_itemView3);
         TweenMax.killTweensOf(_itemView4);
         TweenMax.killTweensOf(_itemView5);
      }
      
      public function dispose() : void
      {
         killTweens();
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

