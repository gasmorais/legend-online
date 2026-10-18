package blackjack
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class BlackjackFlyMediator
   {
      
      private var _item:BlackjackCard;
      
      private var _contain:Sprite;
      
      private var _original:Point;
      
      private var _delay:Number;
      
      private var _callback:Function;
      
      private var _index:int;
      
      private var _timeId:int;
      
      public function BlackjackFlyMediator(param1:BlackjackCard, param2:Sprite, param3:Boolean = false, param4:Function = null, param5:int = 0, param6:Number = 0)
      {
         super();
         _item = param1;
         _contain = param2;
         _delay = param6;
         _callback = param4;
         _index = param5;
         if(param3)
         {
            rotateItem();
         }
         else
         {
            flyItem();
         }
      }
      
      private function flyItem() : void
      {
         var from:Point;
         _original = new Point(_item.x,_item.y);
         var to:Point = _item.parent.localToGlobal(new Point(_item.x,_item.y));
         _item.parent.removeChild(_item);
         from = new Point(262,152);
         _item.x = from.x;
         _item.y = from.y;
         TweenMax.to(_item,0.6,{
            "delay":_delay,
            "x":to.x,
            "y":to.y,
            "onUpdate":function():void
            {
               if(!_item.parent)
               {
                  StageReferance.stage.addChild(_item);
               }
            },
            "onComplete":_moveComplete
         });
      }
      
      private function _moveComplete() : void
      {
         _item.x = _original.x;
         _item.y = _original.y;
         _contain.addChild(_item);
         if(_callback is Function)
         {
            _callback(_index);
         }
         TweenMax.killTweensOf(_item);
         _item = null;
         _contain = null;
         _callback = null;
      }
      
      private function rotateItem() : void
      {
         _item.parent.removeChild(_item);
         _timeId = setTimeout(function():void
         {
            clearTimeout(_timeId);
            if(_contain && _item)
            {
               _contain.addChild(_item);
            }
            if(_callback is Function)
            {
               _callback(_index);
            }
            _item = null;
            _contain = null;
            _callback = null;
         },500);
      }
   }
}

