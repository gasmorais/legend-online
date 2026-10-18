package map.campaign.view.ui.airgarden.game.memorycard
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import managers.AirGardenMemoryCardManager;
   import mvc.module.airgarden.game.MemoryCardData;
   import mvc.module.airgarden.game.MemoryCardModel;
   
   public class AirGardenGameMemoryCardItem extends Component
   {
      
      private var bg:ScaleFrameImage;
      
      private var icon:ScaleFrameImage;
      
      public var index:int;
      
      private var t:Number = 0.2;
      
      private var _data:MemoryCardData;
      
      public var isClickFlip:Boolean = false;
      
      private var _isResultOpen:Boolean = false;
      
      public var justShow:Boolean = false;
      
      public function AirGardenGameMemoryCardItem(param1:int)
      {
         super();
         this.index = param1;
         initView();
      }
      
      private function initView() : void
      {
         bg = ComponentFactory.Instance.creatComponentByStylename("airGarden.memorycard.bg");
         icon = ComponentFactory.Instance.creatComponentByStylename("airGarden.memorycard.icon");
         bg.x -= icon.width / 2;
         icon.x -= icon.width / 2;
         addChild(bg);
         addChild(icon);
         buttonMode = true;
         icon.visible = false;
         bg.setFrame(1);
      }
      
      public function set data(param1:MemoryCardData) : void
      {
         _data = param1;
         icon.setFrame(param1.type);
      }
      
      public function reset() : void
      {
         icon.visible = false;
         bg.setFrame(1);
         buttonMode = true;
         removeEvent();
         initEvent();
      }
      
      private function initEvent() : void
      {
         addEventListener("click",onClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",onClick);
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(model.openCards.length == 1 && model.openCards[0] == this)
         {
            return;
         }
         if(!model.lock)
         {
            isClickFlip = true;
            flip();
            model.openCards.push(this);
            if(model.openCards.length >= 2)
            {
               model.secondIndex = index;
               model.lock = true;
            }
         }
      }
      
      public function flip(param1:Number = 0) : void
      {
         if(isClickFlip)
         {
            bg.setFrame(1);
            icon.visible = false;
         }
         else
         {
            bg.setFrame(2);
            icon.visible = true;
         }
         TweenLite.to(this,t,{
            "scaleX":0,
            "onComplete":onBack,
            "delay":param1
         });
      }
      
      private function onBack() : void
      {
         if(isClickFlip)
         {
            bg.setFrame(2);
            icon.visible = true;
         }
         else
         {
            bg.setFrame(1);
            icon.visible = false;
         }
         TweenLite.to(this,t,{
            "scaleX":1,
            "onComplete":onBackComplete
         });
      }
      
      private function onBackComplete() : void
      {
         if(isClickFlip)
         {
            isClickFlip = false;
            if(model.openCards.length >= 2 && index == model.secondIndex)
            {
               m.sendFlip(model.openCards[0].index,model.openCards[1].index);
            }
         }
         if(justShow)
         {
            justShow = false;
            flip(2);
         }
      }
      
      public function get isResultOpen() : Boolean
      {
         return _isResultOpen;
      }
      
      public function set isResultOpen(param1:Boolean) : void
      {
         _isResultOpen = param1;
         if(_isResultOpen)
         {
            removeEvent();
            buttonMode = false;
         }
      }
      
      public function get model() : MemoryCardModel
      {
         return AirGardenMemoryCardManager.instance.model;
      }
      
      public function get m() : AirGardenMemoryCardManager
      {
         return AirGardenMemoryCardManager.instance;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         TweenLite.killTweensOf(this);
         ObjectUtils.disposeObject(bg);
         bg = null;
         ObjectUtils.disposeObject(icon);
         icon = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

