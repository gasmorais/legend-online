package lottery
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.LotteryEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import managers.LotteryManager;
   import mvc.module.lottery.LotteryModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class LotteryBoxItem extends Component
   {
      
      private var _boxItem:BaseItemView;
      
      private var _selectBg:Bitmap;
      
      private var _countTxt:FilterFrameText;
      
      private var _selected:Boolean;
      
      private var _delayTime:Number;
      
      private var _flickerEffct:MovieClip;
      
      public function LotteryBoxItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _boxItem = ComponentFactory.Instance.creatCustomObject("lottery.LotteryBoxItem");
         _selectBg = ComponentFactory.Instance.creatBitmap("asset.lottery.LotteryBoxItemSelect");
         _flickerEffct = ComponentFactory.Instance.creatCustomObject("lottery.goodsFlickerEffctMC");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("lottery.LotteryBoxItemCountTxt");
         addChild(_boxItem);
         addChild(_countTxt);
         addChild(_selectBg);
         addChild(_flickerEffct);
         _flickerEffct.visible = false;
         _flickerEffct.gotoAndStop(1);
         _selectBg.visible = false;
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("enterFrame",_stageFrame);
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         if(_boxItem)
         {
            _boxItem.data = param1;
         }
      }
      
      public function get data() : GoodsInfo
      {
         return _boxItem.data;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(isDie)
         {
            return;
         }
         _selected = param1;
         _delayTime = model.delayTime * 0.002;
         if(_selected)
         {
            _selectBg.alpha = 1;
            _selectBg.visible = true;
            _delayTime = model.delayTime > 400 ? 0.8 : model.delayTime * 0.002;
            if(_delayTime)
            {
               setTween();
            }
         }
         else if(!_delayTime)
         {
            _selectBg.visible = false;
         }
      }
      
      private function setTween() : void
      {
         TweenLite.killTweensOf(_selectBg);
         _selectBg.alpha = 0;
         var _loc1_:Number = _delayTime;
         if(_delayTime >= 0.6)
         {
            _loc1_ = 0.3;
         }
         if(_delayTime >= 0.8)
         {
            _loc1_ = 0.05;
         }
         TweenLite.to(_selectBg,_loc1_ + 0.2,{
            "alpha":1,
            "onComplete":hideBg
         });
      }
      
      private function hideBg() : void
      {
         hideMoveBg(_delayTime);
      }
      
      public function hideMoveBg(param1:Number) : void
      {
         if(isDie)
         {
            return;
         }
         TweenLite.to(_selectBg,param1,{"alpha":0});
      }
      
      public function flicker() : void
      {
         if(isDie)
         {
            return;
         }
         _selectBg.visible = false;
         _flickerEffct.visible = true;
         _flickerEffct.gotoAndPlay(1);
         StageReferance.stage.addEventListener("enterFrame",_stageFrame);
      }
      
      private function _stageFrame(param1:Event) : void
      {
         if(_flickerEffct.currentFrame == _flickerEffct.totalFrames)
         {
            _flickerEffct.visible = false;
            _flickerEffct.gotoAndStop(1);
            StageReferance.stage.removeEventListener("enterFrame",_stageFrame);
            if(_boxItem)
            {
               model.dispatchEvent(new LotteryEvent("lottery_effct_complete",_boxItem.data));
            }
            else
            {
               model.dispatchEvent(new LotteryEvent("lottery_effct_complete"));
            }
         }
      }
      
      private function get model() : LotteryModel
      {
         return LotteryManager.Instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_boxItem);
         ObjectUtils.disposeObject(_selectBg);
         ObjectUtils.disposeObject(_countTxt);
         ObjectUtils.disposeObject(_flickerEffct);
         _countTxt = null;
         _flickerEffct = null;
         _boxItem = null;
         _selectBg = null;
         super.dispose();
      }
   }
}

