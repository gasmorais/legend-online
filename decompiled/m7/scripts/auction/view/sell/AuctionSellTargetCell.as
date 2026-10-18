package auction.view.sell
{
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.MediatorMananger;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   
   [Event(name="change",type="flash.events.Event")]
   public class AuctionSellTargetCell extends BaseItemView
   {
      
      public static const P_activeStyle:String = "activeStyle";
      
      public static const P_textIcon:String = "textIcon";
      
      public static const EQUIP:int = -1;
      
      public static const NAME:String = "auction.view.sell.AuctionSellTargetCell";
      
      private var _activeStyle:String;
      
      private var _hitBack:Sprite;
      
      private var _textIconStyle:String;
      
      public var sonType:int;
      
      public var resetTip:String;
      
      private var _mediatorKey:String;
      
      private var _registed:Boolean;
      
      private var _blinkMc:MovieClip;
      
      public function AuctionSellTargetCell()
      {
         super();
         bagType = 0;
         pos = 0;
         setNormal();
         registerMediator();
         this.buttonMode = true;
      }
      
      public function set activeStyle(param1:String) : void
      {
         _activeStyle = param1;
         onPropertiesChanged("activeStyle");
      }
      
      public function set textIconStyle(param1:String) : void
      {
         _textIconStyle = param1;
         onPropertiesChanged("textIcon");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
      }
      
      override protected function addChildren() : void
      {
         _hitBack = new Sprite();
         _hitBack.graphics.beginFill(0,0);
         _hitBack.graphics.drawRect(0,0,63,63);
         _hitBack.graphics.endFill();
         addChild(_hitBack);
         if(_back)
         {
            addChild(_back);
         }
         if(_icon)
         {
            addChild(_icon);
         }
         if(_profile)
         {
            addChild(_profile);
         }
         if(_itemText)
         {
            addChild(_itemText);
         }
         if(_strengthenIcon)
         {
            addChild(_strengthenIcon);
         }
      }
      
      protected function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [SellTargetCellClickMediator,SellTargetCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"auction.view.sell.AuctionSellTargetCell");
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         SoundManager.instance.play("024",true);
         super.data = param1;
         dispatchEvent(new Event("change"));
         if(data)
         {
            this.buttonMode = false;
         }
         else
         {
            this.buttonMode = true;
         }
      }
      
      override protected function setTipStyle(param1:GoodsTemplateInfo) : void
      {
         if(!StringHelper.isNullOrEmpty(resetTip))
         {
            icon.tipStyle = resetTip;
         }
         else
         {
            super.setTipStyle(param1);
         }
      }
      
      override public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         super.dispose();
      }
      
      public function setNormal() : void
      {
      }
      
      public function setFocus() : void
      {
      }
      
      public function setNumText(param1:int) : void
      {
         if(param1)
         {
            _itemText.text = param1 + "";
         }
         else
         {
            _itemText.text = "";
         }
      }
   }
}

