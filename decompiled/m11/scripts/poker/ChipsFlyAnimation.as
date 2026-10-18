package poker
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.pet.CardMsg;
   import com.road.yishi.proto.pet.TablePotDivisionMsg;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class ChipsFlyAnimation
   {
      
      private var _poolView:PokerPoolView;
      
      private var _playsSprite:Sprite;
      
      private var _cardsSprite:Sprite;
      
      private var _poolSprite:Sprite;
      
      private var _itemMsg:TablePotDivisionMsg;
      
      private var _timeId:int;
      
      public function ChipsFlyAnimation(param1:PokerPoolView, param2:Sprite, param3:TablePotDivisionMsg)
      {
         super();
         _poolView = param1;
         _playsSprite = param2;
         _poolSprite = param1.cardSprite;
         _itemMsg = param3;
      }
      
      public function playFly(param1:int) : void
      {
         var playerItem:PokerPlayerView;
         var playerView:PokerPlayerView;
         var to:Point;
         var randomNum:Number;
         var flyIcon:Image;
         var cardMsg:CardMsg;
         var card:PokerCardView;
         var m:int;
         var i:int;
         var $delay:int = param1;
         var from:Point = _poolView.poolChipsTxt.parent.localToGlobal(new Point(_poolView.poolChipsTxt.x,_poolView.poolChipsTxt.y));
         var v:int = 0;
         while(v < _playsSprite.numChildren)
         {
            playerView = _playsSprite.getChildAt(v) as PokerPlayerView;
            if(playerView.info.userId == _itemMsg.player.userId)
            {
               playerItem = playerView;
            }
            v = v + 1;
         }
         to = playerItem.parent.localToGlobal(new Point(playerItem.x,playerItem.y));
         v = 0;
         while(v < 5)
         {
            randomNum = 1 + v * 0.5;
            flyIcon = ComponentFactory.Instance.creatComponentByStylename("poker.chipIcon1");
            flyIcon.x = from.x;
            flyIcon.y = from.y;
            TweenMax.to(flyIcon,randomNum,{
               "delay":$delay,
               "x":to.x,
               "y":to.y,
               "onUpdate":function():void
               {
                  if(!flyIcon.parent)
                  {
                     StageReferance.stage.addChild(flyIcon);
                  }
               },
               "onComplete":_moveComplete,
               "onCompleteParams":[flyIcon]
            });
            v = v + 1;
         }
         _cardsSprite = playerItem.cardSprite;
         m = 0;
         while(m < _cardsSprite.numChildren)
         {
            card = _cardsSprite.getChildAt(m) as PokerCardView;
            card.alpha = 0.5;
            m = m + 1;
         }
         m = 0;
         while(m < _poolSprite.numChildren)
         {
            card = _poolSprite.getChildAt(m) as PokerCardView;
            card.alpha = 0.5;
            m = m + 1;
         }
         i = 0;
         while(i < _itemMsg.rankingArr.length)
         {
            cardMsg = _itemMsg.rankingArr[i] as CardMsg;
            m = 0;
            while(m < _cardsSprite.numChildren)
            {
               card = _cardsSprite.getChildAt(m) as PokerCardView;
               if(card.suit == cardMsg.suit && card.rank == cardMsg.rank)
               {
                  card.alpha = 1;
               }
               m = m + 1;
            }
            m = 0;
            while(m < _poolSprite.numChildren)
            {
               card = _poolSprite.getChildAt(m) as PokerCardView;
               if(card.suit == cardMsg.suit && card.rank == cardMsg.rank)
               {
                  card.alpha = 1;
               }
               m = m + 1;
            }
            i = i + 1;
         }
         _timeId = setTimeout(function():void
         {
            clearTimeout(_timeId);
            dispose();
         },($delay + 2) * 1000);
      }
      
      private function _moveComplete(param1:Image) : void
      {
         ObjectUtils.disposeObject(param1);
         param1 = null;
      }
      
      private function dispose() : void
      {
         _poolView = null;
         _playsSprite = null;
         _cardsSprite = null;
         _poolSprite = null;
         _itemMsg = null;
      }
   }
}

