package cell.view.consortiabag
{
   import cell.mediator.consortiabag.ConsortiaBagDoubleClickMediator;
   import cell.mediator.consortiabag.ConsortiaBagDropMediator;
   import cell.mediator.playerbag.OpenGridMediator;
   import cell.mediator.playerbag.PlayerBagCellLightMediator;
   import cell.view.bag.BaseBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MovieImage;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.MediatorMananger;
   
   public class ConsortiaBagCell extends BaseBagCell
   {
      
      public static const P_activeStyle:String = "activeStyle";
      
      public static const NAME:String = "cell.view.consortiabag.ConsortiaBagCell";
      
      public var canDoubleClick:Boolean = true;
      
      private var _registed:Boolean;
      
      private var _mediatorKey:String;
      
      protected var _activeBack:MovieImage;
      
      private var _activeStyle:String;
      
      public function ConsortiaBagCell()
      {
         super();
      }
      
      public function set activeStyle(param1:String) : void
      {
         _activeStyle = param1;
         onPropertiesChanged("activeStyle");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["activeStyle"])
         {
            _activeBack = ComponentFactory.Instance.creatComponentByStylename(_activeStyle);
            _activeBack.visible = false;
            _activeBack.movie.gotoAndStop(1);
            _activeBack.mouseChildren = false;
            _activeBack.mouseEnabled = false;
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_activeBack)
         {
            addChild(_activeBack);
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
         if(param1 && param1.templateInfo.SonType == 298 && _activeBack)
         {
            showEffect();
         }
         else
         {
            stopEffect();
         }
      }
      
      private function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [OpenGridMediator,ConsortiaBagDropMediator,ConsortiaBagDoubleClickMediator,PlayerBagCellLightMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"cell.view.consortiabag.ConsortiaBagCell");
      }
      
      public function showEffect() : void
      {
         if(_activeBack)
         {
            _activeBack.visible = true;
            _activeBack.movie.play();
         }
      }
      
      public function stopEffect() : void
      {
         if(_activeBack && (!data || data.templateInfo.SonType != 298))
         {
            _activeBack.visible = false;
            _activeBack.movie.stop();
         }
      }
      
      override public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         super.dispose();
      }
      
      override public function checkGoodsByHero(param1:Boolean = true) : Boolean
      {
         return true;
      }
   }
}

