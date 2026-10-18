package cell.view.bag
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.MediatorMananger;
   
   public class RuneBagCell extends BaseBagCell
   {
      
      public static const NAME:String = "cell.view.bag.RuneBagCell";
      
      public static const P_suitStyle:String = "suitStyle";
      
      protected var _mediatorKey:String;
      
      protected var _registed:Boolean;
      
      private var _suitStyle:String;
      
      private var _suitBit:ScaleFrameImage;
      
      private var _registerMediatorFun:Function;
      
      private var _dataFun:Function;
      
      private var _isSuit:Boolean;
      
      public function RuneBagCell(param1:Function = null, param2:Function = null)
      {
         super();
         _dataFun = param1;
         _registerMediatorFun = param2;
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         if(data != param1)
         {
            setNormalFilter();
         }
         super.data = param1;
         if(param1)
         {
            lock = param1.isLock;
         }
         else
         {
            lock = false;
         }
         mouseEnabled = true;
         mouseChildren = true;
         if(_dataFun != null)
         {
            _dataFun.call(null,this,param1);
         }
         if(!_registed)
         {
            _registed = true;
            if(_registerMediatorFun != null)
            {
               _registerMediatorFun.call(null,this);
            }
         }
      }
      
      protected function unregisterMediator() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      public function get suitStyle() : String
      {
         return _suitStyle;
      }
      
      public function set suitStyle(param1:String) : void
      {
         if(_suitStyle == param1)
         {
            return;
         }
         _suitStyle = param1;
         onPropertiesChanged("suitStyle");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["suitStyle"])
         {
            _lockImg = ComponentFactory.Instance.creatComponentByStylename(_suitStyle);
            _suitBit.setFrame(1);
            _suitBit.mouseChildren = false;
            _suitBit.mouseEnabled = false;
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_suitBit)
         {
            addChild(_suitBit);
         }
      }
      
      override public function dispose() : void
      {
         unregisterMediator();
         ObjectUtils.disposeObject(_suitBit);
         _suitBit = null;
         super.dispose();
         _dataFun = null;
         _registerMediatorFun = null;
      }
      
      public function get isSuit() : Boolean
      {
         return _isSuit;
      }
      
      public function set isSuit(param1:Boolean) : void
      {
         _isSuit = param1;
         _suitBit.visible = _isSuit;
      }
   }
}

