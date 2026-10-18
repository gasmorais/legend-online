package cell.view.playerbag
{
   import cell.mediator.playerbag.OpenGridMediator;
   import cell.mediator.playerbag.PlayerBagCellClickMediator;
   import cell.mediator.playerbag.PlayerBagCellDropMediator;
   import cell.mediator.playerbag.PlayerBagCellLightMediator;
   import cell.view.bag.BaseBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.MediatorMananger;
   
   public class PlayerBagCell extends BaseBagCell
   {
      
      public static const P_activeStyle:String = "activeStyle";
      
      public static const NAME:String = "cell.view.playerbag.PlayerBagCell";
      
      protected var _mediatorKey:String;
      
      protected var _registed:Boolean;
      
      protected var _activeBack:MovieImage;
      
      private var _activeStyle:String;
      
      public function PlayerBagCell()
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
         if(data != param1)
         {
            setNormalFilter();
         }
         super.data = param1;
         mouseEnabled = true;
         mouseChildren = true;
         if(!_registed)
         {
            registerMediator();
         }
         var _loc2_:Boolean = param1 && param1.templateInfo && param1.templateInfo.SonType == 609 && !param1.isTodayUsed;
         if(param1 && param1.templateInfo && _activeBack && (param1.templateInfo.SonType == 298 || _loc2_))
         {
            showEffect();
         }
         else
         {
            stopEffect();
         }
         if(param1 && param1.templateInfo.MasterType == 5)
         {
            if(param1.templateInfo.StrengthenMax <= param1.mouldGrade)
            {
               _strengthenIcon.visible = true;
            }
            else
            {
               _strengthenIcon.visible = false;
            }
         }
      }
      
      protected function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [PlayerBagCellLightMediator,OpenGridMediator,PlayerBagCellDropMediator,PlayerBagCellClickMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"cell.view.playerbag.PlayerBagCell");
      }
      
      protected function unregisterMediator() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
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
         if(_activeBack && (!data || data.templateInfo && data.templateInfo.SonType != 298 && data.templateInfo.SonType != 609))
         {
            _activeBack.visible = false;
            _activeBack.movie.stop();
         }
      }
      
      override public function dispose() : void
      {
         unregisterMediator();
         if(_activeBack)
         {
            ObjectUtils.disposeObject(_activeBack);
            _activeBack = null;
         }
         super.dispose();
      }
   }
}

