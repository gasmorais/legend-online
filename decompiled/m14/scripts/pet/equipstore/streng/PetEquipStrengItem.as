package pet.equipstore.streng
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Shape;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.MediatorMananger;
   import yishi.view.community.BaseItemView;
   
   public class PetEquipStrengItem extends BaseItemView
   {
      
      public static const P_activeStyle:String = "activeStyle";
      
      public static const P_effectStyle:String = "effectStyle";
      
      public static const NAME:String = "pet.equipstore.streng.PetEquipStrengItem";
      
      private var _activeStyle:String;
      
      private var _activeBack:MovieImage;
      
      private var _effectBack:MovieImage;
      
      private var _mediatorKey:String;
      
      private var _registed:Boolean;
      
      private var _shape:Shape;
      
      private var _effectStyle:String;
      
      public function PetEquipStrengItem()
      {
         super();
         creatHitShape();
         addChild(_shape);
         registerMediator();
      }
      
      private function creatHitShape() : void
      {
         if(!_shape)
         {
            _shape = new Shape();
         }
         _shape.graphics.beginFill(16711680,0);
         _shape.graphics.drawRect(0,0,60,60);
         _shape.graphics.endFill();
         _shape.x = 2;
         _shape.y = 2;
         _shape.blendMode = "multiply";
      }
      
      public function get activeStyle() : String
      {
         return _activeStyle;
      }
      
      public function set activeStyle(param1:String) : void
      {
         _activeStyle = param1;
         onPropertiesChanged("activeStyle");
      }
      
      public function get effectStyle() : String
      {
         return _effectStyle;
      }
      
      public function set effectStyle(param1:String) : void
      {
         _effectStyle = param1;
         onPropertiesChanged("effectStyle");
      }
      
      private function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [PetEquipStrengCellClickMediator,PetEquipStrengCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"pet.equipstore.streng.PetEquipStrengItem");
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
         if(_changedPropeties["effectStyle"])
         {
            _effectBack = ComponentFactory.Instance.creatComponentByStylename(_effectStyle);
            _effectBack.mouseChildren = false;
            _effectBack.mouseEnabled = false;
            _effectBack.movie.stop();
            _effectBack.visible = false;
         }
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
      
      override public function set data(param1:GoodsInfo) : void
      {
         SoundManager.instance.play("024",true);
         super.data = param1;
         if(param1 && param1.mouldGrade >= param1.templateInfo.StrengthenMax)
         {
            _strengthenIcon.visible = true;
         }
         else
         {
            _strengthenIcon.visible = false;
         }
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
      
      public function setSelectedEff() : void
      {
         _effectBack.visible = true;
         _effectBack.movie.play();
      }
      
      public function setNotSelectedEff() : void
      {
         _effectBack.visible = false;
         _effectBack.movie.stop();
      }
      
      override public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         ObjectUtils.disposeObject(_activeBack);
         _activeBack = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

