package cell.view.storebag
{
   import cell.mediator.storebag.IntensifyBagCellClickMediator;
   import cell.mediator.storebag.IntensifyBagCellDropMediator;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.StoreEvent;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.MediatorMananger;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   
   public class StoreIntensifyCell extends BaseItemView
   {
      
      public static const P_activeStyle:String = "activeStyle";
      
      public static const P_textIcon:String = "textIcon";
      
      public static const EQUIP:int = -1;
      
      public static const NAME:String = "cell.view.storebag.StoreIntensifyCell";
      
      private var _activeStyle:String;
      
      private var _textIconStyle:String;
      
      private var _text:Image;
      
      private var _activeBack:MovieImage;
      
      public var sonType:int;
      
      public var resetTip:String;
      
      private var _mediatorKey:String;
      
      private var _registed:Boolean;
      
      public function StoreIntensifyCell()
      {
         relativeLockPos = 10;
         super();
         bagType = 0;
         pos = 0;
         setNormal();
         registerMediator();
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
         if(_changedPropeties["activeStyle"])
         {
            _activeBack = ComponentFactory.Instance.creatComponentByStylename(_activeStyle);
            _activeBack.mouseChildren = false;
            _activeBack.mouseEnabled = false;
            _activeBack.movie.gotoAndStop(1);
            _activeBack.visible = false;
         }
         if(_changedPropeties["textIcon"])
         {
            _text = ComponentFactory.Instance.creatComponentByStylename(_textIconStyle);
         }
      }
      
      override protected function addChildren() : void
      {
         if(_back)
         {
            addChild(_back);
         }
         if(_text)
         {
            addChild(_text);
         }
         if(_icon)
         {
            addChild(_icon);
         }
         if(_activeBack)
         {
            addChild(_activeBack);
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
         var _loc1_:Array = [IntensifyBagCellClickMediator,IntensifyBagCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"cell.view.storebag.StoreIntensifyCell");
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         SoundManager.instance.play("024",true);
         super.data = param1;
         dispatchEvent(new StoreEvent("UPDATA_ITEM_DATA"));
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
         ObjectUtils.disposeObject(_text);
         _text = null;
         ObjectUtils.disposeObject(_activeBack);
         _activeBack = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
      
      public function setNormal() : void
      {
         if(_activeBack)
         {
            _activeBack.visible = false;
            _activeBack.movie.gotoAndStop(1);
         }
      }
      
      public function setFocus() : void
      {
         if(_activeBack)
         {
            _activeBack.visible = true;
            _activeBack.movie.gotoAndPlay(1);
         }
      }
   }
}

