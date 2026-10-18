package cell.view.consortiabag
{
   import cell.mediator.consortiabag.ConsortiaCaseCellClickMediator;
   import cell.mediator.consortiabag.ConsortiaCaseCellDropMediator;
   import cell.mediator.playerbag.PlayerBagCellLightMediator;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.MediatorMananger;
   import yishi.view.community.BaseItemView;
   
   public class ConsortiaCaseCell extends BaseItemView
   {
      
      public static const P_lock:String = "lock";
      
      public static const NAME:String = "cell.view.consortiabag.ConsortiaCaseCell";
      
      private var _lockStyle:String;
      
      private var _isLock:Boolean;
      
      private var _lockIcon:ScaleFrameImage;
      
      private var _mediatorKey:String;
      
      public var _registed:Boolean;
      
      public function ConsortiaCaseCell()
      {
         super();
      }
      
      public function set lockStyle(param1:String) : void
      {
         _lockStyle = param1;
         onPropertiesChanged("lock");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["lock"])
         {
            _lockIcon = ComponentFactory.Instance.creatComponentByStylename(_lockStyle);
         }
      }
      
      override protected function addChildren() : void
      {
         if(_back)
         {
            addChild(_back);
         }
         if(_lockIcon)
         {
            addChild(_lockIcon);
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
         if(_fashionImage)
         {
            addChild(_fashionImage);
         }
         if(_fashionText)
         {
            addChild(_fashionText);
         }
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         super.data = param1;
         mouseEnabled = true;
         mouseChildren = true;
         setNormalFilter();
         if(!_registed)
         {
            registerMediator();
         }
      }
      
      private function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [ConsortiaCaseCellClickMediator,ConsortiaCaseCellDropMediator,PlayerBagCellLightMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"cell.view.consortiabag.ConsortiaCaseCell");
      }
      
      public function get isLock() : Boolean
      {
         return _isLock;
      }
      
      public function set isLock(param1:Boolean) : void
      {
         _isLock = param1;
         if(!_lockIcon)
         {
            return;
         }
         if(_isLock)
         {
            _lockIcon.setFrame(1);
         }
         else
         {
            _lockIcon.setFrame(2);
         }
      }
      
      override public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         ObjectUtils.disposeObject(_lockIcon);
         _lockIcon = null;
         super.dispose();
      }
   }
}

