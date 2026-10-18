package yishi.view.tips
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Sprite;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class MultiMessageTipItem extends Sprite
   {
      
      private var _text:FilterFrameText;
      
      private var _callBack:Function;
      
      private var _timeOutId:int;
      
      public function MultiMessageTipItem(param1:Function)
      {
         super();
         _callBack = param1;
      }
      
      private function initView() : void
      {
         _text = ComponentFactory.Instance.creatComponentByStylename("tips.MultiMessageTipItem.text");
         this.graphics.clear();
         this.graphics.beginFill(0,0.6);
         this.graphics.drawRoundRect(0,0,600,28,4,4);
         this.graphics.endFill();
      }
      
      private function completeFun() : void
      {
         TweenMax.killTweensOf(this);
         if(_text.parent)
         {
            removeChild(_text);
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         _callBack();
      }
      
      public function setTip(param1:String) : void
      {
         TweenMax.killTweensOf(this);
         if(_text == null)
         {
            initView();
         }
         addChild(_text);
         _text.htmlText = param1;
         this.alpha = 1;
         if(_timeOutId > 0)
         {
            clearTimeout(_timeOutId);
         }
         setTimeout(hide,2000);
      }
      
      private function hide() : void
      {
         clearTimeout(_timeOutId);
         _timeOutId = 0;
         TweenMax.to(this,2,{
            "alpha":0,
            "onComplete":completeFun
         });
      }
   }
}

