package pet.advanced.equipbag
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.MediatorMananger;
   import yishi.manager.NotificationManager;
   import yishi.view.community.BaseItemView;
   
   public class PetEquipCell extends BaseItemView
   {
      
      public static const P_activeStyle:String = "activeStyle";
      
      public static const P_effectStyle:String = "effectStyle";
      
      public static const NAME:String = "pet.advanced.equipbag.PetEquipCell";
      
      protected var _activeStyle:String;
      
      protected var _activeBack:MovieImage;
      
      private var _effectStyle:String;
      
      protected var _effectBack:MovieImage;
      
      protected var _registed:Boolean;
      
      protected var _acceptDrop:Boolean;
      
      protected var _mediatorKey:String;
      
      protected var _sonType:int;
      
      protected var _shape:Sprite;
      
      public var preTemp:int;
      
      private var _canDrag:Boolean;
      
      public function PetEquipCell()
      {
         super();
         bagType = 26;
         createShape();
         addChild(_shape);
      }
      
      private function createShape() : void
      {
         if(!_shape)
         {
            _shape = new Sprite();
         }
         _shape.graphics.beginFill(16711680,0);
         _shape.graphics.drawRect(0,0,41,41);
         _shape.graphics.endFill();
         _shape.x = 2;
         _shape.y = 2;
         _shape.blendMode = "multiply";
         _shape.buttonMode = true;
         _shape.addEventListener("click",__ClickHandler);
      }
      
      public function set activeStyle(param1:String) : void
      {
         _activeStyle = param1;
         onPropertiesChanged("activeStyle");
      }
      
      public function set effectStyle(param1:String) : void
      {
         _effectStyle = param1;
         onPropertiesChanged("effectStyle");
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_activeBack)
         {
            addChild(_activeBack);
         }
         if(_effectBack)
         {
            addChild(_effectBack);
         }
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
         if(_changedPropeties["effectStyle"])
         {
            _effectBack = ComponentFactory.Instance.creatComponentByStylename(_effectStyle);
            _effectBack.visible = false;
            _effectBack.movie.gotoAndStop(1);
            _effectBack.mouseChildren = false;
            _effectBack.mouseChildren = false;
         }
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         if(data)
         {
            preTemp = data.id;
         }
         else
         {
            preTemp = 0;
         }
         super.data = param1;
         mouseEnabled = true;
         mouseChildren = true;
         setNormalFilter();
         if(data && data.mouldGrade >= data.templateInfo.StrengthenMax)
         {
            _strengthenIcon.visible = true;
         }
         else
         {
            _strengthenIcon.visible = false;
         }
         if(!_registed && _canDrag)
         {
            registerMediator();
         }
      }
      
      public function set canDrag(param1:Boolean) : void
      {
         _canDrag = param1;
         _shape.buttonMode = param1;
      }
      
      private function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [PetEquipBagCellDropMediator,PetEquipBagCellClickMediator,PetEquipBagCellLightMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"pet.advanced.equipbag.PetEquipCell");
      }
      
      private function unRegisterMediator() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      public function setNormal() : void
      {
         if(_activeBack)
         {
            _activeBack.visible = false;
            _activeBack.movie.stop();
         }
      }
      
      public function setFocus() : void
      {
         if(_activeBack)
         {
            _activeBack.visible = true;
            _activeBack.movie.play();
         }
      }
      
      public function set sonType(param1:int) : void
      {
         _sonType = param1;
      }
      
      public function get sonType() : int
      {
         return _sonType;
      }
      
      public function setSelectedEff() : void
      {
         if(_effectBack)
         {
            _effectBack.visible = true;
            _effectBack.movie.play();
         }
      }
      
      public function setNotSelectedEff() : void
      {
         if(_effectBack)
         {
            _effectBack.visible = false;
            _effectBack.movie.stop();
         }
      }
      
      private function __ClickHandler(param1:MouseEvent) : void
      {
         if(!data)
         {
            NotificationManager.instance.sendNotification("SHOWPETBAG");
         }
      }
      
      override public function dispose() : void
      {
         if(_shape)
         {
            _shape.removeEventListener("click",__ClickHandler);
         }
         unRegisterMediator();
         ObjectUtils.disposeObject(_activeBack);
         _activeBack = null;
         _acceptDrop = false;
         super.dispose();
      }
   }
}

